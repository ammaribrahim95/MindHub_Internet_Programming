package com.mindhub.model;

import java.sql.Timestamp;

/**
 * Assessment entity — quiz/self-assessment definition.
 * Maps to the 'assessments' table.
 */
public class Assessment {

    private int id;
    private String title;
    private String description;
    private String category;
    private int totalQuestions;
    private Timestamp createdAt;

    public Assessment() {}

    // ----- Getters & Setters -----

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }

    public int getTotalQuestions() { return totalQuestions; }
    public void setTotalQuestions(int totalQuestions) { this.totalQuestions = totalQuestions; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
}

