package com.pahanaedu.servlet;

import com.pahanaedu.dao.ItemDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/deleteItem")
public class DeleteItemServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        ItemDAO dao = new ItemDAO();
        dao.deleteItem(id);

        response.sendRedirect("view-items.jsp");
    }
}
