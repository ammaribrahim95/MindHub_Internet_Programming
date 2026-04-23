package com.mindhub.dao;

import com.mindhub.model.Badge;
import java.util.List;

public interface BadgeDao {
    List<Badge> findAll();
    Badge findById(int id);
    List<Badge> findByUserId(int userId);
    void save(Badge badge);
    void awardBadge(int userId, int badgeId);
    boolean hasEarned(int userId, int badgeId);
}

