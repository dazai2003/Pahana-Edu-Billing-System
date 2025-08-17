package com.pahanaedu.servlet;

import com.pahanaedu.dao.ItemDAO;
import com.pahanaedu.model.Item;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/addItem")
public class AddItemServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String description = request.getParameter("description");
        double price = Double.parseDouble(request.getParameter("price"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        String itemType = request.getParameter("item_type");

        Item item = new Item();
        item.setName(name);
        item.setDescription(description);
        item.setPrice(price);
        item.setQuantity(quantity);
        item.setItemType(itemType);

        boolean success = ItemDAO.addItem(item);

        if (success) {
            response.sendRedirect("view-items.jsp");  // We will create this next
        } else {
            request.setAttribute("errorMessage", "Failed to add item.");
            request.getRequestDispatcher("add-item.jsp").forward(request, response);
        }
    }
}
