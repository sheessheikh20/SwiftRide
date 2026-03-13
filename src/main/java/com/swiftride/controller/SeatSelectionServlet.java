package com.swiftride.controller;

import com.swiftride.dao.BusDAO;
import com.swiftride.dao.SeatDAO;
import com.swiftride.model.Bus;
import com.swiftride.model.Seat;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.*;

public class SeatSelectionServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int busId = Integer.parseInt(request.getParameter("busId"));
        String date = request.getParameter("date");

        BusDAO busDAO = new BusDAO();
        SeatDAO seatDAO = new SeatDAO();

        Bus bus = busDAO.getBusById(busId);
        seatDAO.releaseExpiredLocks(); // Clean up expired locks
        List<Seat> seats = seatDAO.getSeatsByBusAndDate(busId, date);

        // Build a set of booked seat numbers
        Set<String> bookedSeats = new HashSet<>();
        for (Seat s : seats) {
            if (s.isBooked()) bookedSeats.add(s.getSeatNumber());
        }

        request.setAttribute("bus", bus);
        request.setAttribute("date", date);
        request.setAttribute("bookedSeats", bookedSeats);
        request.getRequestDispatcher("/views/booking/seat_selection.jsp").forward(request, response);
    }
}
