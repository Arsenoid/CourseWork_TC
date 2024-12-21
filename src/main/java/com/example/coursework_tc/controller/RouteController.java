package com.example.coursework_tc.controller;

import com.example.coursework_tc.model.Route;
import com.example.coursework_tc.service.RouteService;
import com.example.coursework_tc.service.VehicleService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.security.Principal;

@Controller
@RequestMapping("/")
@RequiredArgsConstructor
public class RouteController {
    private final RouteService routeService;
    private final VehicleService vehicleService;

    @GetMapping()
    public String getRoutes(Model model, Principal principal) {
        model.addAttribute("routes", routeService.getAllRoutes());
        model.addAttribute("user", vehicleService.getUserByPrincipal(principal));
        return "routes";
    }

    @PostMapping("/add_route")
    public String addRoute(Principal principal, Route route) {
        routeService.addRoute(principal, route);
        return "redirect:/";
    }

    @GetMapping("/{id}")
    public String getRouteDetails(Model model, @PathVariable Long id, Principal principal) {
        model.addAttribute("route", routeService.getRouteById(id));
        model.addAttribute("user", vehicleService.getUserByPrincipal(principal));
        return "route-details";
    }

    @PostMapping("/delete_route/{id}")
    public String deleteRoute(@PathVariable Long id) {
        routeService.deleteRoute(id);
        return "redirect:/";
    }
}
