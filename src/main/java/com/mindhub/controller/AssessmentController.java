package com.mindhub.controller;

import com.mindhub.model.AssessmentResult;
import com.mindhub.model.User;
import com.mindhub.service.AssessmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.HttpSession;

/**
 * AssessmentController — quiz system with scoring.
 */
@Controller
public class AssessmentController {

    @Autowired
    private AssessmentService assessmentService;

    @GetMapping("/assessments")
    public String listAssessments(Model model) {
        model.addAttribute("assessments", assessmentService.findAll());
        return "assessments";
    }

    @GetMapping("/assessment/{id}")
    public String takeAssessment(@PathVariable int id, Model model) {
        model.addAttribute("assessment", assessmentService.findById(id));
        model.addAttribute("questions", assessmentService.getQuestions(id));
        return "quiz";
    }

    @PostMapping("/assessment/{id}/submit")
    public String submitAssessment(@PathVariable int id,
                                   @RequestParam("answer") String[] answers,
                                   HttpSession session,
                                   RedirectAttributes ra) {
        User user = (User) session.getAttribute("loggedInUser");
        AssessmentResult result = assessmentService.submitAssessment(user.getId(), id, answers);
        ra.addFlashAttribute("result", result);
        ra.addFlashAttribute("success", "Assessment completed! Score: " + result.getScore() + "/" + result.getTotalPoints());
        return "redirect:/assessment/results";
    }

    @GetMapping("/assessment/results")
    public String resultHistory(HttpSession session, Model model) {
        User user = (User) session.getAttribute("loggedInUser");
        model.addAttribute("results", assessmentService.getResultHistory(user.getId()));
        return "assessment-results";
    }
}

