package com.mindhub.controller;

import com.mindhub.model.ForumPost;
import com.mindhub.model.ForumReply;
import com.mindhub.model.User;
import com.mindhub.service.ForumService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.HttpSession;

/**
 * ForumController — peer support forum with anonymous posting.
 */
@Controller
public class ForumController {

    @Autowired
    private ForumService forumService;

    @GetMapping("/forum")
    public String forum(@RequestParam(required = false) String category, Model model) {
        if (category != null && !category.isEmpty()) {
            model.addAttribute("posts", forumService.getPostsByCategory(category));
        } else {
            model.addAttribute("posts", forumService.getAllPosts());
        }
        model.addAttribute("selectedCategory", category);
        return "forum";
    }

    @GetMapping("/forum/thread/{id}")
    public String viewThread(@PathVariable int id, Model model) {
        model.addAttribute("post", forumService.getPostById(id));
        model.addAttribute("replies", forumService.getReplies(id));
        return "forum-thread";
    }

    @PostMapping("/forum/post")
    public String createPost(@RequestParam String title, @RequestParam String content,
                             @RequestParam(required = false) String category,
                             @RequestParam(required = false, defaultValue = "true") boolean anonymous,
                             HttpSession session, RedirectAttributes ra) {
        User user = (User) session.getAttribute("loggedInUser");
        ForumPost post = new ForumPost();
        post.setUserId(user.getId());
        post.setTitle(title);
        post.setContent(content);
        post.setCategory(category != null ? category : "General");
        post.setAnonymous(anonymous);
        forumService.createPost(post);
        ra.addFlashAttribute("success", "Post created! +15 points");
        return "redirect:/forum";
    }

    @PostMapping("/forum/reply")
    public String addReply(@RequestParam int postId, @RequestParam String content,
                           @RequestParam(required = false, defaultValue = "true") boolean anonymous,
                           HttpSession session, RedirectAttributes ra) {
        User user = (User) session.getAttribute("loggedInUser");
        ForumReply reply = new ForumReply();
        reply.setPostId(postId);
        reply.setUserId(user.getId());
        reply.setContent(content);
        reply.setAnonymous(anonymous);
        forumService.addReply(reply);
        ra.addFlashAttribute("success", "Reply posted! +5 points");
        return "redirect:/forum/thread/" + postId;
    }

    @PostMapping("/forum/report/{id}")
    public String reportPost(@PathVariable int id, RedirectAttributes ra) {
        forumService.reportPost(id);
        ra.addFlashAttribute("success", "Post reported. Thank you for helping keep the community safe.");
        return "redirect:/forum";
    }
}

