package com.swiftride.controller;

import com.swiftride.utils.OTPGenerator;
import com.google.gson.JsonObject;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;

public class OTPServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        JsonObject json = new JsonObject();

        String action = request.getParameter("action");
        HttpSession session = request.getSession();

        if ("send".equals(action)) {
            // Check resend cooldown
            Long lastSent = (Long) session.getAttribute("otpLastSent");
            if (lastSent != null && (System.currentTimeMillis() - lastSent) < 30000) {
                long remaining = 30 - ((System.currentTimeMillis() - lastSent) / 1000);
                json.addProperty("success", false);
                json.addProperty("message", "Please wait " + remaining + " seconds before resending.");
                out.print(json);
                return;
            }

            String otp = OTPGenerator.generateOTP();
            session.setAttribute("otp", otp);
            session.setAttribute("otpExpiry", System.currentTimeMillis() + 120000); // 2 minutes
            session.setAttribute("otpAttempts", 0);
            session.setAttribute("otpLastSent", System.currentTimeMillis());

            json.addProperty("success", true);
            json.addProperty("otp", otp); // Display OTP on screen (NOT email)
            json.addProperty("message", "OTP sent successfully! (Displayed on screen for demo)");

        } else if ("verify".equals(action)) {
            String inputOtp = request.getParameter("otp");
            String storedOtp = (String) session.getAttribute("otp");
            Long expiry = (Long) session.getAttribute("otpExpiry");
            Integer attempts = (Integer) session.getAttribute("otpAttempts");

            if (storedOtp == null || expiry == null) {
                json.addProperty("success", false);
                json.addProperty("message", "No OTP found. Please request a new one.");
                out.print(json);
                return;
            }

            if (attempts != null && attempts >= 3) {
                json.addProperty("success", false);
                json.addProperty("message", "Maximum attempts exceeded. Please request a new OTP.");
                session.removeAttribute("otp");
                out.print(json);
                return;
            }

            if (System.currentTimeMillis() > expiry) {
                json.addProperty("success", false);
                json.addProperty("message", "OTP has expired. Please request a new one.");
                session.removeAttribute("otp");
                out.print(json);
                return;
            }

            if (storedOtp.equals(inputOtp)) {
                session.setAttribute("otpVerified", true);
                json.addProperty("success", true);
                json.addProperty("message", "OTP verified successfully!");
            } else {
                session.setAttribute("otpAttempts", (attempts != null ? attempts : 0) + 1);
                json.addProperty("success", false);
                json.addProperty("message", "Invalid OTP. " + (2 - (attempts != null ? attempts : 0)) + " attempts remaining.");
            }
        }

        out.print(json);
    }
}
