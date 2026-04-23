package com.mindhub.controller;

import com.mindhub.service.AdminService;
import com.mindhub.service.ForumService;
import com.mindhub.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

/**
 * AdminController — admin dashboard, user management, reports, and moderation.
 */
@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired private AdminService adminService;
    @Autowired private UserService userService;
    @Autowired private ForumService forumService;

    @GetMapping("")
    public String dashboard(Model model) {
        model.addAttribute("stats", adminService.getDashboardStats());
        model.addAttribute("moodTrends", adminService.getMoodTrends());
        model.addAttribute("topUsers", adminService.getTopUsers());
        return "admin-dashboard";
    }

    @GetMapping("/users")
    public String userManagement(Model model) {
        model.addAttribute("users", userService.findAll());
        return "admin-users";
    }

    @PostMapping("/users/delete/{id}")
    public String deleteUser(@PathVariable int id, RedirectAttributes ra) {
        userService.delete(id);
        ra.addFlashAttribute("success", "User deleted");
        return "redirect:/admin/users";
    }

    @GetMapping("/reports")
    public String reports(Model model) {
        model.addAttribute("registrations", adminService.getUserRegistrations());
        model.addAttribute("moodDistribution", adminService.getMoodTrends());
        model.addAttribute("forumActivity", adminService.getForumActivity());
        model.addAttribute("assessmentStats", adminService.getAssessmentStats());
        return "admin-reports";
    }

    @GetMapping("/forum/flagged")
    public String flaggedPosts(Model model) {
        model.addAttribute("flaggedPosts", forumService.getFlaggedPosts());
        return "admin-flagged";
    }

    @PostMapping("/forum/remove/{id}")
    public String removePost(@PathVariable int id, RedirectAttributes ra) {
        forumService.removePost(id);
        ra.addFlashAttribute("success", "Post removed");
        return "redirect:/admin/forum/flagged";
    }
}

