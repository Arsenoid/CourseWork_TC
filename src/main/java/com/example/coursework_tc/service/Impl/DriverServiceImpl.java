package com.example.coursework_tc.service.Impl;

import com.example.coursework_tc.model.Driver;
import com.example.coursework_tc.repository.DriverRepository;
import com.example.coursework_tc.service.DriverService;
import jakarta.transaction.Transactional;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

//import javax.transaction.Transactional;
import java.util.List;

@Service
@AllArgsConstructor
public class DriverServiceImpl implements DriverService {

    private final DriverRepository driverRepository;

    @Override
    public List<Driver> findAllDrivers() {
        return driverRepository.findAll();
    }

    @Override
    public Driver addDriver(Driver driver) {
        return driverRepository.save(driver);
    }

    @Override
    public Driver updateDriver(Driver driver) {
        return driverRepository.save(driver);
    }

    @Override
    @Transactional
    public void deleteDriver(String contact) {
        driverRepository.deleteByContacts(contact);
    }

    @Override
    @Transactional
    public void deleteById(Long id) {
        driverRepository.deleteById(id);
    }
}
