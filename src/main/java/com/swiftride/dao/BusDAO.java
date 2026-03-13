package com.swiftride.dao;

import com.swiftride.model.Bus;
import com.swiftride.utils.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BusDAO {

    public List<Bus> searchBuses(String origin, String destination, String travelDate) {
        List<Bus> buses = new ArrayList<>();
        String sql = "SELECT b.*, r.origin, r.destination, r.estimated_duration, " +
                "(b.total_seats - COALESCE((SELECT COUNT(*) FROM seats s WHERE s.bus_id = b.bus_id AND s.travel_date = ? AND s.is_booked = TRUE), 0)) AS available_seats " +
                "FROM buses b JOIN routes r ON b.route_id = r.route_id " +
                "WHERE LOWER(r.origin) LIKE ? AND LOWER(r.destination) LIKE ? AND b.is_active = TRUE";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, travelDate);
            ps.setString(2, "%" + origin.toLowerCase() + "%");
            ps.setString(3, "%" + destination.toLowerCase() + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Bus bus = mapBus(rs);
                bus.setOrigin(rs.getString("origin"));
                bus.setDestination(rs.getString("destination"));
                bus.setEstimatedDuration(rs.getString("estimated_duration"));
                bus.setAvailableSeats(rs.getInt("available_seats"));
                buses.add(bus);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return buses;
    }

    public Bus getBusById(int busId) {
        String sql = "SELECT b.*, r.origin, r.destination, r.estimated_duration FROM buses b JOIN routes r ON b.route_id = r.route_id WHERE b.bus_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, busId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Bus bus = mapBus(rs);
                bus.setOrigin(rs.getString("origin"));
                bus.setDestination(rs.getString("destination"));
                bus.setEstimatedDuration(rs.getString("estimated_duration"));
                return bus;
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }

    public List<Bus> getAllBuses() {
        List<Bus> buses = new ArrayList<>();
        String sql = "SELECT b.*, r.origin, r.destination, r.estimated_duration FROM buses b JOIN routes r ON b.route_id = r.route_id ORDER BY b.bus_name";
        try (Connection conn = DBConnection.getConnection();
             Statement st = conn.createStatement(); ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                Bus bus = mapBus(rs);
                bus.setOrigin(rs.getString("origin"));
                bus.setDestination(rs.getString("destination"));
                bus.setEstimatedDuration(rs.getString("estimated_duration"));
                buses.add(bus);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return buses;
    }

    public boolean addBus(Bus bus) {
        String sql = "INSERT INTO buses (bus_name, bus_type, bus_number, total_seats, route_id, departure_time, arrival_time, ticket_price, amenities, operator_name) VALUES (?,?,?,?,?,?,?,?,?,?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, bus.getBusName());
            ps.setString(2, bus.getBusType());
            ps.setString(3, bus.getBusNumber());
            ps.setInt(4, bus.getTotalSeats());
            ps.setInt(5, bus.getRouteId());
            ps.setTime(6, bus.getDepartureTime());
            ps.setTime(7, bus.getArrivalTime());
            ps.setDouble(8, bus.getTicketPrice());
            ps.setString(9, bus.getAmenities());
            ps.setString(10, bus.getOperatorName());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }

    public boolean updateBus(Bus bus) {
        String sql = "UPDATE buses SET bus_name=?, bus_type=?, bus_number=?, total_seats=?, route_id=?, departure_time=?, arrival_time=?, ticket_price=?, amenities=?, operator_name=?, is_active=? WHERE bus_id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, bus.getBusName());
            ps.setString(2, bus.getBusType());
            ps.setString(3, bus.getBusNumber());
            ps.setInt(4, bus.getTotalSeats());
            ps.setInt(5, bus.getRouteId());
            ps.setTime(6, bus.getDepartureTime());
            ps.setTime(7, bus.getArrivalTime());
            ps.setDouble(8, bus.getTicketPrice());
            ps.setString(9, bus.getAmenities());
            ps.setString(10, bus.getOperatorName());
            ps.setBoolean(11, bus.isActive());
            ps.setInt(12, bus.getBusId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }

    public boolean deleteBus(int busId) {
        String sql = "DELETE FROM buses WHERE bus_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, busId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }

    public int getTotalBuses() {
        try (Connection conn = DBConnection.getConnection();
             Statement st = conn.createStatement(); ResultSet rs = st.executeQuery("SELECT COUNT(*) FROM buses")) {
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) { e.printStackTrace(); }
        return 0;
    }

    private Bus mapBus(ResultSet rs) throws SQLException {
        Bus b = new Bus();
        b.setBusId(rs.getInt("bus_id"));
        b.setBusName(rs.getString("bus_name"));
        b.setBusType(rs.getString("bus_type"));
        b.setBusNumber(rs.getString("bus_number"));
        b.setTotalSeats(rs.getInt("total_seats"));
        b.setRouteId(rs.getInt("route_id"));
        b.setDepartureTime(rs.getTime("departure_time"));
        b.setArrivalTime(rs.getTime("arrival_time"));
        b.setTicketPrice(rs.getDouble("ticket_price"));
        b.setAmenities(rs.getString("amenities"));
        b.setRating(rs.getDouble("rating"));
        b.setTotalRatings(rs.getInt("total_ratings"));
        b.setOperatorName(rs.getString("operator_name"));
        b.setActive(rs.getBoolean("is_active"));
        b.setCreatedAt(rs.getTimestamp("created_at"));
        return b;
    }
}
