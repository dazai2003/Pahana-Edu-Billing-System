package com.pahanaedu.dao;

import com.pahanaedu.model.User;
import com.pahanaedu.utils.DBConnection;

import java.sql.*;

public class UserDAO {

    public User validateUser(String username, String password) {
        User user = null;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(
                     "SELECT * FROM user WHERE Username = ? AND Password = ?")) {

            ps.setString(1, username);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                user = new User();
                user.setUserID(rs.getInt("user_id"));         // match DB field
                user.setUsername(rs.getString("username"));   // match DB field
                user.setPassword(rs.getString("password"));   // match DB field
                user.setRole(rs.getString("role")); 

                // Debug log
                System.out.println("Login success: " + user.getUsername());
            } else {
                System.out.println("Login failed: No user found.");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return user;
    }
}
