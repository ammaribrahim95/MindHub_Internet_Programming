package com.mindhub.service;

import com.mindhub.model.MoodEntry;
import com.mindhub.model.ReportData;
import java.util.List;

public interface MoodService {
    void addEntry(MoodEntry entry);
    List<MoodEntry> getEntries(int userId);
    List<MoodEntry> getRecentEntries(int userId, int limit);
    MoodEntry getTodayEntry(int userId);
    List<ReportData> getWeeklyMood(int userId);
    double getAverageMood(int userId);
}

