package com.pahanaedu.servlet;

import com.pahanaedu.dao.OrderDAO;
import com.pahanaedu.dao.OrderItemDAO;
import com.pahanaedu.dao.ItemDAO;
import com.pahanaedu.model.OrderItem;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

public class DeleteOrderServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // 1. Get the order ID from the request
            int orderID = Integer.parseInt(request.getParameter("orderID"));

            // 2. Get all items in the order (to restore inventory if needed)
            List<OrderItem> orderItems = OrderItemDAO.getOrderItemsByOrderID(orderID);
            for (OrderItem oi : orderItems) {
                // Restore stock quantities (optional — uncomment if required)
                ItemDAO.increaseQuantity(oi.getItemID(), oi.getQuantity());
            }

            // 3. Delete order items first
            OrderItemDAO.deleteOrderItemsByOrderID(orderID);

            // 4. Delete the order itself
            OrderDAO.deleteOrder(orderID);

            // 5. Redirect back to the orders list
            response.sendRedirect("OrderHistoryServlet?msg=deleted");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("OrderHistoryServlet?error=delete");
        }
    }
}
