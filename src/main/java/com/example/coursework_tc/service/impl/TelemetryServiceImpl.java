package com.example.coursework_tc.service.impl;

import com.example.coursework_tc.exception.TelemetryValidationException;
import com.example.coursework_tc.exception.VehicleNotFoundException;
import com.example.coursework_tc.model.TelemetryPoint;
import com.example.coursework_tc.model.Vehicle;
import com.example.coursework_tc.model.enums.TelemetrySource;
import com.example.coursework_tc.repository.TelemetryPointRepository;
import com.example.coursework_tc.repository.VehicleRepository;
import com.example.coursework_tc.service.TelemetryService;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
@RequiredArgsConstructor
public class TelemetryServiceImpl implements TelemetryService {

    private static final double MIN_LATITUDE = -90.0;
    private static final double MAX_LATITUDE = 90.0;
    private static final double MIN_LONGITUDE = -180.0;
    private static final double MAX_LONGITUDE = 180.0;

    private final TelemetryPointRepository telemetryPointRepository;
    private final VehicleRepository vehicleRepository;

    @Override
    @Transactional
    public TelemetryPoint recordPoint(
            Long vehicleId,
            double latitude,
            double longitude,
            LocalDateTime recordedAt,
            Double speedKmh,
            TelemetrySource source
    ) {
        validateCoordinates(latitude, longitude);

        if (source == null) {
            throw new TelemetryValidationException("Telemetry source is required");
        }

        Vehicle vehicle = vehicleRepository.findById(vehicleId)
                .orElseThrow(() -> new VehicleNotFoundException(vehicleId));

        LocalDateTime ts = recordedAt != null ? recordedAt : LocalDateTime.now();

        TelemetryPoint point = new TelemetryPoint();
        point.setVehicle(vehicle);
        point.setLatitude(latitude);
        point.setLongitude(longitude);
        point.setRecordedAt(ts);
        point.setSpeedKmh(speedKmh);
        point.setSource(source);

        TelemetryPoint saved = telemetryPointRepository.save(point);

        vehicle.setLastLatitude(latitude);
        vehicle.setLastLongitude(longitude);
        vehicle.setLastTelemetryAt(ts);
        vehicleRepository.save(vehicle);

        return saved;
    }

    private void validateCoordinates(double latitude, double longitude) {
        if (latitude < MIN_LATITUDE || latitude > MAX_LATITUDE) {
            throw new TelemetryValidationException("Latitude must be in range [-90, 90]");
        }
        if (longitude < MIN_LONGITUDE || longitude > MAX_LONGITUDE) {
            throw new TelemetryValidationException("Longitude must be in range [-180, 180]");
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
}
