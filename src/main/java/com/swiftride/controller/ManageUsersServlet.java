package com.swiftride.controller;

import com.swiftride.dao.UserDAO;
import com.swiftride.utils.SessionManager;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

public class ManageUsersServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (!SessionManager.isAdminLoggedIn(request)) { response.sendRedirect(request.getContextPath() + "/admin-login"); return; }
        UserDAO userDAO = new UserDAO();
        request.setAttribute("users", userDAO.getAllUsers());
        request.getRequestDispatcher("/views/admin/manage_users.jsp").forward(request, response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (!SessionManager.isAdminLoggedIn(request)) { response.sendRedirect(request.getContextPath() + "/admin-login"); return; }
        String action = request.getParameter("action");
        if ("delete".equals(action)) {
            UserDAO userDAO = new UserDAO();
            userDAO.deleteUser(Integer.parseInt(request.getParameter("userId")));
        }
        response.sendRedirect(request.getContextPath() + "/admin/users");
    }
}
