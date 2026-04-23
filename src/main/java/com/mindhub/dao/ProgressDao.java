package com.mindhub.dao;

import com.mindhub.model.UserProgress;

public interface ProgressDao {
    UserProgress findByUserId(int userId);
    void save(UserProgress progress);
    void update(UserProgress progress);
    void incrementStreak(int userId);
    void resetStreak(int userId);
    void addPoints(int userId, int points);
}

