package com.mindhub.dao;

import com.mindhub.model.ForumPost;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class ForumPostDaoImpl implements ForumPostDao {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    private final RowMapper<ForumPost> rowMapper = (rs, rowNum) -> {
        ForumPost p = new ForumPost();
        p.setId(rs.getInt("id"));
        p.setUserId(rs.getInt("user_id"));
        p.setTitle(rs.getString("title"));
        p.setContent(rs.getString("content"));
        p.setCategory(rs.getString("category"));
        p.setAnonymous(rs.getBoolean("is_anonymous"));
        p.setFlagged(rs.getBoolean("is_flagged"));
        p.setReportCount(rs.getInt("report_count"));
        p.setCreatedAt(rs.getTimestamp("created_at"));
        p.setUpdatedAt(rs.getTimestamp("updated_at"));
        return p;
    };

    @Override
    public List<ForumPost> findAll() {
        String sql = "SELECT fp.*, u.full_name AS author_name, " +
                "(SELECT COUNT(*) FROM forum_replies fr WHERE fr.post_id = fp.id) AS reply_count " +
                "FROM forum_posts fp JOIN users u ON fp.user_id = u.id ORDER BY fp.created_at DESC";
        return jdbcTemplate.query(sql, (rs, rowNum) -> {
            ForumPost p = rowMapper.mapRow(rs, rowNum);
            p.setAuthorName(rs.getString("author_name"));
            p.setReplyCount(rs.getInt("reply_count"));
            return p;
        });
    }

    @Override
    public List<ForumPost> findByCategory(String category) {
        String sql = "SELECT fp.*, u.full_name AS author_name, " +
                "(SELECT COUNT(*) FROM forum_replies fr WHERE fr.post_id = fp.id) AS reply_count " +
                "FROM forum_posts fp JOIN users u ON fp.user_id = u.id WHERE fp.category = ? ORDER BY fp.created_at DESC";
        return jdbcTemplate.query(sql, (rs, rowNum) -> {
            ForumPost p = rowMapper.mapRow(rs, rowNum);
            p.setAuthorName(rs.getString("author_name"));
            p.setReplyCount(rs.getInt("reply_count"));
            return p;
        }, category);
    }

    @Override
    public ForumPost findById(int id) {
        String sql = "SELECT fp.*, u.full_name AS author_name FROM forum_posts fp JOIN users u ON fp.user_id = u.id WHERE fp.id = ?";
        List<ForumPost> results = jdbcTemplate.query(sql, (rs, rowNum) -> {
            ForumPost p = rowMapper.mapRow(rs, rowNum);
            p.setAuthorName(rs.getString("author_name"));
            return p;
        }, id);
        return results.isEmpty() ? null : results.get(0);
    }

    @Override
    public void save(ForumPost post) {
        jdbcTemplate.update("INSERT INTO forum_posts (user_id, title, content, category, is_anonymous) VALUES (?,?,?,?,?)",
                post.getUserId(), post.getTitle(), post.getContent(), post.getCategory(), post.isAnonymous() ? 1 : 0);
    }

    @Override
    public void update(ForumPost post) {
        jdbcTemplate.update("UPDATE forum_posts SET title=?, content=?, category=? WHERE id=?",
                post.getTitle(), post.getContent(), post.getCategory(), post.getId());
    }

    @Override
    public void delete(int id) {
        jdbcTemplate.update("DELETE FROM forum_posts WHERE id = ?", id);
    }

    @Override
    public void incrementReportCount(int id) {
        jdbcTemplate.update("UPDATE forum_posts SET report_count = report_count + 1, is_flagged = CASE WHEN report_count >= 2 THEN 1 ELSE is_flagged END WHERE id = ?", id);
    }

    @Override
    public void setFlagged(int id, boolean flagged) {
        jdbcTemplate.update("UPDATE forum_posts SET is_flagged = ? WHERE id = ?", flagged ? 1 : 0, id);
    }

    @Override
    public List<ForumPost> findFlagged() {
        String sql = "SELECT fp.*, u.full_name AS author_name FROM forum_posts fp JOIN users u ON fp.user_id = u.id WHERE fp.is_flagged = 1 ORDER BY fp.report_count DESC";
        return jdbcTemplate.query(sql, (rs, rowNum) -> {
            ForumPost p = rowMapper.mapRow(rs, rowNum);
            p.setAuthorName(rs.getString("author_name"));
            return p;
        });
    }

    @Override
    public int countAll() {
        Integer c = jdbcTemplate.queryForObject("SELECT COUNT(*) FROM forum_posts", Integer.class);
        return c != null ? c : 0;
    }
}

