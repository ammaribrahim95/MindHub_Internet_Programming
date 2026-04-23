package com.mindhub.dao;

import com.mindhub.model.UserProgress;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class ProgressDaoImpl implements ProgressDao {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    private final RowMapper<UserProgress> rowMapper = (rs, rowNum) -> {
        UserProgress p = new UserProgress();
        p.setId(rs.getInt("id"));
        p.setUserId(rs.getInt("user_id"));
        p.setStreakDays(rs.getInt("streak_days"));
        p.setTotalPoints(rs.getInt("total_points"));
        p.setLevel(rs.getInt("level"));
        p.setLastCheckIn(rs.getDate("last_check_in"));
        p.setCreatedAt(rs.getTimestamp("created_at"));
        p.setUpdatedAt(rs.getTimestamp("updated_at"));
        return p;
    };

    @Override
    public UserProgress findByUserId(int userId) {
        List<UserProgress> results = jdbcTemplate.query(
                "SELECT * FROM user_progress WHERE user_id = ?", rowMapper, userId);
        return results.isEmpty() ? null : results.get(0);
    }

    @Override
    public void save(UserProgress progress) {
        jdbcTemplate.update(
                "INSERT INTO user_progress (user_id, streak_days, total_points, level, last_check_in) VALUES (?,?,?,?,?)",
                progress.getUserId(), progress.getStreakDays(), progress.getTotalPoints(),
                progress.getLevel(), progress.getLastCheckIn());
    }

    @Override
    public void update(UserProgress progress) {
        jdbcTemplate.update(
                "UPDATE user_progress SET streak_days=?, total_points=?, level=?, last_check_in=? WHERE user_id=?",
                progress.getStreakDays(), progress.getTotalPoints(), progress.getLevel(),
                progress.getLastCheckIn(), progress.getUserId());
    }

    @Override
    public void incrementStreak(int userId) {
        jdbcTemplate.update(
                "UPDATE user_progress SET streak_days = streak_days + 1, last_check_in = CURDATE() WHERE user_id = ?",
                userId);
    }

    @Override
    public void resetStreak(int userId) {
        jdbcTemplate.update(
                "UPDATE user_progress SET streak_days = 1, last_check_in = CURDATE() WHERE user_id = ?",
                userId);
    }

    @Override
    public void addPoints(int userId, int points) {
        jdbcTemplate.update(
                "UPDATE user_progress SET total_points = total_points + ?, level = FLOOR((total_points + ?) / 300) + 1 WHERE user_id = ?",
                points, points, userId);
    }
}

