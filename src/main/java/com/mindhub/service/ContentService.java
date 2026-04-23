package com.mindhub.service;

import com.mindhub.model.Content;
import java.util.List;

public interface ContentService {
    List<Content> findAll();
    Content findById(int id);
    List<Content> search(String keyword, String category);
    void create(Content content);
    void update(Content content);
    void delete(int id);
    List<String> getAllCategories();
}

