package com.swiftride.controller;

import com.swiftride.dao.*;
import com.google.gson.JsonObject;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;

public class ApiStatsServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        UserDAO userDAO = new UserDAO();
        BusDAO busDAO = new BusDAO();
        RouteDAO routeDAO = new RouteDAO();
        BookingDAO bookingDAO = new BookingDAO();

        JsonObject json = new JsonObject();
        json.addProperty("totalUsers", userDAO.getTotalUsers());
        json.addProperty("totalBuses", busDAO.getTotalBuses());
        json.addProperty("totalRoutes", routeDAO.getTotalRoutes());
        json.addProperty("totalBookings", bookingDAO.getTotalBookings());
        json.addProperty("totalRevenue", bookingDAO.getTotalRevenue());
        PrintWriter out = response.getWriter();
        out.print(json);
    }
}
