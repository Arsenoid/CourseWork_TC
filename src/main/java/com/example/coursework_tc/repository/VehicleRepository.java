package com.example.coursework_tc.repository;

import com.example.coursework_tc.model.Vehicle;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface VehicleRepository extends JpaRepository<Vehicle, Long> {

    void deleteByVin(String vin);

    void deleteById(Long id);

    Vehicle findByVin(String vin);

    List<Vehicle> findByModel(String car_model);
}
