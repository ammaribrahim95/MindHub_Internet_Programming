package com.mindhub.dao;

import com.mindhub.model.AssessmentResult;
import java.util.List;

public interface AssessmentResultDao {
    void save(AssessmentResult result);
    List<AssessmentResult> findByUserId(int userId);
    int countByUserId(int userId);
    int countAll();
}

