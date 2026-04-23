package com.mindhub.service;

import com.mindhub.dao.ForumPostDao;
import com.mindhub.dao.ForumReplyDao;
import com.mindhub.model.ForumPost;
import com.mindhub.model.ForumReply;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ForumServiceImpl implements ForumService {

    @Autowired
    private ForumPostDao postDao;

    @Autowired
    private ForumReplyDao replyDao;

    @Autowired
    private GamificationService gamificationService;

    @Override
    public List<ForumPost> getAllPosts() { return postDao.findAll(); }

    @Override
    public List<ForumPost> getPostsByCategory(String category) { return postDao.findByCategory(category); }

    @Override
    public ForumPost getPostById(int id) { return postDao.findById(id); }

    @Override
    public void createPost(ForumPost post) {
        postDao.save(post);
        gamificationService.addPoints(post.getUserId(), 15);
    }

    @Override
    public List<ForumReply> getReplies(int postId) { return replyDao.findByPostId(postId); }

    @Override
    public void addReply(ForumReply reply) {
        replyDao.save(reply);
        gamificationService.addPoints(reply.getUserId(), 5);
    }

    @Override
    public void reportPost(int postId) { postDao.incrementReportCount(postId); }

    @Override
    public List<ForumPost> getFlaggedPosts() { return postDao.findFlagged(); }

    @Override
    public void removePost(int postId) { postDao.delete(postId); }
}

