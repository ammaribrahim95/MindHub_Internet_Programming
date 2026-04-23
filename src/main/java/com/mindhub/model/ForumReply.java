package com.mindhub.model;

import java.sql.Timestamp;

/**
 * ForumReply entity — a reply to a forum thread.
 * Maps to the 'forum_replies' table.
 */
public class ForumReply {

    private int id;
    private int postId;
    private int userId;
    private String content;
    private boolean anonymous;
    private Timestamp createdAt;

    // Transient
    private String authorName;

    public ForumReply() {}

    // ----- Getters & Setters -----

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getPostId() { return postId; }
    public void setPostId(int postId) { this.postId = postId; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }

    public boolean isAnonymous() { return anonymous; }
    public void setAnonymous(boolean anonymous) { this.anonymous = anonymous; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

    public String getAuthorName() { return authorName; }
    public void setAuthorName(String authorName) { this.authorName = authorName; }

    public String getDisplayName() {
        return anonymous ? "Anonymous" : authorName;
    }
}

