package com.mindhub.service;

import com.mindhub.model.User;
import java.util.List;

public interface UserService {
    User authenticate(String email, String password);
    int register(User user);
    User findById(int id);
    User findByEmail(String email);
    List<User> findAll();
    void update(User user);
    void delete(int id);
    boolean emailExists(String email);
}

