package com.swiftride.controller;

import com.swiftride.dao.*;
import com.swiftride.model.Admin;
import com.swiftride.utils.PasswordHash;
import com.swiftride.utils.SessionManager;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

public class AdminLoginServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (SessionManager.isAdminLoggedIn(request)) {
            response.sendRedirect(request.getContextPath() + "/admin/dashboard");
            return;
        }
        request.getRequestDispatcher("/views/admin/login.jsp").forward(request, response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        AdminDAO adminDAO = new AdminDAO();
        Admin admin = adminDAO.getAdminByEmail(email);
        if (admin != null && PasswordHash.verifyPassword(password, admin.getPassword())) {
            SessionManager.createAdminSession(request, admin);
            response.sendRedirect(request.getContextPath() + "/admin/dashboard");
        } else {
            request.setAttribute("error", "Invalid admin credentials.");
            request.getRequestDispatcher("/views/admin/login.jsp").forward(request, response);
        }
    }
}
