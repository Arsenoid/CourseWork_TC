package com.example.coursework_tc.service.Impl;

import com.example.coursework_tc.model.Route;
import com.example.coursework_tc.model.User;
import com.example.coursework_tc.repository.RouteRepository;
import com.example.coursework_tc.service.RouteService;
import com.example.coursework_tc.service.UserService;
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
    private final UserService userService;

    @Override
    public List<Route> getAllRoutes() {
        return routeRepository.findAll();
    }

    @Override
    public List<Route> getAllRoutesByCustomer(User user) {
        return routeRepository.findAllByCustomerId(user.getId());
    }

    @Override
    public void addRoute(Principal principal, Route route) {
        User customer = userService.getUserByPrincipal(principal);
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

    @Override
    public void editRoute(Long id, Route updatedRoute) {
        Route route = getRouteById(id);
        route.setStartLocation(updatedRoute.getStartLocation());
        route.setEndLocation(updatedRoute.getEndLocation());
        route.setDistance(updatedRoute.getDistance());
        route.setCargo_description(updatedRoute.getCargo_description());
        route.setCargo_weight(updatedRoute.getCargo_weight());
        route.setPayment(updatedRoute.getPayment());
        route.setOrder_notes(updatedRoute.getOrder_notes());
        routeRepository.save(route);
    }
}
