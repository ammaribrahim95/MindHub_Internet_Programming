package com.mindhub.service;

import com.mindhub.model.Assessment;
import com.mindhub.model.AssessmentQuestion;
import com.mindhub.model.AssessmentResult;
import java.util.List;

public interface AssessmentService {
    List<Assessment> findAll();
    Assessment findById(int id);
    List<AssessmentQuestion> getQuestions(int assessmentId);
    AssessmentResult submitAssessment(int userId, int assessmentId, String[] answers);
    List<AssessmentResult> getResultHistory(int userId);
}

