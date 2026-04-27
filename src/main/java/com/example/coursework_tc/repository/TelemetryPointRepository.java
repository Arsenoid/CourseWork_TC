package com.example.coursework_tc.repository;

import com.example.coursework_tc.model.TelemetryPoint;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface TelemetryPointRepository extends JpaRepository<TelemetryPoint, Long> {

    List<TelemetryPoint> findByVehicleIdOrderByRecordedAtDesc(Long vehicleId, Pageable pageable);

    TelemetryPoint findTopByVehicleIdOrderByRecordedAtDesc(Long vehicleId);
}
