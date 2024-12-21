package com.example.coursework_tc.controller;

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
    private final VehicleService vehicleService;

    @GetMapping()
    public String getVehicles(@RequestParam(name = "searchWord", required = false) String car_model, Model model, Principal principal) {
        List<Vehicle> vehicles = vehicleService.findAllVehicles(car_model);
        model.addAttribute("vehicles", vehicles);
        model.addAttribute("user", vehicleService.getUserByPrincipal(principal));
        model.addAttribute("searchWord", car_model);
        return "vehicles";
    }

    @GetMapping("/{vin}")
    public String getVehicleDetails(Principal principal, @PathVariable String vin, Model model) {
        Vehicle vehicle = vehicleService.findVehicleByVin(vin);
        model.addAttribute("images", vehicle.getImages());
        model.addAttribute("vehicle", vehicle);
        model.addAttribute("user", vehicleService.getUserByPrincipal(principal));
        return "vehicle-details";
    }

    @PostMapping("/add_vehicle")
    public String addVehicle(@RequestParam("file1") MultipartFile file1, @RequestParam("file2") MultipartFile file2,
                             @RequestParam("file3") MultipartFile file3, Vehicle vehicle, Principal principal) throws IOException {
        vehicleService.addVehicle(principal, vehicle, file1, file2, file3);
        return "redirect:/vehicles";
    }

//    @PutMapping("/update_vehicle")
//    public Vehicle updateVehicle(@RequestBody Vehicle vehicle) {
//        return service.updateVehicle(vehicle);
//    }


    @PostMapping("/delete_vehicle/{id}")
    public String deleteById(@PathVariable Long id) {
        vehicleService.deleteById(id);
        return "redirect:/vehicles";
    }
}
