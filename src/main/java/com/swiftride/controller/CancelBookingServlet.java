package com.swiftride.controller;

import com.swiftride.dao.*;
import com.swiftride.model.*;
import com.swiftride.utils.SessionManager;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.*;

public class CancelBookingServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (!SessionManager.isUserLoggedIn(request)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        int bookingId = Integer.parseInt(request.getParameter("bookingId"));
        BookingDAO bookingDAO = new BookingDAO();
        Booking booking = bookingDAO.getBookingById(bookingId);

        if (booking != null) {
            // Cancel booking
            bookingDAO.cancelBooking(bookingId);
            // Release seats
            List<BookingSeat> seats = bookingDAO.getBookingSeats(bookingId);
            List<String> seatNumbers = new ArrayList<>();
            for (BookingSeat bs : seats) { seatNumbers.add(bs.getSeatNumber()); }
            SeatDAO seatDAO = new SeatDAO();
            seatDAO.releaseSeats(booking.getBusId(), seatNumbers, booking.getTravelDate());
        }
        response.sendRedirect(request.getContextPath() + "/dashboard");
    }
}
