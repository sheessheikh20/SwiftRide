package com.swiftride.controller;

import com.swiftride.dao.BookingDAO;
import com.swiftride.utils.SessionManager;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

public class ManageBookingsServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (!SessionManager.isAdminLoggedIn(request)) { response.sendRedirect(request.getContextPath() + "/admin-login"); return; }
        BookingDAO bookingDAO = new BookingDAO();
        request.setAttribute("bookings", bookingDAO.getAllBookings());
        request.getRequestDispatcher("/views/admin/manage_bookings.jsp").forward(request, response);
    }
}
