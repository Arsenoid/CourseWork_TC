package com.example.coursework_tc.model;

import com.example.coursework_tc.model.enums.RouteStatus;
import jakarta.persistence.*;
import lombok.Data;
import org.springframework.cglib.core.Local;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@Data
@Entity
@Table(name = "routes")
public class Route {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String startLocation;
    private String endLocation;
    @Column(nullable = false)
    private Double distance;
    //TODO: estimatedTime
    private String cargo_description;
    @Column(nullable = false)
    private Double cargo_weight;
    private Double payment;
    private String order_notes;

    @Enumerated(EnumType.STRING)
    private RouteStatus status = RouteStatus.ACTIVE;

    @OneToOne(cascade = CascadeType.ALL, mappedBy = "route")
    private Order order;

    @ManyToOne(cascade = CascadeType.REFRESH, fetch = FetchType.EAGER)
    @JoinColumn
    private User customer;

    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
        updatedAt = null;
    }

    @PreUpdate
    protected void onUpdate() {
        updatedAt = LocalDateTime.now();
    }

    public String getFormattedCreatedAt() {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy.MM.dd HH:mm:ss");
        return createdAt.format(formatter);
    }

    public String getFormattedUpdatedAt() {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy.MM.dd HH:mm:ss");
        return updatedAt.format(formatter);
    }
}
