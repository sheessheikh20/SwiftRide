package com.swiftride.controller;

import com.swiftride.dao.ReviewDAO;
import com.swiftride.model.Review;
import com.swiftride.utils.SessionManager;
import com.swiftride.model.User;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

public class ReviewServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (!SessionManager.isUserLoggedIn(request)) { response.sendRedirect(request.getContextPath() + "/login"); return; }
        User user = SessionManager.getLoggedInUser(request);
        Review review = new Review();
        review.setUserId(user.getUserId());
        review.setBusId(Integer.parseInt(request.getParameter("busId")));
        review.setBookingId(Integer.parseInt(request.getParameter("bookingId")));
        review.setRating(Integer.parseInt(request.getParameter("rating")));
        review.setReviewText(request.getParameter("reviewText"));
        ReviewDAO reviewDAO = new ReviewDAO();
        reviewDAO.addReview(review);
        response.sendRedirect(request.getContextPath() + "/dashboard?reviewSuccess=true");
    }
}
