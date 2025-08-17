package com.pahanaedu.servlet;

import com.pahanaedu.dao.CustomerDAO;
import com.pahanaedu.model.Customer;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/add-customer")
public class AddCustomerServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private CustomerDAO customerDAO;

    public void init() {
        customerDAO = new CustomerDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String address = request.getParameter("address");
        int age = Integer.parseInt(request.getParameter("age"));
        String telephone = request.getParameter("telephone");
        String email = request.getParameter("email");

        Customer customer = new Customer();
        customer.setName(name);
        customer.setAddress(address);
        customer.setAge(age);
        customer.setTelephone(telephone);
        customer.setEmail(email);

        boolean success = customerDAO.addCustomer(customer);

        if (success) {
            response.sendRedirect("view-customers.jsp");
        } else {
            request.setAttribute("errorMessage", "Failed to add customer");
            request.getRequestDispatcher("add-customer.jsp").forward(request, response);
        }
    }
}
