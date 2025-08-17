package com.pahanaedu.servlet;

import com.pahanaedu.dao.OrderDAO;
import com.pahanaedu.dao.OrderItemDAO;
import com.pahanaedu.model.Order;
import com.pahanaedu.model.OrderItem;

import javax.servlet.ServletException;
//import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

//@WebServlet("/OrderDetailsServlet")
public class OrderDetailsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        int orderID = Integer.parseInt(request.getParameter("orderID"));

        Order order = OrderDAO.getOrderByID(orderID);
        List<OrderItem> orderItems = OrderItemDAO.getOrderItemsByOrderID(orderID);

        request.setAttribute("order", order);
        request.setAttribute("orderItems", orderItems);

        request.getRequestDispatcher("order-details.jsp").forward(request, response);
    }
}
