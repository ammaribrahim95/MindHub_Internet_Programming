package com.mindhub.service;

import com.mindhub.dao.ProgressDao;
import com.mindhub.dao.UserDao;
import com.mindhub.model.User;
import com.mindhub.model.UserProgress;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserDao userDao;

    @Autowired
    private ProgressDao progressDao;

    @Override
    public User authenticate(String email, String password) {
        User user = userDao.findByEmail(email);
        if (user != null && user.getPassword().equals(password)) {
            return user;
        }
        return null;
    }

    @Override
    public int register(User user) {
        // Set default role if not specified
        if (user.getRole() == null || user.getRole().isEmpty()) {
            user.setRole("STUDENT");
        }
        int userId = userDao.save(user);

        // Initialize gamification progress for new user
        UserProgress progress = new UserProgress();
        progress.setUserId(userId);
        progress.setStreakDays(0);
        progress.setTotalPoints(0);
        progress.setLevel(1);
        progressDao.save(progress);

        return userId;
    }

    @Override
    public User findById(int id) {
        return userDao.findById(id);
    }

    @Override
    public User findByEmail(String email) {
        return userDao.findByEmail(email);
    }

    @Override
    public List<User> findAll() {
        return userDao.findAll();
    }

    @Override
    public void update(User user) {
        userDao.update(user);
    }

    @Override
    public void delete(int id) {
        userDao.delete(id);
    }

    @Override
    public boolean emailExists(String email) {
        return userDao.findByEmail(email) != null;
    }
}

