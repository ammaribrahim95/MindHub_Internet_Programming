package com.mindhub.interceptor;

import com.mindhub.model.User;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Admin authorization interceptor — ensures only ADMIN users can access /admin/** routes.
 */
@Component
public class AdminInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        HttpSession session = request.getSession(false);

        if (session != null) {
            User user = (User) session.getAttribute("loggedInUser");
            if (user != null && user.isAdmin()) {
                return true;
            }
        }

        // Non-admin user — redirect to dashboard with error
        response.sendRedirect(request.getContextPath() + "/dashboard?error=unauthorized");
        return false;
    }
}

