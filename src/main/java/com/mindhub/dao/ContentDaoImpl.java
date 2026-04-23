package com.mindhub.dao;

import com.mindhub.model.Content;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.List;

@Repository
public class ContentDaoImpl implements ContentDao {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    private final RowMapper<Content> rowMapper = (rs, rowNum) -> {
        Content c = new Content();
        c.setId(rs.getInt("id"));
        c.setTitle(rs.getString("title"));
        c.setDescription(rs.getString("description"));
        c.setContentType(rs.getString("content_type"));
        c.setCategory(rs.getString("category"));
        c.setUrl(rs.getString("url"));
        c.setThumbnailUrl(rs.getString("thumbnail_url"));
        c.setDuration(rs.getString("duration"));
        c.setAuthorId(rs.getObject("author_id") != null ? rs.getInt("author_id") : null);
        c.setCreatedAt(rs.getTimestamp("created_at"));
        c.setUpdatedAt(rs.getTimestamp("updated_at"));
        return c;
    };

    @Override
    public List<Content> findAll() {
        return jdbcTemplate.query("SELECT * FROM content ORDER BY created_at DESC", rowMapper);
    }

    @Override
    public Content findById(int id) {
        List<Content> results = jdbcTemplate.query("SELECT * FROM content WHERE id = ?", rowMapper, id);
        return results.isEmpty() ? null : results.get(0);
    }

    @Override
    public List<Content> search(String keyword, String category) {
        StringBuilder sql = new StringBuilder("SELECT * FROM content WHERE 1=1");
        List<Object> params = new ArrayList<>();
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append(" AND (title LIKE ? OR description LIKE ?)");
            params.add("%" + keyword + "%");
            params.add("%" + keyword + "%");
        }
        if (category != null && !category.trim().isEmpty()) {
            sql.append(" AND category = ?");
            params.add(category);
        }
        sql.append(" ORDER BY created_at DESC");
        return jdbcTemplate.query(sql.toString(), rowMapper, params.toArray());
    }

    @Override
    public void save(Content content) {
        jdbcTemplate.update(
                "INSERT INTO content (title, description, content_type, category, url, thumbnail_url, duration, author_id) VALUES (?,?,?,?,?,?,?,?)",
                content.getTitle(), content.getDescription(), content.getContentType(),
                content.getCategory(), content.getUrl(), content.getThumbnailUrl(),
                content.getDuration(), content.getAuthorId());
    }

    @Override
    public void update(Content content) {
        jdbcTemplate.update(
                "UPDATE content SET title=?, description=?, content_type=?, category=?, url=?, thumbnail_url=?, duration=? WHERE id=?",
                content.getTitle(), content.getDescription(), content.getContentType(),
                content.getCategory(), content.getUrl(), content.getThumbnailUrl(),
                content.getDuration(), content.getId());
    }

    @Override
    public void delete(int id) {
        jdbcTemplate.update("DELETE FROM content WHERE id = ?", id);
    }

    @Override
    public List<String> findAllCategories() {
        return jdbcTemplate.queryForList("SELECT DISTINCT category FROM content WHERE category IS NOT NULL ORDER BY category", String.class);
    }
}

