<%@ page import="com.pahanaedu.dao.OrderDAO, com.pahanaedu.dao.OrderItemDAO, com.pahanaedu.dao.CustomerDAO, com.pahanaedu.dao.ItemDAO" %>
<%@ page import="com.pahanaedu.model.Order, com.pahanaedu.model.OrderItem, com.pahanaedu.model.Customer, com.pahanaedu.model.Item" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
<title>Invoice</title>
<style>
    body {
        font-family: 'Segoe UI', Tahoma, sans-serif;
        background-color: #F5F5F5;
        color: #333;
        margin: 0;
        padding: 20px;
    }
    .invoice-container {
        background: #fff;
        max-width: 800px;
        margin: auto;
        padding: 30px;
        border-radius: 10px;
        box-shadow: 0 5px 15px rgba(0,0,0,0.1);
    }
    .invoice-header {
        text-align: center;
        border-bottom: 3px solid #5F9EA0;
        padding-bottom: 15px;
        margin-bottom: 25px;
    }
    .invoice-header h1 {
        margin: 0;
        color: #2C3E50;
    }
    .invoice-header p {
        margin: 3px 0;
        color: #777;
    }
    .invoice-info {
        display: flex;
        justify-content: space-between;
        flex-wrap: wrap;
        margin-bottom: 20px;
    }
    .info-block {
        min-width: 200px;
    }
    h3 {
        color: #2C3E50;
        margin-bottom: 10px;
        margin-top: 20px;
    }
    table {
        border-collapse: collapse;
        width: 100%;
        margin-bottom: 20px;
    }
    th, td {
        border: 1px solid #ddd;
        padding: 10px 8px;
        font-size: 0.95rem;
    }
    th {
        background-color: #5F9EA0;
        color: white;
    }
    .total-row {
        background: #EAF6F6;
        font-weight: bold;
    }
    .payment-summary {
        margin-top: 20px;
        border: 1px solid #ddd;
        border-radius: 6px;
        padding: 10px;
        background: #FAFAFA;
    }
    .payment-summary p {
        margin: 5px 0;
        font-size: 1rem;
    }
    .payment-summary .given {
        background: #FFF3CD;
        padding: 5px;
        border-radius: 4px;
    }
    .payment-summary .change {
        background: #D4EDDA;
        padding: 5px;
        border-radius: 4px;
    }
    .invoice-footer {
        text-align: center;
        margin-top: 30px;
        font-size: 0.85rem;
        color: #777;
        border-top: 1px solid #ddd;
        padding-top: 10px;
    }
    .actions {
        text-align: center;
        margin-top: 20px;
    }
    .btn {
        background-color: #E67E22;
        color: white;
        padding: 8px 16px;
        border: none;
        border-radius: 6px;
        cursor: pointer;
        text-decoration: none;
        margin: 5px;
        display: inline-block;
    }
    @media print {
        body { background: white; }
        .actions { display: none; }
        .invoice-container { box-shadow: none; border: none; }
    }
</style>
</head>
<body>

<%
String orderIdStr = request.getParameter("orderID");
String givenMoneyStr = request.getParameter("givenMoney");
String changeStr = request.getParameter("changeGiven");

double givenMoney = 0;
double change = 0;
try { givenMoney = Double.parseDouble(givenMoneyStr); } catch(Exception e) {}
try { change = Double.parseDouble(changeStr); } catch(Exception e) {}

if (orderIdStr == null) {
%>
    <div class="invoice-container">
        <h2>Error</h2>
        <p>No order specified.</p>
        <a href="dashboard.jsp" class="btn">← Back to Dashboard</a>
    </div>
<%
    return;
}

int orderID = Integer.parseInt(orderIdStr);
Order order = OrderDAO.getOrderByID(orderID);
if (order == null) {
%>
    <div class="invoice-container">
        <h2>Error</h2>
        <p>Order not found.</p>
        <a href="dashboard.jsp" class="btn">← Back to Dashboard</a>
    </div>
<%
    return;
}
Customer customer = CustomerDAO.getCustomerByID(order.getCustomerID());
List<OrderItem> orderItems = OrderItemDAO.getOrderItemsByOrderID(orderID);
%>

<div class="invoice-container">
    <div class="invoice-header">
        <h1>Pahana Edu Bookshop</h1>
        <p>123 Main Street, Colombo, Sri Lanka</p>
        <p>Tel: +94 77 123 4567 | Email: info@pahanaedu.lk</p>
    </div>

    <div class="invoice-info">
        <div class="info-block">
            <p><b>Invoice No:</b> #<%= order.getOrderID() %></p>
            <p><b>Date:</b> <%= order.getOrderDate() %></p>
        </div>
        <div class="info-block" style="text-align: right;">
            <p><b>Customer:</b> <%= customer != null ? customer.getName() : "N/A" %></p>
            <p><b>Customer ID:</b> CUS-<%= String.format("%04d", order.getCustomerID()) %></p>
        </div>
    </div>

    <h3>Order Details</h3>
    <table>
        <tr>
            <th>Item ID</th>
            <th>Item Name</th>
            <th>Qty</th>
            <th>Discount (%)</th>
            <th>Total (Rs.)</th>
        </tr>
        <%
        if (orderItems != null && !orderItems.isEmpty()) {
            for (OrderItem item : orderItems) {
                Item itemDetails = new ItemDAO().getItemById(item.getItemID());
        %>
        <tr>
            <td><%= item.getItemID() %></td>
            <td><%= itemDetails != null ? itemDetails.getName() : "N/A" %></td>
            <td><%= item.getQuantity() %></td>
            <td><%= item.getDiscount() %></td>
            <td>Rs. <%= String.format("%.2f", item.getTotal()) %></td>
        </tr>
        <%
            }
        } else {
        %>
        <tr>
            <td colspan="5" style="text-align:center; color:#666;">No items found for this order.</td>
        </tr>
        <% } %>
        <tr class="total-row">
            <td colspan="4" style="text-align:right;">Order Total:</td>
            <td>Rs. <%= String.format("%.2f", order.getTotal()) %></td>
        </tr>
    </table>

   

    

    <div class="invoice-footer">
        Thank you for shopping with Pahana Edu!  
        <br>Powered by Pahana Edu Billing System © 2025
    </div>
    
    
</div>
<div class="actions">
        <button onclick="window.print()" class="btn">🖨 Print / Save as PDF</button>
        <a href="order-form.jsp" class="btn">➕ New Order</a>
        <a href="dashboard.jsp" class="btn">← Back</a>
    </div>
</body>
</html>
