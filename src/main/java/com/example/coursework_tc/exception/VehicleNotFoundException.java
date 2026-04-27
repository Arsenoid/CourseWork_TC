package com.example.coursework_tc.exception;

public class VehicleNotFoundException extends RuntimeException {

    public VehicleNotFoundException(Long vehicleId) {
        super("Vehicle not found: " + vehicleId);
    }
}
