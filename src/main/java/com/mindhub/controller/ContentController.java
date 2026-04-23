package com.mindhub.controller;

import com.mindhub.model.Content;
import com.mindhub.model.User;
import com.mindhub.service.ContentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.HttpSession;

/**
 * ContentController — educational content library CRUD.
 */
@Controller
public class ContentController {

    @Autowired
    private ContentService contentService;

    @GetMapping("/content")
    public String contentLibrary(@RequestParam(required = false) String keyword,
                                 @RequestParam(required = false) String category,
                                 Model model) {
        if ((keyword != null && !keyword.isEmpty()) || (category != null && !category.isEmpty())) {
            model.addAttribute("contentList", contentService.search(keyword, category));
        } else {
            model.addAttribute("contentList", contentService.findAll());
        }
        model.addAttribute("categories", contentService.getAllCategories());
        model.addAttribute("keyword", keyword);
        model.addAttribute("selectedCategory", category);
        return "content-library";
    }

    @GetMapping("/content/{id}")
    public String contentDetail(@PathVariable int id, Model model) {
        model.addAttribute("content", contentService.findById(id));
        return "content-detail";
    }

    /** Admin: add content form */
    @GetMapping("/admin/content/add")
    public String showAddContent(Model model) {
        model.addAttribute("categories", contentService.getAllCategories());
        return "content-add";
    }

    /** Admin: save new content */
    @PostMapping("/admin/content/add")
    public String addContent(@RequestParam String title, @RequestParam String description,
                             @RequestParam String contentType, @RequestParam String category,
                             @RequestParam(required = false) String url,
                             @RequestParam(required = false) String duration,
                             HttpSession session, RedirectAttributes ra) {
        User user = (User) session.getAttribute("loggedInUser");
        Content content = new Content();
        content.setTitle(title);
        content.setDescription(description);
        content.setContentType(contentType);
        content.setCategory(category);
        content.setUrl(url);
        content.setDuration(duration);
        content.setAuthorId(user.getId());
        contentService.create(content);
        ra.addFlashAttribute("success", "Content added successfully");
        return "redirect:/content";
    }

    /** Admin: delete content */
    @PostMapping("/admin/content/delete/{id}")
    public String deleteContent(@PathVariable int id, RedirectAttributes ra) {
        contentService.delete(id);
        ra.addFlashAttribute("success", "Content deleted");
        return "redirect:/content";
    }
}

