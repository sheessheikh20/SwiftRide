package com.swiftride.controller;

import com.swiftride.dao.RouteDAO;
import com.google.gson.Gson;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;

public class ApiRoutesServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        RouteDAO routeDAO = new RouteDAO();
        PrintWriter out = response.getWriter();
        out.print(new Gson().toJson(routeDAO.getDistinctCities()));
    }
}
