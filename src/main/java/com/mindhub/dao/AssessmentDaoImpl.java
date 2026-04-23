package com.mindhub.dao;

import com.mindhub.model.Assessment;
import com.mindhub.model.AssessmentQuestion;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class AssessmentDaoImpl implements AssessmentDao {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    private final RowMapper<Assessment> assessmentMapper = (rs, rowNum) -> {
        Assessment a = new Assessment();
        a.setId(rs.getInt("id"));
        a.setTitle(rs.getString("title"));
        a.setDescription(rs.getString("description"));
        a.setCategory(rs.getString("category"));
        a.setTotalQuestions(rs.getInt("total_questions"));
        a.setCreatedAt(rs.getTimestamp("created_at"));
        return a;
    };

    private final RowMapper<AssessmentQuestion> questionMapper = (rs, rowNum) -> {
        AssessmentQuestion q = new AssessmentQuestion();
        q.setId(rs.getInt("id"));
        q.setAssessmentId(rs.getInt("assessment_id"));
        q.setQuestionText(rs.getString("question_text"));
        q.setOptionA(rs.getString("option_a"));
        q.setOptionB(rs.getString("option_b"));
        q.setOptionC(rs.getString("option_c"));
        q.setOptionD(rs.getString("option_d"));
        q.setCorrectAnswer(rs.getString("correct_answer"));
        q.setPoints(rs.getInt("points"));
        return q;
    };

    @Override
    public List<Assessment> findAll() {
        return jdbcTemplate.query("SELECT * FROM assessments ORDER BY created_at DESC", assessmentMapper);
    }

    @Override
    public Assessment findById(int id) {
        List<Assessment> results = jdbcTemplate.query("SELECT * FROM assessments WHERE id = ?", assessmentMapper, id);
        return results.isEmpty() ? null : results.get(0);
    }

    @Override
    public List<AssessmentQuestion> findQuestionsByAssessmentId(int assessmentId) {
        return jdbcTemplate.query("SELECT * FROM assessment_questions WHERE assessment_id = ?", questionMapper, assessmentId);
    }

    @Override
    public void saveAssessment(Assessment assessment) {
        jdbcTemplate.update("INSERT INTO assessments (title, description, category, total_questions) VALUES (?,?,?,?)",
                assessment.getTitle(), assessment.getDescription(), assessment.getCategory(), assessment.getTotalQuestions());
    }

    @Override
    public void saveQuestion(AssessmentQuestion q) {
        jdbcTemplate.update(
                "INSERT INTO assessment_questions (assessment_id, question_text, option_a, option_b, option_c, option_d, correct_answer, points) VALUES (?,?,?,?,?,?,?,?)",
                q.getAssessmentId(), q.getQuestionText(), q.getOptionA(), q.getOptionB(),
                q.getOptionC(), q.getOptionD(), q.getCorrectAnswer(), q.getPoints());
    }

    @Override
    public void deleteAssessment(int id) {
        jdbcTemplate.update("DELETE FROM assessments WHERE id = ?", id);
    }
}

