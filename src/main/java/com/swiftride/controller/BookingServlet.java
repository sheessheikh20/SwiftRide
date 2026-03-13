package com.swiftride.controller;

import com.swiftride.dao.*;
import com.swiftride.model.*;
import com.swiftride.utils.SessionManager;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.*;

public class BookingServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (!SessionManager.isUserLoggedIn(request)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        // Show booking form with selected seats
        int busId = Integer.parseInt(request.getParameter("busId"));
        String date = request.getParameter("date");
        String seats = request.getParameter("seats"); // comma-separated

        BusDAO busDAO = new BusDAO();
        Bus bus = busDAO.getBusById(busId);

        request.setAttribute("bus", bus);
        request.setAttribute("date", date);
        request.setAttribute("selectedSeats", seats);
        request.setAttribute("seatList", seats.split(","));
        request.setAttribute("totalPrice", seats.split(",").length * bus.getTicketPrice());
        request.getRequestDispatcher("/views/booking/booking.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (!SessionManager.isUserLoggedIn(request)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = SessionManager.getLoggedInUser(request);
        int busId = Integer.parseInt(request.getParameter("busId"));
        String date = request.getParameter("date");
        String[] seatNumbers = request.getParameterValues("seatNumber");
        String[] passengerNames = request.getParameterValues("passengerName");
        String[] passengerAges = request.getParameterValues("passengerAge");
        String[] passengerGenders = request.getParameterValues("passengerGender");

        BusDAO busDAO = new BusDAO();
        Bus bus = busDAO.getBusById(busId);

        double totalPrice = seatNumbers.length * bus.getTicketPrice();

        // Create booking
        Booking booking = new Booking();
        booking.setUserId(user.getUserId());
        booking.setBusId(busId);
        booking.setRouteId(bus.getRouteId());
        booking.setTravelDate(date);
        booking.setTotalPrice(totalPrice);

        BookingDAO bookingDAO = new BookingDAO();
        int bookingId = bookingDAO.createBooking(booking);

        if (bookingId > 0) {
            // Add passenger seats
            for (int i = 0; i < seatNumbers.length; i++) {
                BookingSeat bs = new BookingSeat();
                bs.setBookingId(bookingId);
                bs.setSeatNumber(seatNumbers[i]);
                bs.setPassengerName(passengerNames[i]);
                bs.setPassengerAge(Integer.parseInt(passengerAges[i]));
                bs.setPassengerGender(passengerGenders[i]);
                bookingDAO.addBookingSeat(bs);
            }

            // Mark seats as booked
            SeatDAO seatDAO = new SeatDAO();
            seatDAO.bookSeats(busId, Arrays.asList(seatNumbers), date);

            response.sendRedirect(request.getContextPath() + "/ticket?id=" + bookingId);
        } else {
            request.setAttribute("error", "Booking failed. Please try again.");
            doGet(request, response);
        }
    }
}
