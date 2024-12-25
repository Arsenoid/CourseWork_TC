package com.example.coursework_tc.service;

import com.example.coursework_tc.model.Order;

import java.util.List;

public interface OrderService {

    void createOrder(Order order);

    void updateOrder(Order order);

    Order getOrderById(Long id);

    List<Order> getOrdersByCarrierId(Long userId);
}
