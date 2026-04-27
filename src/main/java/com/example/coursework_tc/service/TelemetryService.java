package com.example.coursework_tc.service;

import com.example.coursework_tc.model.TelemetryPoint;
import com.example.coursework_tc.model.enums.TelemetrySource;

import java.time.LocalDateTime;
import java.util.List;

public interface TelemetryService {

    TelemetryPoint recordPoint(
            Long vehicleId,
            double latitude,
            double longitude,
            LocalDateTime recordedAt,
            Double speedKmh,
            TelemetrySource source
    );

    List<TelemetryPoint> findRecentPointsForVehicle(Long vehicleId, int limit);
}
