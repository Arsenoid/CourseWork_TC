package com.example.coursework_tc.dto.telemetry;

import com.example.coursework_tc.model.TelemetryPoint;
import com.example.coursework_tc.model.enums.TelemetrySource;

import java.time.LocalDateTime;

public record TelemetryPointResponse(
        Long id,
        Long vehicleId,
        Double latitude,
        Double longitude,
        LocalDateTime recordedAt,
        Double speedKmh,
        TelemetrySource source
) {
    public static TelemetryPointResponse from(TelemetryPoint telemetryPoint) {
        return new TelemetryPointResponse(
                telemetryPoint.getId(),
                telemetryPoint.getVehicle().getId(),
                telemetryPoint.getLatitude(),
                telemetryPoint.getLongitude(),
                telemetryPoint.getRecordedAt(),
                telemetryPoint.getSpeedKmh(),
                telemetryPoint.getSource()
        );
    }
}
