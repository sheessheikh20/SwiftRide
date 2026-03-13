package com.swiftride.dao;

import com.swiftride.model.Seat;
import com.swiftride.utils.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SeatDAO {

    public List<Seat> getSeatsByBusAndDate(int busId, String travelDate) {
        List<Seat> seats = new ArrayList<>();
        String sql = "SELECT * FROM seats WHERE bus_id = ? AND travel_date = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, busId);
            ps.setString(2, travelDate);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) { seats.add(mapSeat(rs)); }
        } catch (SQLException e) { e.printStackTrace(); }
        return seats;
    }

    public boolean isSeatBooked(int busId, String seatNumber, String travelDate) {
        String sql = "SELECT is_booked FROM seats WHERE bus_id = ? AND seat_number = ? AND travel_date = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, busId);
            ps.setString(2, seatNumber);
            ps.setString(3, travelDate);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getBoolean("is_booked");
        } catch (SQLException e) { e.printStackTrace(); }
        return false;
    }

    public boolean lockSeat(int busId, String seatNumber, String travelDate, int userId) {
        // First insert if not exists, then update lock
        String upsert = "INSERT INTO seats (bus_id, seat_number, travel_date, locked_until, locked_by, is_booked) " +
                "VALUES (?, ?, ?, DATE_ADD(NOW(), INTERVAL 2 MINUTE), ?, FALSE) " +
                "ON DUPLICATE KEY UPDATE locked_until = DATE_ADD(NOW(), INTERVAL 2 MINUTE), locked_by = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(upsert)) {
            ps.setInt(1, busId);
            ps.setString(2, seatNumber);
            ps.setString(3, travelDate);
            ps.setInt(4, userId);
            ps.setInt(5, userId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }

    public boolean bookSeats(int busId, List<String> seatNumbers, String travelDate) {
        String sql = "INSERT INTO seats (bus_id, seat_number, travel_date, is_booked) VALUES (?, ?, ?, TRUE) " +
                "ON DUPLICATE KEY UPDATE is_booked = TRUE, locked_until = NULL, locked_by = NULL";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            for (String seat : seatNumbers) {
                ps.setInt(1, busId);
                ps.setString(2, seat);
                ps.setString(3, travelDate);
                ps.addBatch();
            }
            int[] results = ps.executeBatch();
            return results.length == seatNumbers.size();
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }

    public boolean releaseExpiredLocks() {
        String sql = "UPDATE seats SET locked_until = NULL, locked_by = NULL WHERE locked_until IS NOT NULL AND locked_until < NOW() AND is_booked = FALSE";
        try (Connection conn = DBConnection.getConnection();
             Statement st = conn.createStatement()) {
            st.executeUpdate(sql);
            return true;
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }

    public boolean releaseSeats(int busId, List<String> seatNumbers, String travelDate) {
        String sql = "UPDATE seats SET is_booked = FALSE WHERE bus_id = ? AND seat_number = ? AND travel_date = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            for (String seat : seatNumbers) {
                ps.setInt(1, busId);
                ps.setString(2, seat);
                ps.setString(3, travelDate);
                ps.addBatch();
            }
            ps.executeBatch();
            return true;
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }

    public int getBookedSeatCount(int busId, String travelDate) {
        String sql = "SELECT COUNT(*) FROM seats WHERE bus_id = ? AND travel_date = ? AND is_booked = TRUE";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, busId);
            ps.setString(2, travelDate);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) { e.printStackTrace(); }
        return 0;
    }

    private Seat mapSeat(ResultSet rs) throws SQLException {
        Seat s = new Seat();
        s.setSeatId(rs.getInt("seat_id"));
        s.setBusId(rs.getInt("bus_id"));
        s.setSeatNumber(rs.getString("seat_number"));
        s.setSeatType(rs.getString("seat_type"));
        s.setBooked(rs.getBoolean("is_booked"));
        s.setTravelDate(rs.getString("travel_date"));
        Timestamp lockedUntil = rs.getTimestamp("locked_until");
        s.setLockedUntil(lockedUntil != null ? lockedUntil.toString() : null);
        s.setLockedBy(rs.getInt("locked_by"));
        return s;
    }
}
