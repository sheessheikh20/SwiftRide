package com.swiftride.controller;

import com.swiftride.dao.*;
import com.swiftride.model.*;
import com.swiftride.utils.SessionManager;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Time;
import java.util.List;

public class ManageBusesServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (!SessionManager.isAdminLoggedIn(request)) { response.sendRedirect(request.getContextPath() + "/admin-login"); return; }
        BusDAO busDAO = new BusDAO();
        RouteDAO routeDAO = new RouteDAO();
        request.setAttribute("buses", busDAO.getAllBuses());
        request.setAttribute("routes", routeDAO.getAllRoutes());
        request.getRequestDispatcher("/views/admin/manage_buses.jsp").forward(request, response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (!SessionManager.isAdminLoggedIn(request)) { response.sendRedirect(request.getContextPath() + "/admin-login"); return; }
        String action = request.getParameter("action");
        BusDAO busDAO = new BusDAO();
        if ("add".equals(action)) {
            Bus bus = new Bus();
            bus.setBusName(request.getParameter("busName"));
            bus.setBusType(request.getParameter("busType"));
            bus.setBusNumber(request.getParameter("busNumber"));
            bus.setTotalSeats(Integer.parseInt(request.getParameter("totalSeats")));
            bus.setRouteId(Integer.parseInt(request.getParameter("routeId")));
            bus.setDepartureTime(Time.valueOf(request.getParameter("departureTime") + ":00"));
            bus.setArrivalTime(Time.valueOf(request.getParameter("arrivalTime") + ":00"));
            bus.setTicketPrice(Double.parseDouble(request.getParameter("ticketPrice")));
            bus.setAmenities(request.getParameter("amenities"));
            bus.setOperatorName(request.getParameter("operatorName"));
            busDAO.addBus(bus);
        } else if ("delete".equals(action)) {
            busDAO.deleteBus(Integer.parseInt(request.getParameter("busId")));
        }
        response.sendRedirect(request.getContextPath() + "/admin/buses");
    }
}
