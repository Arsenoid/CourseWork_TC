package com.example.coursework_tc.dto.api;

import java.time.LocalDateTime;
import java.util.List;

public record ApiErrorResponse(
        String code,
        String message,
        LocalDateTime timestamp,
        List<String> details
) {
    public static ApiErrorResponse of(String code, String message, List<String> details) {
        return new ApiErrorResponse(code, message, LocalDateTime.now(), details);
    }
}
