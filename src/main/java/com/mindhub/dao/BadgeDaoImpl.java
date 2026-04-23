package com.mindhub.dao;

import com.mindhub.model.Badge;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class BadgeDaoImpl implements BadgeDao {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    private final RowMapper<Badge> rowMapper = (rs, rowNum) -> {
        Badge b = new Badge();
        b.setId(rs.getInt("id"));
        b.setName(rs.getString("name"));
        b.setDescription(rs.getString("description"));
        b.setIconUrl(rs.getString("icon_url"));
        b.setCriteria(rs.getString("criteria"));
        b.setPoints(rs.getInt("points"));
        b.setCreatedAt(rs.getTimestamp("created_at"));
        return b;
    };

    @Override
    public List<Badge> findAll() {
        return jdbcTemplate.query("SELECT * FROM badges ORDER BY points ASC", rowMapper);
    }

    @Override
    public Badge findById(int id) {
        List<Badge> results = jdbcTemplate.query("SELECT * FROM badges WHERE id = ?", rowMapper, id);
        return results.isEmpty() ? null : results.get(0);
    }

    @Override
    public List<Badge> findByUserId(int userId) {
        String sql = "SELECT b.*, ub.earned_at FROM badges b " +
                "INNER JOIN user_badges ub ON b.id = ub.badge_id WHERE ub.user_id = ? ORDER BY ub.earned_at DESC";
        return jdbcTemplate.query(sql, (rs, rowNum) -> {
            Badge b = rowMapper.mapRow(rs, rowNum);
            b.setEarned(true);
            b.setEarnedAt(rs.getTimestamp("earned_at"));
            return b;
        }, userId);
    }

    @Override
    public void save(Badge badge) {
        jdbcTemplate.update("INSERT INTO badges (name, description, icon_url, criteria, points) VALUES (?,?,?,?,?)",
                badge.getName(), badge.getDescription(), badge.getIconUrl(), badge.getCriteria(), badge.getPoints());
    }

    @Override
    public void awardBadge(int userId, int badgeId) {
        jdbcTemplate.update("INSERT IGNORE INTO user_badges (user_id, badge_id) VALUES (?, ?)", userId, badgeId);
    }

    @Override
    public boolean hasEarned(int userId, int badgeId) {
        Integer count = jdbcTemplate.queryForObject(
                "SELECT COUNT(*) FROM user_badges WHERE user_id = ? AND badge_id = ?", Integer.class, userId, badgeId);
        return count != null && count > 0;
    }
}

