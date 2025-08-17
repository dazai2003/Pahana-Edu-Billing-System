package com.pahanaedu.servlet;

import com.pahanaedu.dao.ItemDAO;
import com.pahanaedu.model.Item;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/updateItem")
public class UpdateItemServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        double price = Double.parseDouble(request.getParameter("price"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        String itemType = request.getParameter("itemType");

        Item item = new Item();
        item.setItemID(id);
        item.setName(name);
        item.setDescription(description);
        item.setPrice(price);
        item.setQuantity(quantity);
        item.setItemType(itemType);

        ItemDAO dao = new ItemDAO();
        dao.updateItem(item);

        response.sendRedirect("view-items.jsp");
    }
}
