package com.example.coursework_tc.controller;

import com.example.coursework_tc.model.Route;
import com.example.coursework_tc.model.User;
import com.example.coursework_tc.service.RouteService;
import com.example.coursework_tc.service.UserService;
import com.example.coursework_tc.service.VehicleService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.security.Principal;

@Controller
@RequiredArgsConstructor
@RequestMapping("/customer")
@PreAuthorize("hasAuthority('ROLE_ADMIN') or hasAuthority('ROLE_CUSTOMER')")
public class CustomerController {
    private final RouteService routeService;
    private final UserService userService;
    private final VehicleService vehicleService;

    @GetMapping()
    public String contractorMenu(Principal principal, Model model) {
        User customer = userService.getUserByPrincipal(principal);
        model.addAttribute("routes", routeService.getAllRoutesByCustomer(customer));
        model.addAttribute("user", customer);
        model.addAttribute("vehicles", vehicleService.findVehiclesByUser(customer));
        return "customerPA";
    }

    @GetMapping("/add_route")
    public String addRoute() {
        return "add-route";
    }

    @PostMapping("/add_route")
    public String addRoute(Principal principal, Route route) {
        routeService.addRoute(principal, route);
        return "redirect:/customer";
    }

    @PostMapping("/delete_route/{id}")
    public String deleteRoute(@PathVariable Long id) {
        routeService.deleteRoute(id);
        return "redirect:/";
    }

    @GetMapping("/edit_route/{id}")
    public String editRoute(@PathVariable Long id, Model model) {
        Route route = routeService.getRouteById(id);
        model.addAttribute("route", route);
        return "edit-route";
    }

    @PostMapping("/edit_route/{id}")
    public String editRoute(@PathVariable Long id, Route updatedRoute) {
        routeService.editRoute(id, updatedRoute);
        return "redirect:/customer";
    }
}
