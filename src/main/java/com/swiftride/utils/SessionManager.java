package com.swiftride.utils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import com.swiftride.model.User;
import com.swiftride.model.Admin;

public class SessionManager {

    private static final int SESSION_TIMEOUT = 30 * 60; // 30 minutes in seconds

    public static void createUserSession(HttpServletRequest request, User user) {
        HttpSession session = request.getSession(true);
        session.setMaxInactiveInterval(SESSION_TIMEOUT);
        session.setAttribute("user", user);
        session.setAttribute("userId", user.getUserId());
        session.setAttribute("userName", user.getFullName());
        session.setAttribute("userEmail", user.getEmail());
        session.setAttribute("isLoggedIn", true);
        session.setAttribute("role", "USER");
    }

    public static void createAdminSession(HttpServletRequest request, Admin admin) {
        HttpSession session = request.getSession(true);
        session.setMaxInactiveInterval(SESSION_TIMEOUT);
        session.setAttribute("admin", admin);
        session.setAttribute("adminId", admin.getAdminId());
        session.setAttribute("adminName", admin.getFullName());
        session.setAttribute("adminEmail", admin.getEmail());
        session.setAttribute("isAdminLoggedIn", true);
        session.setAttribute("role", "ADMIN");
    }

    public static boolean isUserLoggedIn(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        return session != null && session.getAttribute("isLoggedIn") != null
                && (Boolean) session.getAttribute("isLoggedIn");
    }

    public static boolean isAdminLoggedIn(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        return session != null && session.getAttribute("isAdminLoggedIn") != null
                && (Boolean) session.getAttribute("isAdminLoggedIn");
    }

    public static User getLoggedInUser(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            return (User) session.getAttribute("user");
        }
        return null;
    }

    public static Admin getLoggedInAdmin(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            return (Admin) session.getAttribute("admin");
        }
        return null;
    }

    public static void destroySession(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
    }
}
