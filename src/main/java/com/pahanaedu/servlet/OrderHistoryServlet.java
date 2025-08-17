package com.pahanaedu.servlet;

import com.pahanaedu.dao.OrderDAO;
import com.pahanaedu.model.Order;

import javax.servlet.ServletException;
//import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

//@WebServlet("/OrderHistoryServlet")
public class OrderHistoryServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        List<Order> orders = OrderDAO.getAllOrders();
        request.setAttribute("orders", orders);

        request.getRequestDispatcher("order-history.jsp").forward(request, response);
    }
}
