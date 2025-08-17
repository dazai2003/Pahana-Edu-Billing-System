package com.pahanaedu.utils;

import java.sql.Connection;

public class DBTest {
    public static void main(String[] args) {
        try {
            Connection conn = DBConnection.getConnection();
            if (conn != null) {
                System.out.println("✅ Database connected successfully!");
                conn.close();
            } else {
                System.out.println("❌ Failed to connect to database.");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
