package com.mindhub.service;

import com.mindhub.model.ForumPost;
import com.mindhub.model.ForumReply;
import java.util.List;

public interface ForumService {
    List<ForumPost> getAllPosts();
    List<ForumPost> getPostsByCategory(String category);
    ForumPost getPostById(int id);
    void createPost(ForumPost post);
    List<ForumReply> getReplies(int postId);
    void addReply(ForumReply reply);
    void reportPost(int postId);
    List<ForumPost> getFlaggedPosts();
    void removePost(int postId);
}

