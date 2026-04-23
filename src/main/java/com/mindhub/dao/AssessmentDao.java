package com.mindhub.dao;

import com.mindhub.model.Assessment;
import com.mindhub.model.AssessmentQuestion;
import java.util.List;

public interface AssessmentDao {
    List<Assessment> findAll();
    Assessment findById(int id);
    List<AssessmentQuestion> findQuestionsByAssessmentId(int assessmentId);
    void saveAssessment(Assessment assessment);
    void saveQuestion(AssessmentQuestion question);
    void deleteAssessment(int id);
}

