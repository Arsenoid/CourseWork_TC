package com.example.coursework_tc.repository;

import com.example.coursework_tc.model.Driver;
import org.springframework.data.jpa.repository.JpaRepository;

public interface DriverRepository extends JpaRepository<Driver, Long> {

    void deleteByContacts(String contacts);

    void deleteById(Long id);
}
