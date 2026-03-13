package com.swiftride.controller;

import com.swiftride.dao.BusDAO;
import com.swiftride.model.Bus;
import com.google.gson.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

public class ApiSearchServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        String from = request.getParameter("from");
        String to = request.getParameter("to");
        String date = request.getParameter("date");
        BusDAO busDAO = new BusDAO();
        List<Bus> buses = busDAO.searchBuses(from, to, date);
        Gson gson = new GsonBuilder().setDateFormat("HH:mm:ss").create();
        PrintWriter out = response.getWriter();
        out.print(gson.toJson(buses));
    }
}
