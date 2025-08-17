package com.pahanaedu.servlet;

import com.pahanaedu.dao.CustomerDAO;
import com.pahanaedu.model.Customer;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/update-customer")
public class UpdateCustomerServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private CustomerDAO customerDAO;

    public void init() {
        customerDAO = new CustomerDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int customerID = Integer.parseInt(request.getParameter("customerID"));
        String name = request.getParameter("name");
        String address = request.getParameter("address");
        int age = Integer.parseInt(request.getParameter("age"));
        String telephone = request.getParameter("telephone");
        String email = request.getParameter("email");

        Customer customer = new Customer();
        customer.setCustomerID(customerID);
        customer.setName(name);
        customer.setAddress(address);
        customer.setAge(age);
        customer.setTelephone(telephone);
        customer.setEmail(email);

        customerDAO.updateCustomer(customer);

        response.sendRedirect("view-customers.jsp");
    }
}
