package com.swiftride.controller;

import com.swiftride.dao.*;
import com.swiftride.model.*;
import com.swiftride.utils.SessionManager;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

public class TicketServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (!SessionManager.isUserLoggedIn(request)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        int bookingId = Integer.parseInt(request.getParameter("id"));
        BookingDAO bookingDAO = new BookingDAO();
        Booking booking = bookingDAO.getBookingById(bookingId);
        List<BookingSeat> passengers = bookingDAO.getBookingSeats(bookingId);

        request.setAttribute("booking", booking);
        request.setAttribute("passengers", passengers);
        request.getRequestDispatcher("/views/booking/ticket.jsp").forward(request, response);
    }
}
