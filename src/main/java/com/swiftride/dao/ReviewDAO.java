package com.swiftride.dao;

import com.swiftride.model.Review;
import com.swiftride.utils.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ReviewDAO {

    public boolean addReview(Review review) {
        String sql = "INSERT INTO reviews (user_id, bus_id, booking_id, rating, review_text) VALUES (?,?,?,?,?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, review.getUserId());
            ps.setInt(2, review.getBusId());
            ps.setInt(3, review.getBookingId());
            ps.setInt(4, review.getRating());
            ps.setString(5, review.getReviewText());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }

    public List<Review> getApprovedReviews() {
        List<Review> list = new ArrayList<>();
        String sql = "SELECT r.*, u.full_name AS user_name, b.bus_name FROM reviews r " +
                "JOIN users u ON r.user_id = u.user_id JOIN buses b ON r.bus_id = b.bus_id " +
                "WHERE r.is_approved = TRUE ORDER BY r.created_at DESC LIMIT 10";
        try (Connection conn = DBConnection.getConnection();
             Statement st = conn.createStatement(); ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) { list.add(mapReview(rs)); }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    public List<Review> getAllReviews() {
        List<Review> list = new ArrayList<>();
        String sql = "SELECT r.*, u.full_name AS user_name, b.bus_name FROM reviews r " +
                "JOIN users u ON r.user_id = u.user_id JOIN buses b ON r.bus_id = b.bus_id ORDER BY r.created_at DESC";
        try (Connection conn = DBConnection.getConnection();
             Statement st = conn.createStatement(); ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) { list.add(mapReview(rs)); }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    public boolean approveReview(int reviewId) {
        String sql = "UPDATE reviews SET is_approved = TRUE WHERE review_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, reviewId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }

    public boolean deleteReview(int reviewId) {
        String sql = "DELETE FROM reviews WHERE review_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, reviewId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }

    private Review mapReview(ResultSet rs) throws SQLException {
        Review r = new Review();
        r.setReviewId(rs.getInt("review_id"));
        r.setUserId(rs.getInt("user_id"));
        r.setBusId(rs.getInt("bus_id"));
        r.setBookingId(rs.getInt("booking_id"));
        r.setRating(rs.getInt("rating"));
        r.setReviewText(rs.getString("review_text"));
        r.setCreatedAt(rs.getTimestamp("created_at"));
        r.setApproved(rs.getBoolean("is_approved"));
        try {
            r.setUserName(rs.getString("user_name"));
            r.setBusName(rs.getString("bus_name"));
        } catch (SQLException e) {}
        return r;
    }
}
