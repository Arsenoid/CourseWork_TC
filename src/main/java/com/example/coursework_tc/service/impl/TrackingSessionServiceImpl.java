package com.example.coursework_tc.service.impl;

import com.example.coursework_tc.exception.SessionAlreadyActiveException;
import com.example.coursework_tc.exception.SessionNotFoundException;
import com.example.coursework_tc.exception.VehicleNotFoundException;
import com.example.coursework_tc.model.TrackingSession;
import com.example.coursework_tc.model.Vehicle;
import com.example.coursework_tc.model.enums.TelemetrySource;
import com.example.coursework_tc.model.enums.TrackingSessionStatus;
import com.example.coursework_tc.repository.TrackingSessionRepository;
import com.example.coursework_tc.repository.VehicleRepository;
import com.example.coursework_tc.service.TrackingSessionService;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.Instant;
import java.util.List;

@Service
@RequiredArgsConstructor
public class TrackingSessionServiceImpl implements TrackingSessionService {

    private final TrackingSessionRepository sessionRepository;
    private final VehicleRepository vehicleRepository;

    @Override
    @Transactional
    public TrackingSession startSession(Long vehicleId, TelemetrySource source) {
        Vehicle vehicle = vehicleRepository.findById(vehicleId)
                .orElseThrow(() -> new VehicleNotFoundException(vehicleId));

        sessionRepository.findByVehicleIdAndStatus(vehicleId, TrackingSessionStatus.ACTIVE)
                .ifPresent(s -> { throw new SessionAlreadyActiveException(vehicleId); });

        TrackingSession session = new TrackingSession();
        session.setVehicle(vehicle);
        session.setSource(source);
        session.setStatus(TrackingSessionStatus.ACTIVE);
        session.setStartedAt(Instant.now());

        return sessionRepository.save(session);
    }

    @Override
    @Transactional
    public TrackingSession stopSession(Long sessionId) {
        TrackingSession session = sessionRepository.findById(sessionId)
                .orElseThrow(() -> new SessionNotFoundException(sessionId));

        session.setStatus(TrackingSessionStatus.COMPLETED);
        session.setEndedAt(Instant.now());

        return sessionRepository.save(session);
    }

    @Override
    public TrackingSession findById(Long sessionId) {
        return sessionRepository.findById(sessionId)
                .orElseThrow(() -> new SessionNotFoundException(sessionId));
    }

    @Override
    public List<TrackingSession> findByVehicle(Long vehicleId) {
        return sessionRepository.findByVehicleIdOrderByStartedAtDesc(vehicleId);
    }
}
