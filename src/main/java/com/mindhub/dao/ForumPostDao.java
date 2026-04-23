package com.mindhub.dao;

import com.mindhub.model.ForumPost;
import java.util.List;

public interface ForumPostDao {
    List<ForumPost> findAll();
    List<ForumPost> findByCategory(String category);
    ForumPost findById(int id);
    void save(ForumPost post);
    void update(ForumPost post);
    void delete(int id);
    void incrementReportCount(int id);
    void setFlagged(int id, boolean flagged);
    List<ForumPost> findFlagged();
    int countAll();
}

