package com.mindhub.service;

import com.mindhub.dao.AssessmentDao;
import com.mindhub.dao.AssessmentResultDao;
import com.mindhub.model.Assessment;
import com.mindhub.model.AssessmentQuestion;
import com.mindhub.model.AssessmentResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AssessmentServiceImpl implements AssessmentService {

    @Autowired
    private AssessmentDao assessmentDao;

    @Autowired
    private AssessmentResultDao resultDao;

    @Autowired
    private GamificationService gamificationService;

    @Override
    public List<Assessment> findAll() { return assessmentDao.findAll(); }

    @Override
    public Assessment findById(int id) { return assessmentDao.findById(id); }

    @Override
    public List<AssessmentQuestion> getQuestions(int assessmentId) {
        return assessmentDao.findQuestionsByAssessmentId(assessmentId);
    }

    @Override
    public AssessmentResult submitAssessment(int userId, int assessmentId, String[] answers) {
        List<AssessmentQuestion> questions = getQuestions(assessmentId);
        int score = 0;
        int totalPoints = 0;

        for (int i = 0; i < questions.size() && i < answers.length; i++) {
            AssessmentQuestion q = questions.get(i);
            totalPoints += q.getPoints();
            if (q.getCorrectAnswer().equalsIgnoreCase(answers[i])) {
                score += q.getPoints();
            }
        }

        AssessmentResult result = new AssessmentResult();
        result.setUserId(userId);
        result.setAssessmentId(assessmentId);
        result.setScore(score);
        result.setTotalPoints(totalPoints);
        resultDao.save(result);

        // Award points for completing assessment
        gamificationService.addPoints(userId, 20);
        gamificationService.checkAndAwardBadges(userId);

        return result;
    }

    @Override
    public List<AssessmentResult> getResultHistory(int userId) {
        return resultDao.findByUserId(userId);
    }
}

