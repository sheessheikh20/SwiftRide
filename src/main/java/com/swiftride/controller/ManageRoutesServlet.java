package com.swiftride.controller;

import com.swiftride.dao.RouteDAO;
import com.swiftride.model.Route;
import com.swiftride.utils.SessionManager;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

public class ManageRoutesServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (!SessionManager.isAdminLoggedIn(request)) { response.sendRedirect(request.getContextPath() + "/admin-login"); return; }
        RouteDAO routeDAO = new RouteDAO();
        request.setAttribute("routes", routeDAO.getAllRoutes());
        request.getRequestDispatcher("/views/admin/manage_routes.jsp").forward(request, response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (!SessionManager.isAdminLoggedIn(request)) { response.sendRedirect(request.getContextPath() + "/admin-login"); return; }
        String action = request.getParameter("action");
        RouteDAO routeDAO = new RouteDAO();
        if ("add".equals(action)) {
            Route r = new Route();
            r.setOrigin(request.getParameter("origin"));
            r.setDestination(request.getParameter("destination"));
            r.setDistanceKm(Double.parseDouble(request.getParameter("distanceKm")));
            r.setEstimatedDuration(request.getParameter("estimatedDuration"));
            r.setPopular("on".equals(request.getParameter("isPopular")));
            r.setBadge(request.getParameter("badge"));
            r.setBasePrice(Double.parseDouble(request.getParameter("basePrice")));
            routeDAO.addRoute(r);
        } else if ("delete".equals(action)) {
            routeDAO.deleteRoute(Integer.parseInt(request.getParameter("routeId")));
        }
        response.sendRedirect(request.getContextPath() + "/admin/routes");
    }
}
