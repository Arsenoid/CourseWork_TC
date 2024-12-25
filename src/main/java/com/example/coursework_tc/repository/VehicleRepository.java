package com.example.coursework_tc.repository;

import com.example.coursework_tc.model.User;
import com.example.coursework_tc.model.Vehicle;
import com.example.coursework_tc.model.enums.VehicleStatus;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface VehicleRepository extends JpaRepository<Vehicle, Long> {

    void deleteByVin(String vin);

    List<Vehicle> findVehiclesByUserId(Long userId);

    List<Vehicle> findByStatusAndUserId(VehicleStatus status, Long userId);

    Vehicle findByVin(String vin);

    Vehicle findVehicleByOrderId(Long orderId);

    List<Vehicle> findByModel(String car_model);
}
