package com.pahanaedu.servlet;

import com.pahanaedu.dao.StaffDAO;

import javax.servlet.ServletException;
//import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

//@WebServlet("/DeleteStaffServlet")
public class DeleteStaffServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int userID = Integer.parseInt(request.getParameter("userID"));
            boolean success = StaffDAO.deleteStaff(userID);

            if (success) {
                response.sendRedirect("view-staff.jsp?deleted=1");
            } else {
                response.sendRedirect("view-staff.jsp?error=1");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("view-staff.jsp?error=1");
        }
    }
}
