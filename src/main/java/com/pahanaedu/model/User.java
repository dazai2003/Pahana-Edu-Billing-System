package com.pahanaedu.model;

public class User {
    private int userID;
    private String username;
    private String password;
    private String role;

    // Getters and Setters
    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    // Optional: for debugging
    @Override
    public String toString() {
        return "User{userID=" + userID + ", username=" + username + ", role=" + role + "}";
    }
    
    
}
