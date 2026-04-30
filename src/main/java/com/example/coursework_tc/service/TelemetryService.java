package com.example.coursework_tc.service;

import com.example.coursework_tc.model.TelemetryPoint;
import com.example.coursework_tc.model.enums.TelemetrySource;

import java.time.Instant;
import java.util.List;

public interface TelemetryService {

    TelemetryPoint recordPoint(
            Long vehicleId,
            double latitude,
            double longitude,
            Instant recordedAt,
            Double speedKmh,
            TelemetrySource source,
            Long sessionId
    );

    List<TelemetryPoint> findRecentPointsForVehicle(Long vehicleId, int limit);

    List<TelemetryPoint> findPointsBySession(Long sessionId);
}
