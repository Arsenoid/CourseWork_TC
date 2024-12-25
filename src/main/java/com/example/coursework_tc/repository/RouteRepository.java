package com.example.coursework_tc.repository;

import com.example.coursework_tc.model.Route;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface RouteRepository extends JpaRepository<Route, Long> {

    List<Route> findAllByCustomerId(Long userId);

}
