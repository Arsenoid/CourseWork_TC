package com.example.coursework_tc.repository;

import com.example.coursework_tc.model.TelemetryPoint;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface TelemetryPointRepository extends JpaRepository<TelemetryPoint, Long> {

    List<TelemetryPoint> findByVehicleIdOrderByRecordedAtDesc(Long vehicleId, Pageable pageable);

    @Query("select p from TelemetryPoint p where p.session.id = :sessionId order by p.recordedAt asc")
    List<TelemetryPoint> findBySessionIdOrderByRecordedAtAsc(@Param("sessionId") Long sessionId);
}
