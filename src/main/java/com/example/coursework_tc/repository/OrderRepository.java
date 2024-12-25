package com.example.coursework_tc.repository;

import com.example.coursework_tc.model.Order;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface OrderRepository extends JpaRepository<Order, Long> {

    List<Order> findAllByCarrierId(Long userId);
}
