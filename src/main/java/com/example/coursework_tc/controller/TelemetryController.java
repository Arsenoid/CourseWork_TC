package com.example.coursework_tc.controller;

import com.example.coursework_tc.dto.telemetry.TelemetryPointRequest;
import com.example.coursework_tc.dto.telemetry.TelemetryPointResponse;
import com.example.coursework_tc.model.TelemetryPoint;
import com.example.coursework_tc.service.TelemetryService;
import jakarta.validation.Valid;
import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import lombok.RequiredArgsConstructor;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@Validated
@RequiredArgsConstructor
@RequestMapping("/api")
public class TelemetryController {

    private final TelemetryService telemetryService;

    @PostMapping("/telemetry")
    public TelemetryPointResponse recordPoint(@Valid @RequestBody TelemetryPointRequest request) {
        TelemetryPoint point = telemetryService.recordPoint(
                request.vehicleId(),
                request.latitude(),
                request.longitude(),
                request.recordedAt(),
                request.speedKmh(),
                request.source(),
                request.sessionId()
        );
        return TelemetryPointResponse.from(point);
    }

    @GetMapping("/vehicles/{id}/telemetry")
    public List<TelemetryPointResponse> getVehicleTelemetry(
            @PathVariable Long id,
            @RequestParam(defaultValue = "100")
            @Min(value = 1, message = "limit must be greater than 0")
            @Max(value = 500, message = "limit must be less than or equal to 500")
            int limit
    ) {
        return telemetryService.findRecentPointsForVehicle(id, limit)
                .stream()
                .map(TelemetryPointResponse::from)
                .toList();
    }

    @GetMapping("/sessions/{sessionId}/points")
    public List<TelemetryPointResponse> getSessionPoints(@PathVariable Long sessionId) {
        return telemetryService.findPointsBySession(sessionId)
                .stream()
                .map(TelemetryPointResponse::from)
                .toList();
    }
}
