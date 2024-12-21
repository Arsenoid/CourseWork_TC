package com.example.coursework_tc.controller;

import com.example.coursework_tc.model.User;
import com.example.coursework_tc.model.enums.Role;
import com.example.coursework_tc.service.Impl.UserServiceImpl;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequiredArgsConstructor
public class UserController {
    private final UserServiceImpl userService;

    @GetMapping("/login")
    public String login() {
        return "login";
    }

    @GetMapping("/role_selection")
    public String roleSelection() {
        return "role-selection";
    }

    @GetMapping("/registration")
    public String registration(@RequestParam(required = false) String role, Model model) {
        model.addAttribute("role", role);
        return "registration";
    }

    @PostMapping("/registration")
    public String createUser(User user, Model model, @RequestParam String role) {
        if ("ROLE_USER".equals(role)) {
            user.getRoles().add(Role.ROLE_USER);
        } else if ("ROLE_CONTRACTOR".equals(role)) {
            user.getRoles().add(Role.ROLE_CONTRACTOR);
        }
        if (!userService.createUser(user)) {
            model.addAttribute("errorMessage", "Пользователь с email: " + user.getEmail() + " уже существует!");
            return "registration";
        }
        return "redirect:/login";
    }

    @GetMapping("/user/{user}")
    public String userInfo(@PathVariable("user") User user, Model model) {
        model.addAttribute("user", user);
        model.addAttribute("vehicles", user.getVehicles());
        return "user-info";
    }
}
