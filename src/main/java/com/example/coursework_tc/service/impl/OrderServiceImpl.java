package com.example.coursework_tc.service.impl;

import com.example.coursework_tc.model.Order;
import com.example.coursework_tc.repository.OrderRepository;
import com.example.coursework_tc.service.OrderService;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

@Slf4j
@Service
@AllArgsConstructor
public class OrderServiceImpl implements OrderService {
    private final OrderRepository orderRepository;


    @Override
    public void createOrder(Order order) {
        orderRepository.save(order);
    }

    @Override
    public void updateOrder(Order order) {
        orderRepository.save(order);
    }

    @Override
    public Order getOrderById(Long id) {
        return orderRepository.findById(id).orElse(null);
    }

    @Override
    public List<Order> getOrdersByCarrierId(Long userId) {
        return orderRepository.findAllByCarrierId(userId);
    }
}
