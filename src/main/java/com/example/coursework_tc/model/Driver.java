package com.example.coursework_tc.model;

import jakarta.persistence.*;
import lombok.Data;
//import javax.persistence.*;
import java.time.LocalDate;

@Data
@Entity
@Table(name = "Drivers")
public class Driver {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    private String fio;
    private LocalDate dateOfBirth;
    private int experience;
    private String category;
    @Column(unique = true)
    private String contacts;
    private String status;
}
