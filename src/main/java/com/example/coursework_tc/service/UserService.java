package com.example.coursework_tc.service;

import com.example.coursework_tc.model.User;

import java.security.Principal;
import java.util.List;
import java.util.Map;

public interface UserService {

    List<User> listOfUsers();

    boolean createUser(User user);

    void banUser(Long id);

    void changeUserRoles(User user, Map<String, String> form);

    User getUserByPrincipal(Principal principal);

    User getUserById(Long id);
}
