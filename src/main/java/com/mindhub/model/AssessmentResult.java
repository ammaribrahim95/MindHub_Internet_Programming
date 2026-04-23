package com.mindhub.model;

import java.sql.Timestamp;

/**
 * AssessmentResult entity — stores a user's quiz attempt and score.
 * Maps to the 'assessment_results' table.
 */
public class AssessmentResult {

    private int id;
    private int userId;
    private int assessmentId;
    private int score;
    private int totalPoints;
    private Timestamp completedAt;

    // Transient: assessment title (joined from assessments)
    private String assessmentTitle;

    public AssessmentResult() {}

    // ----- Getters & Setters -----

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public int getAssessmentId() { return assessmentId; }
    public void setAssessmentId(int assessmentId) { this.assessmentId = assessmentId; }

    public int getScore() { return score; }
    public void setScore(int score) { this.score = score; }

    public int getTotalPoints() { return totalPoints; }
    public void setTotalPoints(int totalPoints) { this.totalPoints = totalPoints; }

    public Timestamp getCompletedAt() { return completedAt; }
    public void setCompletedAt(Timestamp completedAt) { this.completedAt = completedAt; }

    public String getAssessmentTitle() { return assessmentTitle; }
    public void setAssessmentTitle(String assessmentTitle) { this.assessmentTitle = assessmentTitle; }

    /**
     * Calculate percentage score.
     */
    public int getPercentage() {
        if (totalPoints == 0) return 0;
        return (int) Math.round((double) score / totalPoints * 100);
    }
}

