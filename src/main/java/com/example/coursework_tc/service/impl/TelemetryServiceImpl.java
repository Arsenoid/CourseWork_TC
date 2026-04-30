package com.example.coursework_tc.service.impl;

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
import com.example.coursework_tc.service.TelemetryService;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import java.time.Instant;
import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
public class TelemetryServiceImpl implements TelemetryService {

    private static final double MIN_LATITUDE = -90.0;
    private static final double MAX_LATITUDE = 90.0;
    private static final double MIN_LONGITUDE = -180.0;
    private static final double MAX_LONGITUDE = 180.0;

    private final TelemetryPointRepository telemetryPointRepository;
    private final TrackingSessionRepository trackingSessionRepository;
    private final VehicleRepository vehicleRepository;

    @Override
    @Transactional
    public TelemetryPoint recordPoint(
            Long vehicleId,
            double latitude,
            double longitude,
            Instant recordedAt,
            Double speedKmh,
            TelemetrySource source,
            Long sessionId
    ) {
        try {
            validateCoordinates(latitude, longitude);

            if (source == null) {
                throw new TelemetryValidationException("Telemetry source is required");
            }

            Vehicle vehicle = vehicleRepository.findById(vehicleId)
                    .orElseThrow(() -> new VehicleNotFoundException(vehicleId));

            Instant ts = recordedAt != null ? recordedAt : Instant.now();

            TelemetryPoint point = new TelemetryPoint();
            point.setVehicle(vehicle);
            point.setLatitude(latitude);
            point.setLongitude(longitude);
            point.setRecordedAt(ts);
            point.setSpeedKmh(speedKmh);
            point.setSource(source);

            if (sessionId != null) {
                TrackingSession session = trackingSessionRepository.findById(sessionId)
                        .orElseThrow(() -> new SessionNotFoundException(sessionId));
                point.setSession(session);
            }

            TelemetryPoint saved = telemetryPointRepository.save(point);

            vehicle.setLastLatitude(latitude);
            vehicle.setLastLongitude(longitude);
            vehicle.setLastTelemetryAt(ts);
            vehicleRepository.save(vehicle);

            return saved;
        } catch (TelemetryValidationException | VehicleNotFoundException | SessionNotFoundException e) {
            log.warn("Telemetry record failed: vehicleId={}, source={}, ts={}, reason={}",
                    vehicleId, source, recordedAt, e.getMessage());
            throw e;
        }
    }

    @Override
    @Transactional(Transactional.TxType.SUPPORTS)
    public List<TelemetryPoint> findRecentPointsForVehicle(Long vehicleId, int limit) {
        int safeLimit = Math.clamp(limit, 1, 500);
        return telemetryPointRepository.findByVehicleIdOrderByRecordedAtDesc(
                vehicleId,
                PageRequest.of(0, safeLimit)
        );
    }

    @Override
    @Transactional(Transactional.TxType.SUPPORTS)
    public List<TelemetryPoint> findPointsBySession(Long sessionId) {
        return telemetryPointRepository.findBySessionIdOrderByRecordedAtAsc(sessionId);
    }

    private void validateCoordinates(double latitude, double longitude) {
        if (latitude < MIN_LATITUDE || latitude > MAX_LATITUDE) {
            throw new TelemetryValidationException("Latitude must be in range [-90, 90]");
        }
        if (longitude < MIN_LONGITUDE || longitude > MAX_LONGITUDE) {
            throw new TelemetryValidationException("Longitude must be in range [-180, 180]");
        }
    }
}
