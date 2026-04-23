package com.mindhub.controller;

import com.mindhub.model.User;
import com.mindhub.service.GamificationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import jakarta.servlet.http.HttpSession;

/**
 * GamificationController — achievements, badges, and progress.
 */
@Controller
public class GamificationController {

    @Autowired
    private GamificationService gamificationService;

    @GetMapping("/achievements")
    public String achievements(HttpSession session, Model model) {
        User user = (User) session.getAttribute("loggedInUser");
        model.addAttribute("progress", gamificationService.getUserProgress(user.getId()));
        model.addAttribute("allBadges", gamificationService.getAllBadgesWithUserStatus(user.getId()));
        model.addAttribute("earnedBadges", gamificationService.getUserBadges(user.getId()));
        return "achievements";
    }
}

