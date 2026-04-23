package com.mindhub.controller;

import com.mindhub.model.User;
import com.mindhub.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.HttpSession;

/**
 * AuthController — handles login, registration, and logout.
 */
@Controller
public class AuthController {

    @Autowired
    private UserService userService;

    /** Display login page */
    @GetMapping("/login")
    public String showLogin(Model model) {
        return "login";
    }

    /** Process login form */
    @PostMapping("/login")
    public String processLogin(@RequestParam String email,
                               @RequestParam String password,
                               HttpSession session,
                               RedirectAttributes redirectAttributes) {
        User user = userService.authenticate(email, password);
        if (user != null) {
            session.setAttribute("loggedInUser", user);
            session.setAttribute("userId", user.getId());
            session.setAttribute("userRole", user.getRole());

            // Redirect admin to admin dashboard, student to student dashboard
            if (user.isAdmin()) {
                return "redirect:/admin";
            }
            return "redirect:/dashboard";
        }

        redirectAttributes.addFlashAttribute("error", "Invalid email or password");
        return "redirect:/login";
    }

    /** Display registration page */
    @GetMapping("/register")
    public String showRegister(Model model) {
        return "register";
    }

    /** Process registration form */
    @PostMapping("/register")
    public String processRegister(@RequestParam String fullName,
                                  @RequestParam String email,
                                  @RequestParam String password,
                                  @RequestParam String confirmPassword,
                                  RedirectAttributes redirectAttributes) {
        // Validation
        if (!password.equals(confirmPassword)) {
            redirectAttributes.addFlashAttribute("error", "Passwords do not match");
            return "redirect:/register";
        }
        if (userService.emailExists(email)) {
            redirectAttributes.addFlashAttribute("error", "Email already registered");
            return "redirect:/register";
        }
        if (fullName.trim().isEmpty() || email.trim().isEmpty() || password.trim().isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "All fields are required");
            return "redirect:/register";
        }

        User user = new User(fullName.trim(), email.trim(), password, "STUDENT");
        userService.register(user);

        redirectAttributes.addFlashAttribute("success", "Account created successfully! Please log in.");
        return "redirect:/login";
    }

    /** Logout — invalidate session */
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }
}

