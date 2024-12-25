package com.example.coursework_tc.service.Impl;

import com.example.coursework_tc.model.Image;
import com.example.coursework_tc.model.User;
import com.example.coursework_tc.model.Vehicle;
import com.example.coursework_tc.model.enums.VehicleStatus;
import com.example.coursework_tc.repository.UserRepository;
import com.example.coursework_tc.repository.VehicleRepository;
import com.example.coursework_tc.service.UserService;
import com.example.coursework_tc.service.VehicleService;
import jakarta.transaction.Transactional;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

//import javax.transaction.Transactional;
import java.io.IOException;
import java.security.Principal;
import java.util.List;
import java.util.Optional;

@Service
@Slf4j
@AllArgsConstructor
public class VehicleServiceImpl implements VehicleService {

    private final VehicleRepository vehicleRepository;
    private final UserService userService;

    @Override
    public List<Vehicle> findAllVehicles(String car_model) {
        if (car_model != null && !car_model.isEmpty()) return vehicleRepository.findByModel(car_model);
        return vehicleRepository.findAll();
    }

    @Override
    public List<Vehicle> findVehiclesByUser(User user) {
        return vehicleRepository.findVehiclesByUserId(user.getId());
    }

    @Override
    public List<Vehicle> findFreeVehiclesByUser(User user) {
        return vehicleRepository.findByStatusAndUserId(VehicleStatus.FREE, user.getId());
    }

    @Override
    public Vehicle findVehicleById(Long id) {
        return vehicleRepository.findById(id).orElse(null);
    }

    @Override
    public Vehicle findVehicleByVin(String vin) {
        return vehicleRepository.findByVin(vin);
    }

    @Override
    public Vehicle findVehicleByOrderId(Long orderId) {
        return vehicleRepository.findVehicleByOrderId(orderId);
    }

    @Override
    public void addVehicle(Principal principal, Vehicle vehicle, MultipartFile file1, MultipartFile file2, MultipartFile file3) throws IOException {
        vehicle.setUser(userService.getUserByPrincipal(principal));
        Image image1;
        Image image2;
        Image image3;
        if (file1.getSize() != 0) {
            image1 = toImageEntity(file1);
            image1.setPreviewImage(true);
            vehicle.addImageToVehicle(image1);
        }
        if (file2.getSize() != 0) {
            image2 = toImageEntity(file2);
            vehicle.addImageToVehicle(image2);
        }
        if (file3.getSize() != 0) {
            image3 = toImageEntity(file3);
            vehicle.addImageToVehicle(image3);
        }
        log.info("Saving new vehicle: {} - {}. Owner: {}", vehicle.getModel(), vehicle.getVin(), vehicle.getUser().getEmail());
        Vehicle vehicleFromDb = vehicleRepository.save(vehicle);
        Optional<Image> firstImageOpt = vehicleFromDb.getImages().stream().findFirst();
        if (firstImageOpt.isPresent()) {
            vehicleFromDb.setPreviewImageId(firstImageOpt.get().getId());
            vehicleRepository.save(vehicleFromDb);
        }
    }

    @Override
    public void updateVehicleByVin(String vin, Vehicle newvehicle) {
        Vehicle vehicle = findVehicleByVin(vin);
        vehicle.setVin(newvehicle.getVin());
        vehicle.setModel(newvehicle.getModel());
        vehicle.setManufactureYear(newvehicle.getManufactureYear());
        vehicle.setLicensePlate(newvehicle.getLicensePlate());
        vehicle.setFuelType(newvehicle.getFuelType());
        vehicle.setLoadCapacity(newvehicle.getLoadCapacity());
        vehicleRepository.save(vehicle);
    }

    private Image toImageEntity(MultipartFile file) throws IOException {
        Image image = new Image();
        image.setName(file.getName());
        image.setOriginalFileName(file.getOriginalFilename());
        image.setContentType(file.getContentType());
        image.setSize(file.getSize());
        image.setBytes(file.getBytes());
        return image;
    }

    @Override
    public Vehicle updateVehicle(Vehicle vehicle) {
        return vehicleRepository.save(vehicle);
    }

    @Override
    @Transactional
    public void deleteById(Long id) {
        log.info("Deleted vehicle: {}", vehicleRepository.findById(id).get().getModel());
        vehicleRepository.deleteById(id);

    }

}
