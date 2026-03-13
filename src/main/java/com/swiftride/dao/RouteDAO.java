package com.swiftride.dao;

import com.swiftride.model.Route;
import com.swiftride.utils.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RouteDAO {

    public List<Route> getAllRoutes() {
        List<Route> routes = new ArrayList<>();
        String sql = "SELECT * FROM routes ORDER BY origin ASC";
        try (Connection conn = DBConnection.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) { routes.add(mapRoute(rs)); }
        } catch (SQLException e) { e.printStackTrace(); }
        return routes;
    }

    public List<Route> getPopularRoutes() {
        List<Route> routes = new ArrayList<>();
        String sql = "SELECT * FROM routes WHERE is_popular = TRUE ORDER BY base_price ASC LIMIT 8";
        try (Connection conn = DBConnection.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) { routes.add(mapRoute(rs)); }
        } catch (SQLException e) { e.printStackTrace(); }
        return routes;
    }

    public Route getRouteById(int routeId) {
        String sql = "SELECT * FROM routes WHERE route_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, routeId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return mapRoute(rs);
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }

    public List<Route> searchRoutes(String origin, String destination) {
        List<Route> routes = new ArrayList<>();
        String sql = "SELECT * FROM routes WHERE LOWER(origin) LIKE ? AND LOWER(destination) LIKE ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "%" + origin.toLowerCase() + "%");
            ps.setString(2, "%" + destination.toLowerCase() + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) { routes.add(mapRoute(rs)); }
        } catch (SQLException e) { e.printStackTrace(); }
        return routes;
    }

    public boolean addRoute(Route route) {
        String sql = "INSERT INTO routes (origin, destination, distance_km, estimated_duration, is_popular, badge, base_price) VALUES (?,?,?,?,?,?,?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, route.getOrigin());
            ps.setString(2, route.getDestination());
            ps.setDouble(3, route.getDistanceKm());
            ps.setString(4, route.getEstimatedDuration());
            ps.setBoolean(5, route.isPopular());
            ps.setString(6, route.getBadge());
            ps.setDouble(7, route.getBasePrice());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }

    public boolean updateRoute(Route route) {
        String sql = "UPDATE routes SET origin=?, destination=?, distance_km=?, estimated_duration=?, is_popular=?, badge=?, base_price=? WHERE route_id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, route.getOrigin());
            ps.setString(2, route.getDestination());
            ps.setDouble(3, route.getDistanceKm());
            ps.setString(4, route.getEstimatedDuration());
            ps.setBoolean(5, route.isPopular());
            ps.setString(6, route.getBadge());
            ps.setDouble(7, route.getBasePrice());
            ps.setInt(8, route.getRouteId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }

    public boolean deleteRoute(int routeId) {
        String sql = "DELETE FROM routes WHERE route_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, routeId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }

    public int getTotalRoutes() {
        String sql = "SELECT COUNT(*) FROM routes";
        try (Connection conn = DBConnection.getConnection();
             Statement st = conn.createStatement(); ResultSet rs = st.executeQuery(sql)) {
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) { e.printStackTrace(); }
        return 0;
    }

    public List<String> getDistinctCities() {
        List<String> cities = new ArrayList<>();
        String sql = "SELECT DISTINCT origin FROM routes UNION SELECT DISTINCT destination FROM routes ORDER BY 1";
        try (Connection conn = DBConnection.getConnection();
             Statement st = conn.createStatement(); ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) { cities.add(rs.getString(1)); }
        } catch (SQLException e) { e.printStackTrace(); }
        return cities;
    }

    private Route mapRoute(ResultSet rs) throws SQLException {
        Route r = new Route();
        r.setRouteId(rs.getInt("route_id"));
        r.setOrigin(rs.getString("origin"));
        r.setDestination(rs.getString("destination"));
        r.setDistanceKm(rs.getDouble("distance_km"));
        r.setEstimatedDuration(rs.getString("estimated_duration"));
        r.setPopular(rs.getBoolean("is_popular"));
        r.setBadge(rs.getString("badge"));
        r.setBasePrice(rs.getDouble("base_price"));
        r.setCreatedAt(rs.getTimestamp("created_at"));
        return r;
    }
}
