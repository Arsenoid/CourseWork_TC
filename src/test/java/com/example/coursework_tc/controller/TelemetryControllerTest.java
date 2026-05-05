package com.example.coursework_tc.controller;

import com.example.coursework_tc.exception.TelemetryValidationException;
import com.example.coursework_tc.exception.VehicleNotFoundException;
import com.example.coursework_tc.model.TelemetryPoint;
import com.example.coursework_tc.model.Vehicle;
import com.example.coursework_tc.model.enums.TelemetrySource;
import com.example.coursework_tc.service.TelemetryService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.http.MediaType;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.test.context.bean.override.mockito.MockitoBean;
import org.springframework.test.web.servlet.MockMvc;

import java.time.Instant;
import java.util.List;

import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyDouble;
import static org.mockito.ArgumentMatchers.anyInt;
import static org.mockito.ArgumentMatchers.anyLong;
import static org.mockito.BDDMockito.given;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@WebMvcTest(TelemetryController.class)
@AutoConfigureMockMvc(addFilters = false)
class TelemetryControllerTest {

    @Autowired MockMvc mockMvc;

    @MockitoBean
    TelemetryService telemetryService;

    @SuppressWarnings("unused")
    @MockitoBean
    UserDetailsService userDetailsService;

    // ── POST /api/telemetry ───────────────────────────────────────────────────

    @Test
    void postTelemetry_validRequest_returns200WithPoint() throws Exception {
        given(telemetryService.recordPoint(anyLong(), anyDouble(), anyDouble(), any(), any(), any(), any()))
                .willReturn(stubPoint(1L, 55.75, 37.62));

        mockMvc.perform(post("/api/telemetry")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("""
                                {
                                  "vehicleId": 1,
                                  "latitude": 55.75,
                                  "longitude": 37.62,
                                  "source": "BROWSER"
                                }
                                """))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.id").value(1))
                .andExpect(jsonPath("$.vehicleId").value(1))
                .andExpect(jsonPath("$.latitude").value(55.75))
                .andExpect(jsonPath("$.longitude").value(37.62))
                .andExpect(jsonPath("$.source").value("BROWSER"));
    }

    @Test
    void postTelemetry_missingVehicleId_returns400WithValidationError() throws Exception {
        mockMvc.perform(post("/api/telemetry")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("""
                                {
                                  "latitude": 55.75,
                                  "longitude": 37.62,
                                  "source": "BROWSER"
                                }
                                """))
                .andExpect(status().isBadRequest())
                .andExpect(jsonPath("$.code").value("VALIDATION_ERROR"));
    }

    @Test
    void postTelemetry_missingSource_returns400WithValidationError() throws Exception {
        mockMvc.perform(post("/api/telemetry")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("""
                                {
                                  "vehicleId": 1,
                                  "latitude": 55.75,
                                  "longitude": 37.62
                                }
                                """))
                .andExpect(status().isBadRequest())
                .andExpect(jsonPath("$.code").value("VALIDATION_ERROR"));
    }

    @Test
    void postTelemetry_vehicleNotFound_returns404() throws Exception {
        given(telemetryService.recordPoint(anyLong(), anyDouble(), anyDouble(), any(), any(), any(), any()))
                .willThrow(new VehicleNotFoundException(99L));

        mockMvc.perform(post("/api/telemetry")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("""
                                {
                                  "vehicleId": 99,
                                  "latitude": 55.75,
                                  "longitude": 37.62,
                                  "source": "BROWSER"
                                }
                                """))
                .andExpect(status().isNotFound())
                .andExpect(jsonPath("$.code").value("VEHICLE_NOT_FOUND"))
                .andExpect(jsonPath("$.message").value("Vehicle not found: 99"));
    }

    @Test
    void postTelemetry_serviceRejectsCoordinates_returns400() throws Exception {
        given(telemetryService.recordPoint(anyLong(), anyDouble(), anyDouble(), any(), any(), any(), any()))
                .willThrow(new TelemetryValidationException("Latitude must be in range [-90, 90]"));

        mockMvc.perform(post("/api/telemetry")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("""
                                {
                                  "vehicleId": 1,
                                  "latitude": 55.75,
                                  "longitude": 37.62,
                                  "source": "BROWSER"
                                }
                                """))
                .andExpect(status().isBadRequest())
                .andExpect(jsonPath("$.code").value("TELEMETRY_VALIDATION_ERROR"));
    }

    // ── GET /api/vehicles/{id}/telemetry ─────────────────────────────────────

    @Test
    void getVehicleTelemetry_returnsListOfPoints() throws Exception {
        given(telemetryService.findRecentPointsForVehicle(anyLong(), anyInt()))
                .willReturn(List.of(stubPoint(1L, 55.75, 37.62), stubPoint(2L, 55.76, 37.63)));

        mockMvc.perform(get("/api/vehicles/1/telemetry"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.length()").value(2))
                .andExpect(jsonPath("$[0].id").value(1))
                .andExpect(jsonPath("$[1].id").value(2));
    }

    @Test
    void getVehicleTelemetry_limitExceeds500_returns400() throws Exception {
        mockMvc.perform(get("/api/vehicles/1/telemetry").param("limit", "999"))
                .andExpect(status().isBadRequest())
                .andExpect(jsonPath("$.code").value("VALIDATION_ERROR"));
    }

    // ── GET /api/sessions/{id}/points ────────────────────────────────────────

    @Test
    void getSessionPoints_returnsOrderedPoints() throws Exception {
        given(telemetryService.findPointsBySession(42L))
                .willReturn(List.of(stubPoint(1L, 55.0, 37.0), stubPoint(2L, 55.1, 37.1)));

        mockMvc.perform(get("/api/sessions/42/points"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.length()").value(2));
    }

    // ── helpers ──────────────────────────────────────────────────────────────

    private TelemetryPoint stubPoint(long id, double lat, double lon) {
        Vehicle v = new Vehicle();
        v.setId(1L);
        TelemetryPoint p = new TelemetryPoint();
        p.setId(id);
        p.setVehicle(v);
        p.setLatitude(lat);
        p.setLongitude(lon);
        p.setRecordedAt(Instant.parse("2026-05-04T10:00:00Z"));
        p.setSource(TelemetrySource.BROWSER);
        return p;
    }
}
