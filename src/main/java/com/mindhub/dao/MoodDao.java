package com.mindhub.dao;

import com.mindhub.model.MoodEntry;
import com.mindhub.model.ReportData;
import java.util.List;

public interface MoodDao {
    void save(MoodEntry entry);
    List<MoodEntry> findByUserId(int userId);
    List<MoodEntry> findRecentByUserId(int userId, int limit);
    MoodEntry findTodayByUserId(int userId);
    List<ReportData> getWeeklyMoodByUserId(int userId);
    double getAverageMoodByUserId(int userId);
    List<ReportData> getMoodTrendsAll();
    int countAll();
}

