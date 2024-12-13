package com.example.coursework_tc.repository;

import com.example.coursework_tc.model.Image;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ImageRepository extends JpaRepository<Image, Long> {
}
