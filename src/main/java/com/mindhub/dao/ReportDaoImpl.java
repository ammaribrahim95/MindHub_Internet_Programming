package com.mindhub.dao;

import com.mindhub.model.ReportData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class ReportDaoImpl implements ReportDao {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Override
    public List<ReportData> getUserRegistrationsByMonth() {
        String sql = "SELECT DATE_FORMAT(created_at, '%Y-%m') AS label, COUNT(*) AS count " +
                "FROM users GROUP BY DATE_FORMAT(created_at, '%Y-%m') ORDER BY label DESC LIMIT 12";
        return jdbcTemplate.query(sql, (rs, rowNum) -> new ReportData(rs.getString("label"), rs.getInt("count")));
    }

    @Override
    public List<ReportData> getMoodDistribution() {
        String sql = "SELECT mood_label AS label, COUNT(*) AS count FROM mood_entries " +
                "WHERE mood_label IS NOT NULL GROUP BY mood_label ORDER BY count DESC";
        return jdbcTemplate.query(sql, (rs, rowNum) -> new ReportData(rs.getString("label"), rs.getInt("count")));
    }

    @Override
    public List<ReportData> getForumActivityByCategory() {
        String sql = "SELECT category AS label, COUNT(*) AS count FROM forum_posts GROUP BY category ORDER BY count DESC";
        return jdbcTemplate.query(sql, (rs, rowNum) -> new ReportData(rs.getString("label"), rs.getInt("count")));
    }

    @Override
    public List<ReportData> getTopActiveUsers(int limit) {
        String sql = "SELECT u.full_name AS label, up.total_points AS count FROM user_progress up " +
                "JOIN users u ON up.user_id = u.id ORDER BY up.total_points DESC LIMIT ?";
        return jdbcTemplate.query(sql, (rs, rowNum) -> new ReportData(rs.getString("label"), rs.getInt("count")), limit);
    }

    @Override
    public List<ReportData> getAssessmentCompletionStats() {
        String sql = "SELECT a.title AS label, COUNT(ar.id) AS count FROM assessments a " +
                "LEFT JOIN assessment_results ar ON a.id = ar.assessment_id GROUP BY a.id, a.title ORDER BY count DESC";
        return jdbcTemplate.query(sql, (rs, rowNum) -> new ReportData(rs.getString("label"), rs.getInt("count")));
    }
}

