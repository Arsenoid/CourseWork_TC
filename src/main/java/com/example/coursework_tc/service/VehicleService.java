package com.example.coursework_tc.service;

import com.example.coursework_tc.model.User;
import com.example.coursework_tc.model.Vehicle;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.security.Principal;
import java.util.List;

public interface VehicleService {
    List<Vehicle> findAllVehicles(String car_model);
    Vehicle findVehicleByVin(String vin);
    void addVehicle(Principal principal, Vehicle vehicle, MultipartFile file1, MultipartFile file2, MultipartFile file3) throws IOException;
    User getUserByPrincipal(Principal principal);
//    Vehicle updateVehicle(Vehicle vehicle);
    void deleteVehicle(String vin);
    void deleteById(Long id);
}
