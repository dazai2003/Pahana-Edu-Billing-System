package com.pahanaedu.servlet;

import com.pahanaedu.dao.CustomerDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/delete-customer")
public class DeleteCustomerServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int customerId = Integer.parseInt(request.getParameter("id"));
        CustomerDAO dao = new CustomerDAO();
        boolean success = dao.deleteCustomer(customerId);

        if (success) {
            response.sendRedirect("view-customers.jsp");
        } else {
            response.getWriter().println("Failed to delete customer.");
        }
    }
}
