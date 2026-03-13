package com.swiftride.controller;

import com.swiftride.utils.SessionManager;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

public class LogoutServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        SessionManager.destroySession(request);
        response.sendRedirect(request.getContextPath() + "/login");
    }
}
