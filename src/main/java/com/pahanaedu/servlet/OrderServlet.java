package com.pahanaedu.servlet;

import com.pahanaedu.dao.OrderDAO;
import com.pahanaedu.dao.OrderItemDAO;
import com.pahanaedu.dao.ItemDAO;
import com.pahanaedu.model.Order;
import com.pahanaedu.model.OrderItem;

import javax.servlet.ServletException;
//import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

//@WebServlet("/OrderServlet")
public class OrderServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {

        try {
            int customerID = Integer.parseInt(request.getParameter("customerID"));

            String[] itemIDs = request.getParameterValues("itemID");
            String[] quantities = request.getParameterValues("quantity");
            String[] discounts = request.getParameterValues("discount");
            String[] itemTotals = request.getParameterValues("itemTotal");

            double orderTotal = 0;
            List<OrderItem> orderItems = new ArrayList<>();

            if (itemIDs != null) {
                for (int i = 0; i < itemIDs.length; i++) {
                    if (itemIDs[i] == null || itemIDs[i].isEmpty()) continue;

                    int itemID = Integer.parseInt(itemIDs[i]);
                    int quantity = Integer.parseInt(quantities[i]);
                    double discount = Double.parseDouble(discounts[i]);
                    double total = Double.parseDouble(itemTotals[i]);

                    orderTotal += total;

                    OrderItem orderItem = new OrderItem();
                    orderItem.setItemID(itemID);
                    orderItem.setQuantity(quantity);
                    orderItem.setDiscount(discount);
                    orderItem.setTotal(total);
                    orderItems.add(orderItem);

                    ItemDAO.reduceQuantity(itemID, quantity);
                }
            }

            Order order = new Order();
            order.setCustomerID(customerID);
            order.setTotal(orderTotal);

            int orderID = OrderDAO.addOrder(order);

            for (OrderItem oi : orderItems) {
                oi.setOrderID(orderID);
                OrderItemDAO.addOrderItem(oi);
            }

            response.sendRedirect("bill.jsp?orderID=" + orderID);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("order-form.jsp?error=1");
        }
    }
}
