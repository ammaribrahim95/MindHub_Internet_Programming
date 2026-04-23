package com.mindhub.controller;

import com.mindhub.model.User;
import com.mindhub.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import jakarta.servlet.http.HttpSession;

/**
 * DashboardController — loads the student wellness dashboard with personalized data.
 */
@Controller
public class DashboardController {

    @Autowired private GamificationService gamificationService;
    @Autowired private MoodService moodService;
    @Autowired private ContentService contentService;
    @Autowired private AssessmentService assessmentService;
    @Autowired private SupportService supportService;

    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, Model model) {
        User user = (User) session.getAttribute("loggedInUser");

        // Gamification data
        model.addAttribute("progress", gamificationService.getUserProgress(user.getId()));
        model.addAttribute("badges", gamificationService.getUserBadges(user.getId()));

        // Mood data
        model.addAttribute("todayMood", moodService.getTodayEntry(user.getId()));
        model.addAttribute("weeklyMood", moodService.getWeeklyMood(user.getId()));
        model.addAttribute("avgMood", moodService.getAverageMood(user.getId()));

        // Recent content
        model.addAttribute("recentContent", contentService.findAll());

        // Upcoming appointments
        model.addAttribute("appointments", supportService.getUserAppointments(user.getId()));

        // Assessment results
        model.addAttribute("assessmentResults", assessmentService.getResultHistory(user.getId()));

        return "dashboard";
    }
}

