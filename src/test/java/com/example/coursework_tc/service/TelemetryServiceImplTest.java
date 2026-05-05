package com.example.coursework_tc.service;

import com.example.coursework_tc.exception.SessionNotFoundException;
import com.example.coursework_tc.exception.TelemetryValidationException;
import com.example.coursework_tc.exception.VehicleNotFoundException;
import com.example.coursework_tc.model.TelemetryPoint;
import com.example.coursework_tc.model.TrackingSession;
import com.example.coursework_tc.model.Vehicle;
import com.example.coursework_tc.model.enums.TelemetrySource;
import com.example.coursework_tc.repository.TelemetryPointRepository;
import com.example.coursework_tc.repository.TrackingSessionRepository;
import com.example.coursework_tc.repository.VehicleRepository;
import com.example.coursework_tc.service.impl.TelemetryServiceImpl;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.CsvSource;
import org.mockito.ArgumentCaptor;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.data.domain.PageRequest;

import java.time.Instant;
import java.util.List;
import java.util.Optional;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.BDDMockito.given;
import static org.mockito.BDDMockito.then;

@ExtendWith(MockitoExtension.class)
class TelemetryServiceImplTest {

    @Mock TelemetryPointRepository telemetryPointRepository;
    @Mock TrackingSessionRepository trackingSessionRepository;
    @Mock VehicleRepository vehicleRepository;

    @InjectMocks TelemetryServiceImpl service;

    private Vehicle vehicle;

    @BeforeEach
    void setUp() {
        vehicle = new Vehicle();
        vehicle.setId(1L);
    }

    // ── recordPoint: успешная запись ─────────────────────────────────────────

    @Test
    void recordPoint_success_savesPointAndUpdatesVehicle() {
        given(vehicleRepository.findById(1L)).willReturn(Optional.of(vehicle));
        TelemetryPoint saved = new TelemetryPoint();
        saved.setId(10L);
        saved.setVehicle(vehicle);
        given(telemetryPointRepository.save(any())).willReturn(saved);
        given(vehicleRepository.save(any())).willReturn(vehicle);

        Instant ts = Instant.parse("2026-05-04T10:00:00Z");
        TelemetryPoint result = service.recordPoint(1L, 55.75, 37.62, ts, 60.0, TelemetrySource.BROWSER, null);

        assertThat(result.getId()).isEqualTo(10L);

        ArgumentCaptor<TelemetryPoint> pointCaptor = ArgumentCaptor.forClass(TelemetryPoint.class);
        then(telemetryPointRepository).should().save(pointCaptor.capture());
        TelemetryPoint captured = pointCaptor.getValue();
        assertThat(captured.getLatitude()).isEqualTo(55.75);
        assertThat(captured.getLongitude()).isEqualTo(37.62);
        assertThat(captured.getRecordedAt()).isEqualTo(ts);
        assertThat(captured.getSource()).isEqualTo(TelemetrySource.BROWSER);

        assertThat(vehicle.getLastLatitude()).isEqualTo(55.75);
        assertThat(vehicle.getLastLongitude()).isEqualTo(37.62);
        assertThat(vehicle.getLastTelemetryAt()).isEqualTo(ts);
        then(vehicleRepository).should().save(vehicle);
    }

    @Test
    void recordPoint_usesNowWhenRecordedAtIsNull() {
        given(vehicleRepository.findById(1L)).willReturn(Optional.of(vehicle));
        given(telemetryPointRepository.save(any())).willAnswer(inv -> inv.getArgument(0));
        given(vehicleRepository.save(any())).willReturn(vehicle);

        Instant before = Instant.now();
        TelemetryPoint result = service.recordPoint(1L, 0.0, 0.0, null, null, TelemetrySource.SIMULATOR, null);
        Instant after = Instant.now();

        assertThat(result.getRecordedAt()).isBetween(before, after);
    }

