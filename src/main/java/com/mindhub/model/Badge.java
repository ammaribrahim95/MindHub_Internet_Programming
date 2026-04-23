package com.mindhub.model;

import java.sql.Timestamp;

/**
 * Badge entity — defines an earnable badge/achievement.
 * Maps to the 'badges' table.
 */
public class Badge {

    private int id;
    private String name;
    private String description;
    private String iconUrl;
    private String criteria;
    private int points;
    private Timestamp createdAt;

    // Whether current user has earned this badge (transient, set in service)
    private boolean earned;
    private Timestamp earnedAt;

    public Badge() {}

    // ----- Getters & Setters -----

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getIconUrl() { return iconUrl; }
    public void setIconUrl(String iconUrl) { this.iconUrl = iconUrl; }

    public String getCriteria() { return criteria; }
    public void setCriteria(String criteria) { this.criteria = criteria; }

    public int getPoints() { return points; }
    public void setPoints(int points) { this.points = points; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

    public boolean isEarned() { return earned; }
    public void setEarned(boolean earned) { this.earned = earned; }

    public Timestamp getEarnedAt() { return earnedAt; }
    public void setEarnedAt(Timestamp earnedAt) { this.earnedAt = earnedAt; }
}

