package com.pahanaedu.dao;

import com.pahanaedu.model.Staff;
import com.pahanaedu.utils.DBConnection;

import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class StaffDAO {

    // Add staff: Insert into user first, then into staff table
    public static boolean addStaff(Staff staff, String password) {
        String insertUserSQL = "INSERT INTO user (username, password, role) VALUES (?, ?, ?)";
        String insertStaffSQL = "INSERT INTO staff (user_id, full_name, birth_date, address, email, phone) VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection()) {
            conn.setAutoCommit(false);

            // 1️⃣ Insert into user table
            int generatedUserID = -1;
            try (PreparedStatement psUser = conn.prepareStatement(insertUserSQL, Statement.RETURN_GENERATED_KEYS)) {
                psUser.setString(1, staff.getUsername());
                psUser.setString(2, password); // Hash password in production
                psUser.setString(3, staff.getRole());
                psUser.executeUpdate();

                ResultSet rs = psUser.getGeneratedKeys();
                if (rs.next()) {
                    generatedUserID = rs.getInt(1);
                }
            }

            if (generatedUserID == -1) {
                conn.rollback();
                return false;
            }

            // 2️⃣ Insert into staff table
            try (PreparedStatement psStaff = conn.prepareStatement(insertStaffSQL)) {
                psStaff.setInt(1, generatedUserID);
                psStaff.setString(2, staff.getFullName());
                if (staff.getBirthDate() != null) {
                    psStaff.setDate(3, Date.valueOf(staff.getBirthDate()));
                } else {
                    psStaff.setNull(3, Types.DATE);
                }
                psStaff.setString(4, staff.getAddress());
                psStaff.setString(5, staff.getEmail());
                psStaff.setString(6, staff.getPhone());
                psStaff.executeUpdate();
            }

            conn.commit();
            return true;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Get all staff members (join user + staff tables)
    public static List<Staff> getAllStaff() {
        List<Staff> list = new ArrayList<>();
        String sql = "SELECT u.user_id, u.username, u.role, s.full_name, s.birth_date, s.address, s.email, s.phone " +
                     "FROM user u JOIN staff s ON u.user_id = s.user_id";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Staff staff = new Staff();
                staff.setUserID(rs.getInt("user_id"));
                staff.setUsername(rs.getString("username"));
                staff.setRole(rs.getString("role"));
                staff.setFullName(rs.getString("full_name"));
                if (rs.getDate("birth_date") != null) {
                    staff.setBirthDate(rs.getDate("birth_date").toLocalDate());
                }
                staff.setAddress(rs.getString("address"));
                staff.setEmail(rs.getString("email"));
                staff.setPhone(rs.getString("phone"));
                list.add(staff);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Get single staff member by UserID
    public static Staff getStaffByID(int userID) {
        String sql = "SELECT u.user_id, u.username, u.role, s.full_name, s.birth_date, s.address, s.email, s.phone " +
                     "FROM user u JOIN staff s ON u.user_id = s.user_id WHERE u.user_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userID);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                Staff staff = new Staff();
                staff.setUserID(rs.getInt("user_id"));
                staff.setUsername(rs.getString("username"));
                staff.setRole(rs.getString("role"));
                staff.setFullName(rs.getString("full_name"));
                if (rs.getDate("birth_date") != null) {
                    staff.setBirthDate(rs.getDate("birth_date").toLocalDate());
                }
                staff.setAddress(rs.getString("address"));
                staff.setEmail(rs.getString("email"));
                staff.setPhone(rs.getString("phone"));
                return staff;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // Update staff info (both user + staff tables)
    public static boolean updateStaff(Staff staff, String username, String role) {
        String updateUserSQL = "UPDATE user SET username = ?, role = ? WHERE user_id = ?";
        String updateStaffSQL = "UPDATE staff SET full_name = ?, birth_date = ?, address = ?, email = ?, phone = ? WHERE user_id = ?";

        try (Connection conn = DBConnection.getConnection()) {
            conn.setAutoCommit(false); // Begin transaction

            // 1️⃣ Update user table
            try (PreparedStatement stmtUser = conn.prepareStatement(updateUserSQL)) {
                stmtUser.setString(1, username);
                stmtUser.setString(2, role);
                stmtUser.setInt(3, staff.getUserID());
                stmtUser.executeUpdate();
            }

            // 2️⃣ Update staff table
            try (PreparedStatement stmtStaff = conn.prepareStatement(updateStaffSQL)) {
                stmtStaff.setString(1, staff.getFullName());
                stmtStaff.setDate(2, java.sql.Date.valueOf(staff.getBirthDate())); 
                stmtStaff.setString(3, staff.getAddress());
                stmtStaff.setString(4, staff.getEmail());
                stmtStaff.setString(5, staff.getPhone());
                stmtStaff.setInt(6, staff.getUserID());
                stmtStaff.executeUpdate();
            }

            conn.commit(); // Commit both updates
            return true;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }


    // Delete staff (both staff + user tables)
    public static boolean deleteStaff(int userID) {
        try (Connection conn = DBConnection.getConnection()) {
            conn.setAutoCommit(false);

            try (PreparedStatement ps1 = conn.prepareStatement("DELETE FROM staff WHERE user_id = ?");
                 PreparedStatement ps2 = conn.prepareStatement("DELETE FROM user WHERE user_id = ?")) {

                ps1.setInt(1, userID);
                ps1.executeUpdate();

                ps2.setInt(1, userID);
                ps2.executeUpdate();

                conn.commit();
                return true;
            } catch (Exception e) {
                conn.rollback();
                e.printStackTrace();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    
}
