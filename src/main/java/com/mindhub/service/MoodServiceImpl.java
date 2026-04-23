package com.mindhub.service;

import com.mindhub.dao.MoodDao;
import com.mindhub.model.MoodEntry;
import com.mindhub.model.ReportData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.Date;
import java.time.LocalDate;
import java.util.List;

@Service
public class MoodServiceImpl implements MoodService {

    @Autowired
    private MoodDao moodDao;

    @Autowired
    private GamificationService gamificationService;

    @Override
    public void addEntry(MoodEntry entry) {
        if (entry.getEntryDate() == null) {
            entry.setEntryDate(Date.valueOf(LocalDate.now()));
        }
        // Set mood label based on score
        if (entry.getMoodLabel() == null || entry.getMoodLabel().isEmpty()) {
            switch (entry.getMoodScore()) {
                case 1: entry.setMoodLabel("Very Low"); break;
                case 2: entry.setMoodLabel("Low"); break;
                case 3: entry.setMoodLabel("Neutral"); break;
                case 4: entry.setMoodLabel("Good"); break;
                case 5: entry.setMoodLabel("Great"); break;
            }
        }
        moodDao.save(entry);

        // Update gamification streak and points
        gamificationService.updateStreak(entry.getUserId());
        gamificationService.addPoints(entry.getUserId(), 10);
        gamificationService.checkAndAwardBadges(entry.getUserId());
    }

    @Override
    public List<MoodEntry> getEntries(int userId) { return moodDao.findByUserId(userId); }

    @Override
    public List<MoodEntry> getRecentEntries(int userId, int limit) { return moodDao.findRecentByUserId(userId, limit); }

    @Override
    public MoodEntry getTodayEntry(int userId) { return moodDao.findTodayByUserId(userId); }

    @Override
    public List<ReportData> getWeeklyMood(int userId) { return moodDao.getWeeklyMoodByUserId(userId); }

    @Override
    public double getAverageMood(int userId) { return moodDao.getAverageMoodByUserId(userId); }
}

