package com.example.coursework_tc.controller;

import com.example.coursework_tc.model.Order;
import com.example.coursework_tc.model.Route;
import com.example.coursework_tc.model.User;
import com.example.coursework_tc.model.Vehicle;
import com.example.coursework_tc.model.enums.RouteStatus;
import com.example.coursework_tc.model.enums.VehicleStatus;
import com.example.coursework_tc.service.OrderService;
import com.example.coursework_tc.service.RouteService;
import com.example.coursework_tc.service.UserService;
import com.example.coursework_tc.service.VehicleService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;
import java.util.List;

@Controller
@RequiredArgsConstructor
@RequestMapping("/carrier")
@PreAuthorize("hasAuthority('ROLE_ADMIN') or hasAuthority('ROLE_CARRIER')")
public class CarrierController {
    private final OrderService orderService;
    private final UserService userService;
    private final RouteService routeService;
    private final VehicleService vehicleService;

    @GetMapping()
    public String carrierMenu(Principal principal, Model model) {
        User carrier = userService.getUserByPrincipal(principal);
        List<Order> orders = orderService.getOrdersByCarrierId(carrier.getId());
        model.addAttribute("orders", orders);
        model.addAttribute("user", carrier);
        model.addAttribute("vehicles", vehicleService.findVehiclesByUser(carrier));
        return "carrierPA";
    }

    @PostMapping("/select_car")
    public String selectCar(Model model, @RequestParam("routeId") Long routeId, @RequestParam("carrierId") Long carrierId) {
        User carrier = userService.getUserById(carrierId);
        Route route = routeService.getRouteById(routeId);
        List<Vehicle> vehicles = vehicleService.findFreeVehiclesByUser(carrier);
        model.addAttribute("vehicles", vehicles);
        model.addAttribute("route", route);
        model.addAttribute("routeId", routeId);
        model.addAttribute("carrierId", carrierId);
        return "car-select";
    }


    @PostMapping("/select_car/create_order")
    public String createOrder(@RequestParam("routeId") Long routeId, @RequestParam("carrierId") Long carrierId,
                              @RequestParam("vehicleId") Long vehicleId) {
        Order order = new Order();
        Vehicle vehicle = vehicleService.findVehicleById(vehicleId);
        order.setRoute(routeService.getRouteById(routeId));
        order.setCarrier(userService.getUserById(carrierId));
        order.getRoute().setStatus(RouteStatus.IN_PROCESS);
        vehicle.setStatus(VehicleStatus.BUSY);
        orderService.createOrder(order);
        vehicle.setOrderId(order.getId());
        vehicleService.updateVehicle(vehicle);
        return "redirect:/" + order.getId();
    }

    @PostMapping("/order/complete/{id}")
    public String completeOrder(@PathVariable Long id) {
        Order order = orderService.getOrderById(id);
        order.getRoute().setStatus(RouteStatus.COMPLETED);
        Vehicle vehicle = vehicleService.findVehicleByOrderId(id);
        vehicle.setStatus(VehicleStatus.FREE);
        vehicle.setOrderId(null);
        orderService.updateOrder(order);
        vehicleService.updateVehicle(vehicle);
        return "redirect:/carrier";
    }
}
