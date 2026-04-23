package com.mindhub.dao;

import com.mindhub.model.ReportData;
import java.util.List;

public interface ReportDao {
    List<ReportData> getUserRegistrationsByMonth();
    List<ReportData> getMoodDistribution();
    List<ReportData> getForumActivityByCategory();
    List<ReportData> getTopActiveUsers(int limit);
    List<ReportData> getAssessmentCompletionStats();
}

