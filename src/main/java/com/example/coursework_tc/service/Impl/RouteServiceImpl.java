package com.example.coursework_tc.service.Impl;

import com.example.coursework_tc.model.Route;
import com.example.coursework_tc.model.User;
import com.example.coursework_tc.model.enums.RouteStatus;
import com.example.coursework_tc.repository.RouteRepository;
import com.example.coursework_tc.repository.UserRepository;
import com.example.coursework_tc.service.RouteService;
import com.example.coursework_tc.service.VehicleService;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.security.Principal;
import java.util.List;

@Slf4j
@Service
@AllArgsConstructor
public class RouteServiceImpl implements RouteService {
    private final RouteRepository routeRepository;
    private final VehicleService vehicleService;

    @Override
    public List<Route> getAllRoutes() {
        return routeRepository.findAll();
    }

    @Override
    public void addRoute(Principal principal, Route route) {
        User customer = vehicleService.getUserByPrincipal(principal);
        route.setCustomer(customer);
        routeRepository.save(route);
        log.info("Saving new Route: {} - {}", route.getStartLocation(), route.getEndLocation());
    }

    @Override
    public Route getRouteById(Long id) {
        return routeRepository.findById(id).orElse(null);
    }

    @Override
    public void deleteRoute(Long id) {
        log.info("Deleting Route: {} - {}", routeRepository.findById(id).get().getStartLocation(), routeRepository.findById(id).get().getEndLocation());
        routeRepository.deleteById(id);
    }
}
