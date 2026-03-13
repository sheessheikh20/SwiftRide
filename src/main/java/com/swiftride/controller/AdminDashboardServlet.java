package com.swiftride.controller;

import com.swiftride.dao.*;
import com.swiftride.model.*;
import com.swiftride.utils.SessionManager;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

public class AdminDashboardServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (!SessionManager.isAdminLoggedIn(request)) {
            response.sendRedirect(request.getContextPath() + "/admin-login");
            return;
        }
        UserDAO userDAO = new UserDAO();
        BusDAO busDAO = new BusDAO();
        RouteDAO routeDAO = new RouteDAO();
        BookingDAO bookingDAO = new BookingDAO();

        request.setAttribute("totalUsers", userDAO.getTotalUsers());
        request.setAttribute("totalBuses", busDAO.getTotalBuses());
        request.setAttribute("totalRoutes", routeDAO.getTotalRoutes());
        request.setAttribute("totalBookings", bookingDAO.getTotalBookings());
        request.setAttribute("totalRevenue", bookingDAO.getTotalRevenue());

        List<Booking> recentBookings = bookingDAO.getAllBookings();
        if (recentBookings.size() > 10) recentBookings = recentBookings.subList(0, 10);
        request.setAttribute("recentBookings", recentBookings);

        request.getRequestDispatcher("/views/admin/dashboard.jsp").forward(request, response);
    }
}
