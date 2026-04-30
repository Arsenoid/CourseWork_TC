package com.example.coursework_tc.exception;

public class SessionAlreadyActiveException extends RuntimeException {

    public SessionAlreadyActiveException(Long vehicleId) {
        super("Vehicle " + vehicleId + " already has an active tracking session");
    }
}
