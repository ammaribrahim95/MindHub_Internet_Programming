package com.mindhub.model;

import java.sql.Date;
import java.sql.Timestamp;

/**
 * UserProgress entity — tracks gamification data (streak, points, level).
 * Maps to the 'user_progress' table.
 */
public class UserProgress {

    private int id;
    private int userId;
    private int streakDays;
    private int totalPoints;
    private int level;
    private Date lastCheckIn;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    public UserProgress() {}

    // ----- Getters & Setters -----

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public int getStreakDays() { return streakDays; }
    public void setStreakDays(int streakDays) { this.streakDays = streakDays; }

    public int getTotalPoints() { return totalPoints; }
    public void setTotalPoints(int totalPoints) { this.totalPoints = totalPoints; }

    public int getLevel() { return level; }
    public void setLevel(int level) { this.level = level; }

    public Date getLastCheckIn() { return lastCheckIn; }
    public void setLastCheckIn(Date lastCheckIn) { this.lastCheckIn = lastCheckIn; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

    public Timestamp getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(Timestamp updatedAt) { this.updatedAt = updatedAt; }
}

