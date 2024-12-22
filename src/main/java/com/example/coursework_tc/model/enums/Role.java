package com.example.coursework_tc.model.enums;

import org.springframework.security.core.GrantedAuthority;

public enum Role implements GrantedAuthority {
    ROLE_CARRIER, ROLE_CUSTOMER, ROLE_ADMIN;

    @Override
    public String getAuthority() {
        return name();
    }
}
