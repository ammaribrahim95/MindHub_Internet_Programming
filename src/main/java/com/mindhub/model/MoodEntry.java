package com.mindhub.model;

import java.sql.Date;
import java.sql.Timestamp;

/**
 * MoodEntry entity — daily mood check-in with optional journal text.
 * Maps to the 'mood_entries' table.
 */
public class MoodEntry {

    private int id;
    private int userId;
    private int moodScore;      // 1=Very Low, 2=Low, 3=Neutral, 4=Good, 5=Great
    private String moodLabel;
    private String journalText;
    private Date entryDate;
    private Timestamp createdAt;

    public MoodEntry() {}

    // ----- Getters & Setters -----

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public int getMoodScore() { return moodScore; }
    public void setMoodScore(int moodScore) { this.moodScore = moodScore; }

    public String getMoodLabel() { return moodLabel; }
    public void setMoodLabel(String moodLabel) { this.moodLabel = moodLabel; }

    public String getJournalText() { return journalText; }
    public void setJournalText(String journalText) { this.journalText = journalText; }

    public Date getEntryDate() { return entryDate; }
    public void setEntryDate(Date entryDate) { this.entryDate = entryDate; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

    /**
     * Returns emoji representation of mood score.
     */
    public String getMoodEmoji() {
        switch (moodScore) {
            case 1: return "😢";
            case 2: return "😟";
            case 3: return "😐";
            case 4: return "😊";
            case 5: return "😄";
            default: return "😐";
        }
    }
}

