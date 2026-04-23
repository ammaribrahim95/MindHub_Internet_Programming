package com.mindhub.service;

import com.mindhub.model.ReportData;
import java.util.List;
import java.util.Map;

public interface AdminService {
    Map<String, Integer> getDashboardStats();
    List<ReportData> getMoodTrends();
    List<ReportData> getUserRegistrations();
    List<ReportData> getForumActivity();
    List<ReportData> getTopUsers();
    List<ReportData> getAssessmentStats();
}

