package com.swiftride.controller;

import com.swiftride.dao.BookingDAO;
import com.swiftride.model.*;
import com.swiftride.utils.SessionManager;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

public class UserDashboardServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (!SessionManager.isUserLoggedIn(request)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        User user = SessionManager.getLoggedInUser(request);
        BookingDAO bookingDAO = new BookingDAO();

        List<Booking> bookings = bookingDAO.getBookingsByUser(user.getUserId());
        int upcomingTrips = bookingDAO.getUpcomingTrips(user.getUserId());
        int totalBookings = bookings.size();
        int cancelledTrips = bookingDAO.getCancelledTrips(user.getUserId());

        request.setAttribute("user", user);
        request.setAttribute("bookings", bookings);
        request.setAttribute("upcomingTrips", upcomingTrips);
        request.setAttribute("totalBookings", totalBookings);
        request.setAttribute("cancelledTrips", cancelledTrips);
        request.getRequestDispatcher("/views/user/dashboard.jsp").forward(request, response);
    }
}
