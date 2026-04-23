package com.mindhub.dao;

import com.mindhub.model.User;
import java.util.List;

/**
 * DAO interface for User entity.
 */
public interface UserDao {
    User findById(int id);
    User findByEmail(String email);
    List<User> findAll();
    int save(User user);
    void update(User user);
    void delete(int id);
    int countAll();
    int countByRole(String role);
}

