package com.pahanaedu.dao;

import com.pahanaedu.model.Order;
import com.pahanaedu.utils.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {

    public static int addOrder(Order order) {
        int orderID = -1;
        String sql = "INSERT INTO orders (customer_id, total, order_date) VALUES (?, ?, NOW())";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setInt(1, order.getCustomerID());
            stmt.setDouble(2, order.getTotal());
            stmt.executeUpdate();

            try (ResultSet rs = stmt.getGeneratedKeys()) {
                if (rs.next()) {
                    orderID = rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error adding order: " + e.getMessage());
            e.printStackTrace();
        }
        return orderID;
    }

    public static List<Order> getAllOrders() {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT * FROM orders ORDER BY order_date DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Order order = new Order();
                order.setOrderID(rs.getInt("order_id"));
                order.setCustomerID(rs.getInt("customer_id"));
                order.setTotal(rs.getDouble("total"));
                order.setOrderDate(rs.getTimestamp("order_date"));
                list.add(order);
            }

        } catch (SQLException e) {
            System.err.println("Error retrieving orders: " + e.getMessage());
            e.printStackTrace();
        }

        return list;
    }

    public static Order getOrderByID(int orderID) {
        Order order = null;
        String sql = "SELECT o.order_id, o.customer_id, c.name AS customer_name, " +
                     "o.total, o.order_date " +
                     "FROM orders o " +
                     "JOIN customer c ON o.customer_id = c.customer_id " +
                     "WHERE o.order_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, orderID);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                order = new Order();
                order.setOrderID(rs.getInt("order_id"));
                order.setCustomerID(rs.getInt("customer_id"));
                order.setCustomerName(rs.getString("customer_name")); // new field
                order.setTotal(rs.getDouble("total"));
                order.setOrderDate(rs.getTimestamp("order_date"));
            }
            rs.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return order;
    }
    
 // Count today's orders
    public static int getOrdersTodayCount() {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM orders WHERE DATE(order_date) = CURDATE()";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }
    
    public static boolean deleteOrder(int orderID) {
        String sql = "DELETE FROM orders WHERE order_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, orderID);
            return stmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }




}
