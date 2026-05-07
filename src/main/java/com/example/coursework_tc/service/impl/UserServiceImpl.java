package com.example.coursework_tc.service.impl;

import com.example.coursework_tc.model.User;
import com.example.coursework_tc.model.enums.Role;
import com.example.coursework_tc.repository.UserRepository;
import com.example.coursework_tc.service.UserService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.security.Principal;
import java.time.LocalDate;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

@Slf4j
@Service
@RequiredArgsConstructor
public class UserServiceImpl implements UserService {
    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;

    @Override
    public List<User> listOfUsers() {
        return userRepository.findAll();
    }

    @Override
    public boolean createUser(User user) {
        String email = user.getEmail();
        if (userRepository.findByEmail(email) != null) return false;
        user.setActive(true);
        user.setPassword(passwordEncoder.encode(user.getPassword()));
//        user.getRoles().add(Role.ROLE_USER);
        userRepository.save(user);
        log.info("Created new user: {}", email);
        return true;
    }

    @Override
    public void banUser(Long id) {
        User user = userRepository.findById(id).orElse(null);
        if (user != null) {
            if (user.isActive()) {
                user.setActive(false);
                log.info("Banned user: {}", user.getEmail());
            } else {
                user.setActive(true);
                log.info("Unbanned user: {}", user.getEmail());
            }
        }
        userRepository.save(user);
    }

    @Override
    public void changeUserRoles(User user, Map<String, String> form) {
        Set<String> roles = Arrays.stream(Role.values())
                .map(Role::name)
                .collect(Collectors.toSet());
        user.getRoles().clear();
        for (String key : form.keySet()) {
            if (roles.contains(key)) {
                user.getRoles().add(Role.valueOf(key));
            }
        }
        userRepository.save(user);
    }

    @Override
    public User getUserByPrincipal(Principal principal) {
        if (principal == null) return new User();
        return userRepository.findByUsername(principal.getName());
    }

    @Override
    public User getUserById(Long id) {
        return userRepository.findById(id).orElse(null);
    }

    @Override
    public String updatePersonalData(Long userId, String username, String email,
                                     String telNumber, String dateOfBirth, Integer experience) {
        User user = userRepository.findById(userId).orElse(null);
        if (user == null) return "Пользователь не найден.";

        String uname = username == null ? "" : username.trim();
        String mail  = email    == null ? "" : email.trim();
        if (uname.isEmpty()) return "Имя пользователя не может быть пустым.";
        if (mail.isEmpty())  return "Email не может быть пустым.";

        String phone = (telNumber == null || telNumber.trim().isEmpty()) ? null : telNumber.trim();

        User byEmail = userRepository.findByEmail(mail);
        if (byEmail != null && !byEmail.getId().equals(userId))
            return "Пользователь с таким email уже существует.";

        if (phone != null) {
            for (User u : userRepository.findAll()) {
                if (!u.getId().equals(userId) && phone.equals(u.getTel_number()))
                    return "Пользователь с таким номером телефона уже существует.";
            }
        }

        try {
            user.setDateOfBirth(
                (dateOfBirth == null || dateOfBirth.isBlank()) ? null : LocalDate.parse(dateOfBirth)
            );
        } catch (Exception e) {
            return "Некорректный формат даты рождения.";
        }

        user.setUsername(uname);
        user.setEmail(mail);
        user.setTel_number(phone);
        user.setExperience(experience == null ? 0 : Math.max(experience, 0));
        userRepository.save(user);
        log.info("Updated personal data for user id={}", userId);
        return null;
    }
}
