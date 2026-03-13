package com.swiftride.controller;

import com.swiftride.dao.UserDAO;
import com.swiftride.model.User;
import com.swiftride.utils.PasswordHash;
import com.swiftride.utils.SessionManager;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

public class ProfileServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (!SessionManager.isUserLoggedIn(request)) { response.sendRedirect(request.getContextPath() + "/login"); return; }
        request.setAttribute("user", SessionManager.getLoggedInUser(request));
        request.getRequestDispatcher("/views/user/profile.jsp").forward(request, response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (!SessionManager.isUserLoggedIn(request)) { response.sendRedirect(request.getContextPath() + "/login"); return; }
        User user = SessionManager.getLoggedInUser(request);
        user.setFullName(request.getParameter("fullName"));
        user.setPhone(request.getParameter("phone"));
        UserDAO userDAO = new UserDAO();
        userDAO.updateUser(user);
        // Refresh session
        User updated = userDAO.getUserById(user.getUserId());
        SessionManager.createUserSession(request, updated);
        response.sendRedirect(request.getContextPath() + "/profile?success=true");
    }
}
