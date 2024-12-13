package com.example.coursework_tc.service;

import com.example.coursework_tc.model.Driver;

import java.util.List;



public interface DriverService {
    List<Driver> findAllDrivers();
    Driver addDriver(Driver driver);
    Driver updateDriver(Driver driver);
    void deleteDriver(String contact);
    void deleteById(Long id);
}
