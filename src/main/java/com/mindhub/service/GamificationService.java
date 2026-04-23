package com.mindhub.service;

import com.mindhub.model.Badge;
import com.mindhub.model.UserProgress;
import java.util.List;

public interface GamificationService {
    UserProgress getUserProgress(int userId);
    void updateStreak(int userId);
    void addPoints(int userId, int points);
    List<Badge> getAllBadges();
    List<Badge> getUserBadges(int userId);
    List<Badge> getAllBadgesWithUserStatus(int userId);
    void awardBadge(int userId, int badgeId);
    void checkAndAwardBadges(int userId);
}

