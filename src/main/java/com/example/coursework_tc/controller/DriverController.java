package com.example.coursework_tc.controller;

import com.example.coursework_tc.model.Driver;
import com.example.coursework_tc.service.DriverService;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@AllArgsConstructor
@RequestMapping("/api/v1/drivers")
public class DriverController {

    private final DriverService service;

    @GetMapping("/")
    public List<Driver> findAllDrivers() {
        return service.findAllDrivers();
    }

    @PostMapping("/add_driver")
    public String addDriver(@RequestBody Driver driver) {
        service.addDriver(driver);
        return "Driver added successfully!";
    }

    @PutMapping("/update_driver")
    public Driver updateDriver(@RequestBody Driver driver) {
        return service.updateDriver(driver);
    }

    @DeleteMapping("/delete_driver/{contacts}")
    public String deleteDriver(@PathVariable String contacts) {
        service.deleteDriver(contacts);
        return "Driver deleted successfully";
    }

    @DeleteMapping("/delete_driver/id/{id}")
    public String deleteById(@PathVariable Long id) {
        service.deleteById(id);
        return "Driver deleted successfully!";
    }
}
