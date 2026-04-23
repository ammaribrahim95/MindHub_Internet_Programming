package com.mindhub.model;

import java.sql.Timestamp;

/**
 * ForumPost entity — a discussion thread in the peer support forum.
 * Maps to the 'forum_posts' table.
 */
public class ForumPost {

    private int id;
    private int userId;
    private String title;
    private String content;
    private String category;
    private boolean anonymous;
    private boolean flagged;
    private int reportCount;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    // Transient fields for display
    private String authorName;
    private int replyCount;

    public ForumPost() {}

    // ----- Getters & Setters -----

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }

    public boolean isAnonymous() { return anonymous; }
    public void setAnonymous(boolean anonymous) { this.anonymous = anonymous; }

    public boolean isFlagged() { return flagged; }
    public void setFlagged(boolean flagged) { this.flagged = flagged; }

    public int getReportCount() { return reportCount; }
    public void setReportCount(int reportCount) { this.reportCount = reportCount; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

    public Timestamp getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(Timestamp updatedAt) { this.updatedAt = updatedAt; }

    public String getAuthorName() { return authorName; }
    public void setAuthorName(String authorName) { this.authorName = authorName; }

    public int getReplyCount() { return replyCount; }
    public void setReplyCount(int replyCount) { this.replyCount = replyCount; }

    /**
     * Returns display name — "Anonymous" if post is anonymous.
     */
    public String getDisplayName() {
        return anonymous ? "Anonymous" : authorName;
    }
}

