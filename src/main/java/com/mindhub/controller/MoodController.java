package com.mindhub.controller;

import com.mindhub.model.MoodEntry;
import com.mindhub.model.User;
import com.mindhub.service.MoodService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.HttpSession;

/**
 * MoodController — daily mood check-in and analytics.
 */
@Controller
public class MoodController {

    @Autowired
    private MoodService moodService;

    @GetMapping("/mood")
    public String moodCheckin(HttpSession session, Model model) {
        User user = (User) session.getAttribute("loggedInUser");
        model.addAttribute("todayMood", moodService.getTodayEntry(user.getId()));
        model.addAttribute("recentMoods", moodService.getRecentEntries(user.getId(), 7));
        return "mood-checkin";
    }

    @PostMapping("/mood/checkin")
    public String submitMood(@RequestParam int moodScore,
                             @RequestParam(required = false) String journalText,
                             HttpSession session,
                             RedirectAttributes ra) {
        User user = (User) session.getAttribute("loggedInUser");

        // Check if already checked in today
        if (moodService.getTodayEntry(user.getId()) != null) {
            ra.addFlashAttribute("error", "You've already checked in today!");
            return "redirect:/mood";
        }

        MoodEntry entry = new MoodEntry();
        entry.setUserId(user.getId());
        entry.setMoodScore(moodScore);
        entry.setJournalText(journalText);
        moodService.addEntry(entry);

        ra.addFlashAttribute("success", "Mood logged successfully! +10 points");
        return "redirect:/mood";
    }

    @GetMapping("/mood/analytics")
    public String moodAnalytics(HttpSession session, Model model) {
        User user = (User) session.getAttribute("loggedInUser");
        model.addAttribute("weeklyMood", moodService.getWeeklyMood(user.getId()));
        model.addAttribute("avgMood", moodService.getAverageMood(user.getId()));
        model.addAttribute("allEntries", moodService.getEntries(user.getId()));
        return "mood-analytics";
    }
}

