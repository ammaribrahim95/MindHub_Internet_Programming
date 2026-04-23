package com.mindhub.service;

import com.mindhub.dao.ContentDao;
import com.mindhub.model.Content;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ContentServiceImpl implements ContentService {

    @Autowired
    private ContentDao contentDao;

    @Override
    public List<Content> findAll() { return contentDao.findAll(); }

    @Override
    public Content findById(int id) { return contentDao.findById(id); }

    @Override
    public List<Content> search(String keyword, String category) { return contentDao.search(keyword, category); }

    @Override
    public void create(Content content) { contentDao.save(content); }

    @Override
    public void update(Content content) { contentDao.update(content); }

    @Override
    public void delete(int id) { contentDao.delete(id); }

    @Override
    public List<String> getAllCategories() { return contentDao.findAllCategories(); }
}

