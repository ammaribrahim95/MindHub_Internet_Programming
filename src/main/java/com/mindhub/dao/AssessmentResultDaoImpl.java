package com.mindhub.dao;

import com.mindhub.model.AssessmentResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class AssessmentResultDaoImpl implements AssessmentResultDao {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    private final RowMapper<AssessmentResult> rowMapper = (rs, rowNum) -> {
        AssessmentResult r = new AssessmentResult();
        r.setId(rs.getInt("id"));
        r.setUserId(rs.getInt("user_id"));
        r.setAssessmentId(rs.getInt("assessment_id"));
        r.setScore(rs.getInt("score"));
        r.setTotalPoints(rs.getInt("total_points"));
        r.setCompletedAt(rs.getTimestamp("completed_at"));
        return r;
    };

    @Override
    public void save(AssessmentResult result) {
        jdbcTemplate.update(
                "INSERT INTO assessment_results (user_id, assessment_id, score, total_points) VALUES (?,?,?,?)",
                result.getUserId(), result.getAssessmentId(), result.getScore(), result.getTotalPoints());
    }

    @Override
    public List<AssessmentResult> findByUserId(int userId) {
        String sql = "SELECT ar.*, a.title AS assessment_title FROM assessment_results ar " +
                "JOIN assessments a ON ar.assessment_id = a.id WHERE ar.user_id = ? ORDER BY ar.completed_at DESC";
        return jdbcTemplate.query(sql, (rs, rowNum) -> {
            AssessmentResult r = rowMapper.mapRow(rs, rowNum);
            r.setAssessmentTitle(rs.getString("assessment_title"));
            return r;
        }, userId);
    }

    @Override
    public int countByUserId(int userId) {
        Integer c = jdbcTemplate.queryForObject("SELECT COUNT(*) FROM assessment_results WHERE user_id = ?", Integer.class, userId);
        return c != null ? c : 0;
    }

    @Override
    public int countAll() {
        Integer c = jdbcTemplate.queryForObject("SELECT COUNT(*) FROM assessment_results", Integer.class);
        return c != null ? c : 0;
    }
}

