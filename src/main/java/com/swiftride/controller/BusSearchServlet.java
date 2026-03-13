package com.swiftride.controller;

import com.swiftride.dao.BusDAO;
import com.swiftride.dao.RouteDAO;
import com.swiftride.model.Bus;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

public class BusSearchServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String from = request.getParameter("from");
        String to = request.getParameter("to");
        String date = request.getParameter("date");

        if (from != null && to != null && date != null) {
            BusDAO busDAO = new BusDAO();
            List<Bus> buses = busDAO.searchBuses(from, to, date);
            request.setAttribute("buses", buses);
            request.setAttribute("from", from);
            request.setAttribute("to", to);
            request.setAttribute("date", date);
            request.setAttribute("resultCount", buses.size());
        }

        RouteDAO routeDAO = new RouteDAO();
        request.setAttribute("cities", routeDAO.getDistinctCities());
        request.getRequestDispatcher("/views/booking/search_results.jsp").forward(request, response);
    }
}
