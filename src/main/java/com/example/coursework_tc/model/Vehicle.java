package com.example.coursework_tc.model;

import com.example.coursework_tc.model.enums.VehicleStatus;
import jakarta.persistence.*;
import lombok.Data;

import java.time.Instant;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Data
@Entity
@Table(name = "vehicles")
public class Vehicle {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Column(unique = true)
    private String vin;

    private String model;

    private Double manufactureYear;

    private String licensePlate;

    private String fuelType;

    private Double loadCapacity;

    private Long orderId;

    @Enumerated(EnumType.STRING)
    private VehicleStatus status = VehicleStatus.FREE;

    @OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "vehicle")
    private List<Image> images = new ArrayList<>();
    private Long previewImageId;

    @ManyToOne(cascade = CascadeType.REFRESH, fetch = FetchType.LAZY)
    @JoinColumn
    private User user;

    private Double lastLatitude;
    private Double lastLongitude;
    private Instant lastTelemetryAt;

    private LocalDateTime createdAt;

    @PrePersist
    private void init() {
        createdAt = LocalDateTime.now();
    }

    public void addImageToVehicle(Image image) {
        image.setVehicle(this);
        images.add(image);
    }
}
