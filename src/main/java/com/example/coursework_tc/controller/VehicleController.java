package com.example.coursework_tc.controller;

import com.example.coursework_tc.model.User;
import com.example.coursework_tc.model.Vehicle;
import com.example.coursework_tc.service.VehicleService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.security.Principal;
import java.util.List;

@Controller
@RequiredArgsConstructor
@RequestMapping("/vehicles")
public class VehicleController {
    private final VehicleService service;

    @GetMapping()
    public String getVehicles(@RequestParam(name = "car_model", required = false) String car_model, Model model, Principal principal) {
        List<Vehicle> vehicles = service.findAllVehicles(car_model);
        model.addAttribute("vehicles", vehicles);
        model.addAttribute("user", service.getUserByPrincipal(principal));
        return "vehicles";
    }

    @GetMapping("/{vin}")
    public String getVehicleDetails(Principal principal, @PathVariable String vin, Model model) {
        Vehicle vehicle = service.findVehicleByVin(vin);
        model.addAttribute("images", vehicle.getImages());
        model.addAttribute("vehicle", vehicle);
        model.addAttribute("user", service.getUserByPrincipal(principal));
        return "vehicle-details";
    }

    @PostMapping("/add_vehicle")
    public String addVehicle(@RequestParam("file1") MultipartFile file1, @RequestParam("file2") MultipartFile file2,
                             @RequestParam("file3") MultipartFile file3, Vehicle vehicle, Principal principal) throws IOException {
        service.addVehicle(principal, vehicle, file1, file2, file3);
        return "redirect:/vehicles";
    }

//    @PutMapping("/update_vehicle")
//    public Vehicle updateVehicle(@RequestBody Vehicle vehicle) {
//        return service.updateVehicle(vehicle);
//    }

    @DeleteMapping("/delete_vehicle/{vin}")
    public String deleteVehicle(@PathVariable String vin) {
        service.deleteVehicle(vin);
        return "redirect:/vehicles";
    }

    @PostMapping("/delete_vehicle/{id}")
    public String deleteById(@PathVariable Long id) {
        service.deleteById(id);
        return "redirect:/vehicles";
    }
}
