package com.pahanaedu.servlet;

import com.pahanaedu.dao.StaffDAO;
import com.pahanaedu.model.Staff;

import javax.servlet.ServletException;
//import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.time.LocalDate;

//@WebServlet("/AddStaffServlet")
public class AddStaffServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String role = request.getParameter("role");

            Staff staff = new Staff();
            staff.setUsername(username);
            staff.setRole(role);
            staff.setFullName(request.getParameter("fullName"));
            staff.setAddress(request.getParameter("address"));
            staff.setEmail(request.getParameter("email"));
            staff.setPhone(request.getParameter("phone"));

            String birthDateStr = request.getParameter("birthDate");
            if (birthDateStr != null && !birthDateStr.isEmpty()) {
                staff.setBirthDate(LocalDate.parse(birthDateStr));
            }

            // Call DAO
            boolean success = StaffDAO.addStaff(staff, password);

            if (success) {
                response.sendRedirect("view-staff.jsp?success=1");
            } else {
                response.sendRedirect("add-staff.jsp?error=1");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("add-staff.jsp?error=1");
        }
    }
}