    @Test
    void recordPoint_linksSession_whenSessionIdProvided() {
        TrackingSession session = new TrackingSession();
        session.setId(42L);
        given(vehicleRepository.findById(1L)).willReturn(Optional.of(vehicle));
        given(trackingSessionRepository.findById(42L)).willReturn(Optional.of(session));
        given(telemetryPointRepository.save(any())).willAnswer(inv -> inv.getArgument(0));
        given(vehicleRepository.save(any())).willReturn(vehicle);

        TelemetryPoint result = service.recordPoint(1L, 55.75, 37.62, null, null, TelemetrySource.BROWSER, 42L);

        assertThat(result.getSession()).isSameAs(session);
    }

    // ── recordPoint: невалидные координаты ───────────────────────────────────

    @ParameterizedTest(name = "lat={0}, lon={1}")
    @CsvSource({
        "-91.0,   0.0",
        " 91.0,   0.0",
        "  0.0, -181.0",
        "  0.0,  181.0"
    })
    void recordPoint_throwsTelemetryValidationException_whenCoordinatesOutOfRange(double lat, double lon) {
        assertThatThrownBy(() -> service.recordPoint(1L, lat, lon, null, null, TelemetrySource.BROWSER, null))
                .isInstanceOf(TelemetryValidationException.class);
        then(vehicleRepository).shouldHaveNoInteractions();
    }

    @Test
    void recordPoint_throwsTelemetryValidationException_whenSourceIsNull() {
        assertThatThrownBy(() -> service.recordPoint(1L, 0.0, 0.0, null, null, null, null))
                .isInstanceOf(TelemetryValidationException.class)
                .hasMessageContaining("source");
        then(vehicleRepository).shouldHaveNoInteractions();
    }

    // ── recordPoint: vehicle not found ───────────────────────────────────────

    @Test
    void recordPoint_throwsVehicleNotFoundException_whenVehicleDoesNotExist() {
        given(vehicleRepository.findById(99L)).willReturn(Optional.empty());

        assertThatThrownBy(() -> service.recordPoint(99L, 0.0, 0.0, null, null, TelemetrySource.BROWSER, null))
                .isInstanceOf(VehicleNotFoundException.class)
                .hasMessageContaining("99");
        then(telemetryPointRepository).shouldHaveNoInteractions();
    }

    // ── recordPoint: session not found ───────────────────────────────────────

    @Test
    void recordPoint_throwsSessionNotFoundException_whenSessionDoesNotExist() {
        given(vehicleRepository.findById(1L)).willReturn(Optional.of(vehicle));
        given(trackingSessionRepository.findById(999L)).willReturn(Optional.empty());

        assertThatThrownBy(() -> service.recordPoint(1L, 0.0, 0.0, null, null, TelemetrySource.BROWSER, 999L))
                .isInstanceOf(SessionNotFoundException.class)
                .hasMessageContaining("999");
        then(telemetryPointRepository).shouldHaveNoInteractions();
    }

    // ── findRecentPointsForVehicle: нормализация limit ───────────────────────

    @ParameterizedTest(name = "input={0} → effectivePageSize={1}")
    @CsvSource({
        "-5,   1",
        " 0,   1",
        " 1,   1",
        "100, 100",
        "500, 500",
        "501, 500",
        "999, 500"
    })
    void findRecentPointsForVehicle_normalizesLimit(int input, int expected) {
        given(telemetryPointRepository.findByVehicleIdOrderByRecordedAtDesc(eq(1L), any()))
                .willReturn(List.of());

        service.findRecentPointsForVehicle(1L, input);

        ArgumentCaptor<PageRequest> pageCaptor = ArgumentCaptor.forClass(PageRequest.class);
        then(telemetryPointRepository).should()
                .findByVehicleIdOrderByRecordedAtDesc(eq(1L), pageCaptor.capture());
        assertThat(pageCaptor.getValue().getPageSize()).isEqualTo(expected);
    }
}
