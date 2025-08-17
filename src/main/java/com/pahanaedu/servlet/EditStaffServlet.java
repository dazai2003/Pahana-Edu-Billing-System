package com.pahanaedu.servlet;

import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
//import javax.servlet.annotation.WebServlet;

import com.pahanaedu.model.Staff;
import com.pahanaedu.dao.StaffDAO;

//@WebServlet("/EditStaffServlet")
public class EditStaffServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int userID = Integer.parseInt(request.getParameter("userID"));
            String username = request.getParameter("username");
            String role = request.getParameter("role");
            String fullName = request.getParameter("fullName");
            String birthDateStr = request.getParameter("birthDate");
            String address = request.getParameter("address");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");

            // Convert birthDate string to LocalDate
            LocalDate birthDate = null;
            if (birthDateStr != null && !birthDateStr.isEmpty()) {
                try {
                    birthDate = LocalDate.parse(birthDateStr, DateTimeFormatter.ISO_DATE);
                } catch (DateTimeParseException e) {
                    e.printStackTrace();
                    // You can add error handling here (e.g., set a default date or redirect with error)
                }
            }

            // Create and set staff object
            Staff staff = new Staff();
            staff.setUserID(userID);
            staff.setFullName(fullName);
            staff.setBirthDate(birthDate);
            staff.setAddress(address);
            staff.setEmail(email);
            staff.setPhone(phone);

            // Update staff in database (both staff + user table)
            boolean updated = StaffDAO.updateStaff(staff, username, role);

            if (updated) {
                response.sendRedirect("view-staff.jsp?success=1");
            } else {
                response.sendRedirect("edit-staff.jsp?userID=" + userID + "&error=1");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("view-staff.jsp?error=1");
        }
    }
}
