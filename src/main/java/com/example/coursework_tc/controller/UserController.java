package com.example.coursework_tc.controller;

import com.example.coursework_tc.model.User;
import com.example.coursework_tc.model.enums.Role;
import com.example.coursework_tc.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;

@Controller
@RequiredArgsConstructor
public class UserController {
    private final UserService userService;

    @GetMapping("/login")
    public String login(@RequestParam(value = "error", required = false) String error,
                        @RequestParam(value = "logout", required = false) String logout,
                        Model model) {
        if (error != null) {
            model.addAttribute("error", "Неверный email или пароль");
        }
        if (logout != null) {
            model.addAttribute("logout", "Вы успешно вышли из системы");
        }
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
        if (user.getTel_number() != null && user.getTel_number().trim().isEmpty()) {
            user.setTel_number(null);
        }
        if ("ROLE_CARRIER".equals(role)) {
            user.getRoles().add(Role.ROLE_CARRIER);
        } else if ("ROLE_CUSTOMER".equals(role)) {
            user.getRoles().add(Role.ROLE_CUSTOMER);
        }
        if (!userService.createUser(user)) {
            model.addAttribute("errorMessage", "Пользователь с email: " + user.getEmail() + " уже существует!");
            return "registration";
        }
        return "redirect:/login";
    }

    @GetMapping("/user/{user}")
    public String userInfo(@PathVariable("user") User user, Model model, Principal principal) {
        User currentUser = userService.getUserByPrincipal(principal);
        model.addAttribute("user", user);
        model.addAttribute("vehicles", user.getVehicles());
        model.addAttribute("isOwnProfile",
                currentUser != null && currentUser.getId() != null
                        && currentUser.getId().equals(user.getId()));
        return "user-info";
    }

    @GetMapping("/profile/edit")
    public String editProfileForm(Model model, Principal principal) {
        model.addAttribute("user", userService.getUserByPrincipal(principal));
        return "profile-edit";
    }

    @PostMapping("/profile/edit")
    public String saveProfile(@RequestParam String username,
                              @RequestParam String email,
                              @RequestParam(required = false) String tel_number,
                              @RequestParam(required = false) String dateOfBirth,
                              @RequestParam(defaultValue = "0") Integer experience,
                              Model model,
                              Principal principal) {
        User current = userService.getUserByPrincipal(principal);
        String error = userService.updatePersonalData(
                current.getId(), username, email, tel_number, dateOfBirth, experience);
        if (error != null) {
            current = userService.getUserByPrincipal(principal);
            model.addAttribute("user", current);
            model.addAttribute("errorMessage", error);
            return "profile-edit";
        }
        return "redirect:/user/" + current.getId();
    }
}
