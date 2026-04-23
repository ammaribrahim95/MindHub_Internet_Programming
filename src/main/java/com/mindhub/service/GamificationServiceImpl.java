package com.mindhub.service;

import com.mindhub.dao.BadgeDao;
import com.mindhub.dao.ProgressDao;
import com.mindhub.model.Badge;
import com.mindhub.model.UserProgress;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.Date;
import java.time.LocalDate;
import java.util.List;

@Service
public class GamificationServiceImpl implements GamificationService {

    @Autowired
    private ProgressDao progressDao;

    @Autowired
    private BadgeDao badgeDao;

    @Override
    public UserProgress getUserProgress(int userId) {
        return progressDao.findByUserId(userId);
    }

    @Override
    public void updateStreak(int userId) {
        UserProgress progress = progressDao.findByUserId(userId);
        if (progress == null) return;

        LocalDate today = LocalDate.now();
        LocalDate lastCheckIn = progress.getLastCheckIn() != null
                ? progress.getLastCheckIn().toLocalDate() : null;

        if (lastCheckIn == null || lastCheckIn.isBefore(today.minusDays(1))) {
            // Reset streak if missed a day
            progressDao.resetStreak(userId);
        } else if (lastCheckIn.isBefore(today)) {
            // Increment streak if consecutive day
            progressDao.incrementStreak(userId);
        }
        // If already checked in today, do nothing
    }

    @Override
    public void addPoints(int userId, int points) {
        progressDao.addPoints(userId, points);
    }

    @Override
    public List<Badge> getAllBadges() {
        return badgeDao.findAll();
    }

    @Override
    public List<Badge> getUserBadges(int userId) {
        return badgeDao.findByUserId(userId);
    }

    @Override
    public List<Badge> getAllBadgesWithUserStatus(int userId) {
        List<Badge> allBadges = badgeDao.findAll();
        List<Badge> earned = badgeDao.findByUserId(userId);
        for (Badge badge : allBadges) {
            for (Badge e : earned) {
                if (badge.getId() == e.getId()) {
                    badge.setEarned(true);
                    badge.setEarnedAt(e.getEarnedAt());
                    break;
                }
            }
        }
        return allBadges;
    }

    @Override
    public void awardBadge(int userId, int badgeId) {
        if (!badgeDao.hasEarned(userId, badgeId)) {
            badgeDao.awardBadge(userId, badgeId);
            Badge badge = badgeDao.findById(badgeId);
            if (badge != null) {
                addPoints(userId, badge.getPoints());
            }
        }
    }

    @Override
    public void checkAndAwardBadges(int userId) {
        UserProgress progress = progressDao.findByUserId(userId);
        if (progress == null) return;

        // First Step badge (id=1): first check-in
        if (progress.getLastCheckIn() != null) awardBadge(userId, 1);
        // 7-Day Streak (id=2)
        if (progress.getStreakDays() >= 7) awardBadge(userId, 2);
        // 14-Day Streak (id=3)
        if (progress.getStreakDays() >= 14) awardBadge(userId, 3);
        // Level 3 (id=6)
        if (progress.getLevel() >= 3) awardBadge(userId, 6);
    }
}

