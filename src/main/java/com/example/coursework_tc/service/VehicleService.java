package com.example.coursework_tc.service;

import com.example.coursework_tc.model.User;
import com.example.coursework_tc.model.Vehicle;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.security.Principal;
import java.util.List;

public interface VehicleService {

    List<Vehicle> findAllVehicles(String car_model);

    List<Vehicle> findVehiclesByUser(User user);

    List<Vehicle> findFreeVehiclesByUser(User user);

    Vehicle findVehicleById(Long id);

    Vehicle findVehicleByVin(String vin);

    Vehicle findVehicleByOrderId(Long orderId);

    void addVehicle(Principal principal, Vehicle vehicle, MultipartFile file1, MultipartFile file2, MultipartFile file3) throws IOException;

    void updateVehicleByVin(String vin, Vehicle newvehicle);

    Vehicle updateVehicle(Vehicle vehicle);

    void deleteById(Long id);
}
