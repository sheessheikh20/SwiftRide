package com.swiftride.controller;

import com.swiftride.dao.SeatDAO;
import com.swiftride.model.Seat;
import com.google.gson.Gson;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

public class ApiSeatsServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        int busId = Integer.parseInt(request.getParameter("busId"));
        String date = request.getParameter("date");
        SeatDAO seatDAO = new SeatDAO();
        seatDAO.releaseExpiredLocks();
        List<Seat> seats = seatDAO.getSeatsByBusAndDate(busId, date);
        PrintWriter out = response.getWriter();
        out.print(new Gson().toJson(seats));
    }
}
