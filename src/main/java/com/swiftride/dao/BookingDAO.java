package com.swiftride.dao;

import com.swiftride.model.Booking;
import com.swiftride.model.BookingSeat;
import com.swiftride.utils.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

public class BookingDAO {

    public int createBooking(Booking booking) {
        String code = "SR-" + System.currentTimeMillis();
        String pnr = String.valueOf((long)(Math.random() * 9000000000L) + 1000000000L);
        String sql = "INSERT INTO bookings (booking_code, pnr_number, user_id, bus_id, route_id, travel_date, total_price, payment_status, booking_status) VALUES (?,?,?,?,?,?,?,?,?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, code);
            ps.setString(2, pnr);
            ps.setInt(3, booking.getUserId());
            ps.setInt(4, booking.getBusId());
            ps.setInt(5, booking.getRouteId());
            ps.setString(6, booking.getTravelDate());
            ps.setDouble(7, booking.getTotalPrice());
            ps.setString(8, "PAID");
            ps.setString(9, "CONFIRMED");
            ps.executeUpdate();
            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) { e.printStackTrace(); }
        return -1;
    }

    public boolean addBookingSeat(BookingSeat bs) {
        String sql = "INSERT INTO booking_seats (booking_id, seat_number, passenger_name, passenger_age, passenger_gender) VALUES (?,?,?,?,?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, bs.getBookingId());
            ps.setString(2, bs.getSeatNumber());
            ps.setString(3, bs.getPassengerName());
            ps.setInt(4, bs.getPassengerAge());
            ps.setString(5, bs.getPassengerGender());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }

    public Booking getBookingById(int bookingId) {
        String sql = "SELECT bk.*, b.bus_name, b.bus_type, r.origin, r.destination, " +
                "b.departure_time AS dep_time, b.arrival_time AS arr_time " +
                "FROM bookings bk JOIN buses b ON bk.bus_id = b.bus_id JOIN routes r ON bk.route_id = r.route_id " +
                "WHERE bk.booking_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, bookingId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return mapBooking(rs);
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }

    public Booking getBookingByCode(String code) {
        String sql = "SELECT bk.*, b.bus_name, b.bus_type, r.origin, r.destination, " +
                "b.departure_time AS dep_time, b.arrival_time AS arr_time " +
                "FROM bookings bk JOIN buses b ON bk.bus_id = b.bus_id JOIN routes r ON bk.route_id = r.route_id " +
                "WHERE bk.booking_code = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, code);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return mapBooking(rs);
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }

    public List<Booking> getBookingsByUser(int userId) {
        List<Booking> list = new ArrayList<>();
        String sql = "SELECT bk.*, b.bus_name, b.bus_type, r.origin, r.destination, " +
                "b.departure_time AS dep_time, b.arrival_time AS arr_time " +
                "FROM bookings bk JOIN buses b ON bk.bus_id = b.bus_id JOIN routes r ON bk.route_id = r.route_id " +
                "WHERE bk.user_id = ? ORDER BY bk.booking_date DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) { list.add(mapBooking(rs)); }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    public List<Booking> getAllBookings() {
        List<Booking> list = new ArrayList<>();
        String sql = "SELECT bk.*, b.bus_name, b.bus_type, r.origin, r.destination, " +
                "b.departure_time AS dep_time, b.arrival_time AS arr_time, u.full_name AS passenger_name " +
                "FROM bookings bk JOIN buses b ON bk.bus_id = b.bus_id JOIN routes r ON bk.route_id = r.route_id " +
                "JOIN users u ON bk.user_id = u.user_id ORDER BY bk.booking_date DESC";
        try (Connection conn = DBConnection.getConnection();
             Statement st = conn.createStatement(); ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                Booking bk = mapBooking(rs);
                bk.setPassengerName(rs.getString("passenger_name"));
                list.add(bk);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    public List<BookingSeat> getBookingSeats(int bookingId) {
        List<BookingSeat> list = new ArrayList<>();
        String sql = "SELECT * FROM booking_seats WHERE booking_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, bookingId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                BookingSeat bs = new BookingSeat();
                bs.setId(rs.getInt("id"));
                bs.setBookingId(rs.getInt("booking_id"));
                bs.setSeatNumber(rs.getString("seat_number"));
                bs.setPassengerName(rs.getString("passenger_name"));
                bs.setPassengerAge(rs.getInt("passenger_age"));
                bs.setPassengerGender(rs.getString("passenger_gender"));
                list.add(bs);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    public boolean cancelBooking(int bookingId) {
        String sql = "UPDATE bookings SET booking_status = 'CANCELLED', payment_status = 'REFUNDED' WHERE booking_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, bookingId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }

    public int getTotalBookings() {
        try (Connection conn = DBConnection.getConnection();
             Statement st = conn.createStatement(); ResultSet rs = st.executeQuery("SELECT COUNT(*) FROM bookings")) {
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) { e.printStackTrace(); }
        return 0;
    }

    public double getTotalRevenue() {
        try (Connection conn = DBConnection.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery("SELECT COALESCE(SUM(total_price), 0) FROM bookings WHERE payment_status = 'PAID'")) {
            if (rs.next()) return rs.getDouble(1);
        } catch (SQLException e) { e.printStackTrace(); }
        return 0;
    }

    public int getUpcomingTrips(int userId) {
        String sql = "SELECT COUNT(*) FROM bookings WHERE user_id = ? AND travel_date >= CURDATE() AND booking_status = 'CONFIRMED'";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) { e.printStackTrace(); }
        return 0;
    }

    public int getCancelledTrips(int userId) {
        String sql = "SELECT COUNT(*) FROM bookings WHERE user_id = ? AND booking_status = 'CANCELLED'";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) { e.printStackTrace(); }
        return 0;
    }

    public List<int[]> getBookingsPerDay() {
        List<int[]> data = new ArrayList<>();
        String sql = "SELECT DAYOFWEEK(booking_date) as dow, COUNT(*) as cnt FROM bookings WHERE booking_date >= DATE_SUB(CURDATE(), INTERVAL 7 DAY) GROUP BY dow ORDER BY dow";
        try (Connection conn = DBConnection.getConnection();
             Statement st = conn.createStatement(); ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) { data.add(new int[]{rs.getInt("dow"), rs.getInt("cnt")}); }
        } catch (SQLException e) { e.printStackTrace(); }
        return data;
    }

    private Booking mapBooking(ResultSet rs) throws SQLException {
        Booking b = new Booking();
        b.setBookingId(rs.getInt("booking_id"));
        b.setBookingCode(rs.getString("booking_code"));
        b.setPnrNumber(rs.getString("pnr_number"));
        b.setUserId(rs.getInt("user_id"));
        b.setBusId(rs.getInt("bus_id"));
        b.setRouteId(rs.getInt("route_id"));
        b.setTravelDate(rs.getString("travel_date"));
        b.setBookingDate(rs.getTimestamp("booking_date"));
        b.setTotalPrice(rs.getDouble("total_price"));
        b.setPaymentStatus(rs.getString("payment_status"));
        b.setBookingStatus(rs.getString("booking_status"));
        try {
            b.setBusName(rs.getString("bus_name"));
            b.setBusType(rs.getString("bus_type"));
            b.setOrigin(rs.getString("origin"));
            b.setDestination(rs.getString("destination"));
            b.setDepartureTime(rs.getString("dep_time"));
            b.setArrivalTime(rs.getString("arr_time"));
        } catch (SQLException e) { /* columns may not exist in all queries */ }
        return b;
    }
}
