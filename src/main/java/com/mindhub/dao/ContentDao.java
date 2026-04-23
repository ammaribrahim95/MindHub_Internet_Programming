package com.mindhub.dao;

import com.mindhub.model.Content;
import java.util.List;

public interface ContentDao {
    List<Content> findAll();
    Content findById(int id);
    List<Content> search(String keyword, String category);
    void save(Content content);
    void update(Content content);
    void delete(int id);
    List<String> findAllCategories();
}

