package com.swiftride.dao;

import com.swiftride.model.Admin;
import com.swiftride.utils.DBConnection;
import java.sql.*;

public class AdminDAO {

    public Admin getAdminByEmail(String email) {
        String sql = "SELECT * FROM admins WHERE email = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Admin a = new Admin();
                a.setAdminId(rs.getInt("admin_id"));
                a.setFullName(rs.getString("full_name"));
                a.setEmail(rs.getString("email"));
                a.setPassword(rs.getString("password"));
                a.setRole(rs.getString("role"));
                a.setCreatedAt(rs.getTimestamp("created_at"));
                return a;
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }
}
