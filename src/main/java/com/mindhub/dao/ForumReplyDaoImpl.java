package com.mindhub.dao;

import com.mindhub.model.ForumReply;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class ForumReplyDaoImpl implements ForumReplyDao {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Override
    public List<ForumReply> findByPostId(int postId) {
        String sql = "SELECT fr.*, u.full_name AS author_name FROM forum_replies fr " +
                "JOIN users u ON fr.user_id = u.id WHERE fr.post_id = ? ORDER BY fr.created_at ASC";
        return jdbcTemplate.query(sql, (rs, rowNum) -> {
            ForumReply r = new ForumReply();
            r.setId(rs.getInt("id"));
            r.setPostId(rs.getInt("post_id"));
            r.setUserId(rs.getInt("user_id"));
            r.setContent(rs.getString("content"));
            r.setAnonymous(rs.getBoolean("is_anonymous"));
            r.setCreatedAt(rs.getTimestamp("created_at"));
            r.setAuthorName(rs.getString("author_name"));
            return r;
        }, postId);
    }

    @Override
    public void save(ForumReply reply) {
        jdbcTemplate.update("INSERT INTO forum_replies (post_id, user_id, content, is_anonymous) VALUES (?,?,?,?)",
                reply.getPostId(), reply.getUserId(), reply.getContent(), reply.isAnonymous() ? 1 : 0);
    }

    @Override
    public void delete(int id) {
        jdbcTemplate.update("DELETE FROM forum_replies WHERE id = ?", id);
    }
}

