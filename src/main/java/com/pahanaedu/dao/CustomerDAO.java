package com.pahanaedu.dao;

import com.pahanaedu.model.Customer;
import com.pahanaedu.utils.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CustomerDAO {

    // Method to add a new customer
    public static boolean addCustomer(Customer customer) {
        String sql = "INSERT INTO customer (name, address, age, telephone, email) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, customer.getName());
            stmt.setString(2, customer.getAddress());
            stmt.setInt(3, customer.getAge());
            stmt.setString(4, customer.getTelephone());
            stmt.setString(5, customer.getEmail());

            int rows = stmt.executeUpdate();
            return rows > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Method to get all customers
    public static List<Customer> getAllCustomers() {
        List<Customer> list = new ArrayList<>();
        String sql = "SELECT * FROM customer";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Customer c = new Customer();
                c.setCustomerID(rs.getInt("customer_id"));
                c.setName(rs.getString("name"));
                c.setAddress(rs.getString("address"));
                c.setAge(rs.getInt("age"));
                c.setTelephone(rs.getString("telephone"));
                c.setEmail(rs.getString("email"));
                list.add(c);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // ✅ Keep just ONE version of this method
    public Customer getCustomerById(int id) {
        String query = "SELECT * FROM customer WHERE customer_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                Customer customer = new Customer();
                customer.setCustomerID(rs.getInt("customer_id"));
                customer.setName(rs.getString("name"));
                customer.setAddress(rs.getString("address"));
                customer.setAge(rs.getInt("age"));
                customer.setTelephone(rs.getString("telephone"));
                customer.setEmail(rs.getString("email"));
                return customer;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // Update customer details
    public void updateCustomer(Customer customer) {
        String query = "UPDATE customer SET name = ?, address = ?, age = ?, telephone = ?, email = ? WHERE customer_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, customer.getName());
            stmt.setString(2, customer.getAddress());
            stmt.setInt(3, customer.getAge());
            stmt.setString(4, customer.getTelephone());
            stmt.setString(5, customer.getEmail());
            stmt.setInt(6, customer.getCustomerID());

            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        
    }public boolean deleteCustomer(int customerId) {
        String query = "DELETE FROM customer WHERE customer_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, customerId);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public static Customer getCustomerByID(int customerID) {
        Customer customer = null;
        String sql = "SELECT * FROM customer WHERE customer_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, customerID);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                customer = new Customer();
                customer.setCustomerID(rs.getInt("customer_id"));
                customer.setName(rs.getString("name"));
                customer.setAddress(rs.getString("address"));
                customer.setAge(rs.getInt("age"));
                customer.setTelephone(rs.getString("telephone"));
                customer.setEmail(rs.getString("email"));
            }
            rs.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return customer;
    }
    
 // Count total customers
    public static int getTotalCustomersCount() {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM customer";
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



}
