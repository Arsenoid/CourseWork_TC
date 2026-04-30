package com.example.coursework_tc.model;

import com.example.coursework_tc.model.enums.TelemetrySource;
import jakarta.persistence.*;
import lombok.Data;

import java.time.Instant;

@Data
@Entity
@Table(name = "telemetry_points", indexes = {
        @Index(name = "idx_telemetry_vehicle_recorded", columnList = "vehicle_id,recorded_at")
})
public class TelemetryPoint {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "vehicle_id", nullable = false)
    private Vehicle vehicle;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "session_id")
    private TrackingSession session;

    @Column(nullable = false)
    private Double latitude;

    @Column(nullable = false)
    private Double longitude;

    @Column(nullable = false)
    private Instant recordedAt;

    private Double speedKmh;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 32)
    private TelemetrySource source;
}
