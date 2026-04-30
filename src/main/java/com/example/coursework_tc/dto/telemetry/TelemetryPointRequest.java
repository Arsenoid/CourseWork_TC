package com.example.coursework_tc.dto.telemetry;

import com.example.coursework_tc.model.enums.TelemetrySource;
import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;

import java.time.Instant;

public record TelemetryPointRequest(
        @NotNull Long vehicleId,
        @NotNull @Min(-90) @Max(90) Double latitude,
        @NotNull @Min(-180) @Max(180) Double longitude,
        Instant recordedAt,
        Double speedKmh,
        @NotNull TelemetrySource source,
        Long sessionId
) {
}
