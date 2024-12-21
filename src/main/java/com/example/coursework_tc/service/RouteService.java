package com.example.coursework_tc.service;

import com.example.coursework_tc.model.Route;
import com.example.coursework_tc.model.User;

import java.security.Principal;
import java.util.List;

public interface RouteService {

    List<Route> getAllRoutes();

    void addRoute(Principal principal, Route route);

    Route getRouteById(Long id);

    void deleteRoute(Long id);
}
