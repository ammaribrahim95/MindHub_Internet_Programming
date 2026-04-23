package com.mindhub.dao;

import com.mindhub.model.ForumReply;
import java.util.List;

public interface ForumReplyDao {
    List<ForumReply> findByPostId(int postId);
    void save(ForumReply reply);
    void delete(int id);
}

