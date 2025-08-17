package com.pahanaedu.dao;

import com.pahanaedu.model.OrderItem;
import com.pahanaedu.utils.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;
import java.util.ArrayList;

public class OrderItemDAO {

    public static boolean addOrderItem(OrderItem orderItem) {
        String sql = "INSERT INTO order_items (order_id, item_id, quantity, discount, total) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, orderItem.getOrderID());
            stmt.setInt(2, orderItem.getItemID());
            stmt.setInt(3, orderItem.getQuantity());
            stmt.setDouble(4, orderItem.getDiscount());
            stmt.setDouble(5, orderItem.getTotal());

            return stmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public static List<OrderItem> getOrderItemsByOrderID(int orderID) {
        List<OrderItem> list = new ArrayList<>();
        String sql = "SELECT oi.item_id, i.name AS item_name, oi.quantity, oi.discount, oi.total " +
                     "FROM order_items oi " +
                     "JOIN items i ON oi.item_id = i.item_id " +
                     "WHERE oi.order_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, orderID);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                OrderItem oi = new OrderItem();
                oi.setItemID(rs.getInt("item_id"));
                oi.setItemName(rs.getString("item_name")); // new field
                oi.setQuantity(rs.getInt("quantity"));
                oi.setDiscount(rs.getDouble("discount"));
                oi.setTotal(rs.getDouble("total"));
                list.add(oi);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
    
    public static boolean deleteOrderItemsByOrderID(int orderID) {
        String sql = "DELETE FROM order_items WHERE order_id = ?";
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
