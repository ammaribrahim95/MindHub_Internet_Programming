package com.mindhub.service;

import com.mindhub.dao.*;
import com.mindhub.model.ReportData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class AdminServiceImpl implements AdminService {

    @Autowired private UserDao userDao;
    @Autowired private MoodDao moodDao;
    @Autowired private ForumPostDao forumPostDao;
    @Autowired private AppointmentDao appointmentDao;
    @Autowired private AssessmentResultDao resultDao;
    @Autowired private ReportDao reportDao;

    @Override
    public Map<String, Integer> getDashboardStats() {
        Map<String, Integer> stats = new HashMap<>();
        stats.put("totalUsers", userDao.countAll());
        stats.put("totalStudents", userDao.countByRole("STUDENT"));
        stats.put("totalMoodEntries", moodDao.countAll());
        stats.put("totalForumPosts", forumPostDao.countAll());
        stats.put("totalAppointments", appointmentDao.countAll());
        stats.put("totalAssessments", resultDao.countAll());
        return stats;
    }

    @Override
    public List<ReportData> getMoodTrends() { return moodDao.getMoodTrendsAll(); }

    @Override
    public List<ReportData> getUserRegistrations() { return reportDao.getUserRegistrationsByMonth(); }

    @Override
    public List<ReportData> getForumActivity() { return reportDao.getForumActivityByCategory(); }

    @Override
    public List<ReportData> getTopUsers() { return reportDao.getTopActiveUsers(10); }

    @Override
    public List<ReportData> getAssessmentStats() { return reportDao.getAssessmentCompletionStats(); }
}

