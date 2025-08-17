<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.pahanaedu.model.User,com.pahanaedu.dao.OrderDAO, com.pahanaedu.dao.CustomerDAO, com.pahanaedu.dao.ItemDAO" %>
<%
User user = (User) session.getAttribute("loggedUser");
if (user == null) {
    response.sendRedirect("login.jsp");
    return;
}
int ordersToday = OrderDAO.getOrdersTodayCount();
int totalCustomers = CustomerDAO.getTotalCustomersCount();
int itemsInStock = ItemDAO.getTotalItemsInStock();
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Pahana Edu - Dashboard</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<style>
/* Reset */
* {margin:0; padding:0; box-sizing:border-box;}
body {
    font-family: 'Segoe UI', Tahoma, sans-serif;
    background-color: #F5F5F5; /* Soft off-white */
    color: #333; /* Dark gray */
    min-height: 100vh;
}

/* Navbar. */
.navbar {
    display:flex;
    justify-content:space-between;
    align-items:center;
    padding:15px 30px;
    background-color:#2C3E50; /* Deep navy */
    color:white;
    position:sticky;
    top:0;
    z-index:10;
}

.logo {
    display: flex;
    align-items: center;
    font-size: 1.5em;
    font-weight: bold;
    color: #FFFFFF;
}

.logo-img {
    height: 40px;
    width: 40px;
    object-fit: contain;
    margin-right: 10px;
    border-radius: 8px;
}

.navbar .logo {
    font-size:20px;
    font-weight:bold;
}
.user-info {
    display:flex;
    align-items:center;
    gap:12px;
}
.logout-btn {
    background-color:#E67E22; /* Soft orange */
    color:white;
    border:none;
    padding:8px 14px;
    border-radius:6px;
    cursor:pointer;
    font-size:14px;
}
.logout-btn:hover {
    background-color:#cf6e1c;
}

/* Main Container */
.main {
    padding:20px;
    max-width:1200px;
    margin:auto;
}

/* Welcome */
.welcome {
    margin-bottom:20px;
}
.welcome h1 {
    font-size:26px;
    font-weight:600;
    color:#2C3E50;
}
.welcome p {
    font-size:14px;
    color:#5F9EA0; /* Muted teal */
}

/* Stats Cards */
.stats {
    display:grid;
    grid-template-columns:repeat(auto-fit, minmax(200px, 1fr));
    gap:20px;
    margin-bottom:30px;
}
.stat-card {
    background:white;
    border-radius:12px;
    padding:20px;
    text-align:center;
    box-shadow:0 2px 8px rgba(0,0,0,0.08);
    border-left:6px solid #8BA88E; /* Sage green */
}
.stat-card h2 {
    font-size:28px;
    margin-bottom:5px;
    color:#2C3E50;
}
.stat-card p {
    font-size:14px;
    color:#5F9EA0;
}

/* Menu */
.menu {
    display:grid;
    grid-template-columns:repeat(auto-fit, minmax(220px, 1fr));
    gap:20px;
}
.menu a {
    text-decoration:none;
    color:inherit;
}
.menu-card {
    background:white;
    border-radius:12px;
    padding:20px;
    text-align:center;
    transition:0.3s;
    box-shadow:0 2px 8px rgba(0,0,0,0.05);
}
.menu-card:hover {
    transform:translateY(-3px);
    border-left:5px solid #E67E22; /* Orange highlight */
    box-shadow:0 4px 12px rgba(0,0,0,0.12);
}
.menu-card span {
    font-size:30px;
    display:block;
    margin-bottom:8px;
}
.menu-card h3 {
    font-size:16px;
    margin-bottom:5px;
    color:#2C3E50;
}
.menu-card p {
    font-size:13px;
    color:#555;
}

/* Footer */
.footer {
    text-align:center;
    padding:15px;
    font-size:12px;
    color:#777;
    margin-top:30px;
}

/* Mobile */
@media (max-width:600px) {
    .navbar {
        flex-direction:column;
        align-items:flex-start;
        gap:8px;
    }
    .user-info {
        width:100%;
        justify-content:space-between;
    }
}
</style>
</head>
<body>

<!-- Navbar -->
<div class="navbar">
    <div class="logo">
        <img src="images/PahanaEdu.jpg" alt="Pahana Edu Logo" class="logo-img">
        Pahana Edu
    </div>
    <div class="user-info">
        <span><%= user.getUsername() %> (<%= user.getRole() %>)</span>
        <form action="logout.jsp" method="post" style="margin:0;">
            <button class="logout-btn">Logout</button>
        </form>
    </div>
</div>


<!-- Main -->
<div class="main">
    <!-- Welcome -->
    <div class="welcome">
        <h1>Welcome, <%= user.getUsername() %> 👋</h1>
        <p>Manage your billing system efficiently with quick access tools below.</p>
    </div>

    <!-- Stats -->
    <div class="stats">
        <div class="stat-card">
            <h2><%= ordersToday %></h2>
            <p>Orders Today</p>
        </div>
        <div class="stat-card">
            <h2><%= totalCustomers %></h2>
            <p>Customers</p>
        </div>
        <div class="stat-card">
            <h2><%= itemsInStock %></h2>
            <p>Items in Stock</p>
        </div>
    </div>

    <!-- Menu -->
    <div class="menu">
        <a href="order-form.jsp">
            <div class="menu-card">
                <span>📦</span>
                <h3>Order Processing</h3>
                <p>Create and manage customer orders.</p>
            </div>
        </a>
        <a href="view-customers.jsp">
            <div class="menu-card">
                <span>👥</span>
                <h3>Manage Customers</h3>
                <p>Edit and view customer information.</p>
            </div>
        </a>
        <a href="view-items.jsp">
            <div class="menu-card">
                <span>📚</span>
                <h3>Manage Items</h3>
                <p>Edit and manage inventory items.</p>
            </div>
        </a>
        <a href="OrderHistoryServlet">
            <div class="menu-card">
                <span>📜</span>
                <h3>Order History</h3>
                <p>Review past transactions.</p>
            </div>
        </a>
        <a href="add-customer.jsp">
            <div class="menu-card">
                <span>➕</span>
                <h3>Add Customer</h3>
                <p>Register a new customer.</p>
            </div>
        </a>
        <a href="add-item.jsp">
            <div class="menu-card">
                <span>➕</span>
                <h3>Add Item</h3>
                <p>Add new products to your inventory.</p>
            </div>
        </a>
        
         <a href="help.jsp">
                <div class="menu-card">
                    <span>❓</span>
                    <h3>Help</h3>
                    <p>Get support and documentation.</p>
                </div>
            </a>
        <% if ("admin".equals(user.getRole())) { %>
            <a href="view-staff.jsp">
                <div class="menu-card">
                    <span>🧑‍💼</span>
                    <h3>Manage Staff</h3>
                    <p>Administer staff accounts.</p>
                </div>
            </a>
           
        <% } %>
    </div>

    <!-- Footer -->
    <div class="footer">
        &copy; <%= java.time.Year.now() %> Vihanga Wimalaweera. All rights reserved.
    </div>
</div>

</body>
</html>
