package com.example.coursework_tc.dto.telemetry;

import com.example.coursework_tc.model.TelemetryPoint;
import com.example.coursework_tc.model.enums.TelemetrySource;

import java.time.Instant;

public record TelemetryPointResponse(
        Long id,
        Long vehicleId,
        Long sessionId,
        Double latitude,
        Double longitude,
        Instant recordedAt,
        Double speedKmh,
        TelemetrySource source
) {
    public static TelemetryPointResponse from(TelemetryPoint point) {
        return new TelemetryPointResponse(
                point.getId(),
                point.getVehicle().getId(),
                point.getSession() != null ? point.getSession().getId() : null,
                point.getLatitude(),
                point.getLongitude(),
                point.getRecordedAt(),
                point.getSpeedKmh(),
                point.getSource()
        );
    }
}
