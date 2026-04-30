package com.example.coursework_tc.exception;

public class SessionNotFoundException extends RuntimeException {

    public SessionNotFoundException(Long sessionId) {
        super("Tracking session not found: " + sessionId);
    }
}
