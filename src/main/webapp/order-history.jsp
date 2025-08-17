<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="com.pahanaedu.model.Order" %>
<%@ page import="com.pahanaedu.model.User" %>
<%
User user = (User) session.getAttribute("loggedUser");
if (user == null) {
    response.sendRedirect("login.jsp");
    return;
}

List<Order> orders = (List<Order>) request.getAttribute("orders");
int totalOrders = orders != null ? orders.size() : 0;
double totalRevenue = 0.0;
int todaysOrders = 0;

// Formt & get today's date
DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
LocalDate today = LocalDate.now();

if (orders != null) {
    for (Order order : orders) {
        totalRevenue += order.getTotal();
        try {
            String dateStr = order.getOrderDate().toString().substring(0, 10);
            LocalDate orderDate = LocalDate.parse(dateStr, formatter);
            if (orderDate.equals(today)) {
                todaysOrders++;
            }
        } catch (Exception e) {
            // Ignore parse errors
        }
    }
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pahana Edu - Order History</title>
     <style>
        /* Reset */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, 'SF Pro Display', 'Segoe UI', Roboto, sans-serif;
            background-color: #F5F5F5;
            color: #333333;
            min-height: 100vh;
        }
        
        .navbar {
    display: flex;
    justify-content: space-between;
    align-items: center;
    background-color: #2C3E50; /* adjust as needed */
    padding: 10px 20px;
    color: #ffffff;
}

.logo {
    display: flex;
    align-items: center;
    font-size: 1.5em;
    font-weight: bold;
    color: #ffffff; /* white text for contrast */
}

.logo-img {
    height: 40px;
    width: 40px;
    object-fit: cover;
    margin-right: 10px;
    border-radius: 6px;
}

.navbar-nav a {
    color: #ffffff;
    text-decoration: none;
    margin-left: 15px;
    font-weight: 500;
}
        

        /* Navbar */
        .navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 16px 24px;
            background-color: #2C3E50;
            color: white;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .navbar .logo {
            font-size: 20px;
            font-weight: 700;
            color: white;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .navbar-nav {
            display: flex;
            align-items: center;
            gap: 16px;
        }

        .dashboard-btn {
            background: linear-gradient(135deg, #5F9EA0 0%, rgba(95, 158, 160, 0.8) 100%);
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 6px;
            text-decoration: none;
            font-size: 14px;
            font-weight: 500;
            transition: all 0.3s ease;
            cursor: pointer;
        }

        .dashboard-btn:hover {
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(95, 158, 160, 0.3);
        }

        .user-info {
            display: flex;
            align-items: center;
            gap: 12px;
            color: white;
            font-size: 14px;
        }

        .logout-btn {
            background: #E67E22;
            color: white;
            border: none;
            padding: 8px 14px;
            border-radius: 6px;
            cursor: pointer;
            font-size: 14px;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .logout-btn:hover {
            background: #cf6e1c;
            transform: translateY(-1px);
        }

        /* Main Container */
        .container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 24px;
        }

     

        .page-title {
            font-size:28px;
    font-weight:600;
    color:#2C3E50;
    margin-bottom:8px
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .page-subtitle {
            color: #5F9EA0;
            font-size: 16px;
            font-weight: 400;
            margin-bottom: 25px;
        }

        /* Stats Cards */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 24px;
        }

        .stat-card {
            background: white;
            border-radius: 12px;
            padding: 20px;
            text-align: center;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
            border-left: 6px solid #8BA88E;
            transition: all 0.3s ease;
        }

        .stat-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 16px rgba(0, 0, 0, 0.12);
        }

        .stat-card h2 {
            font-size: 32px;
            margin-bottom: 8px;
            color: #2C3E50;
            font-weight: 700;
        }

        .stat-card p {
            font-size: 14px;
            color: #5F9EA0;
            font-weight: 500;
        }

        .stat-card.success {
            border-left-color: #8BA88E;
        }

        .stat-card.success h2 {
            color: #8BA88E;
        }

        /* Controls Section */
        .controls {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 24px;
            gap: 16px;
            flex-wrap: wrap;
        }

        .search-filter-section {
            display: flex;
            gap: 12px;
            flex: 1;
            max-width: 600px;
        }

        .search-box {
            flex: 1;
            position: relative;
        }

        .search-input {
            width: 100%;
            padding: 12px 16px 12px 40px;
            border: 2px solid #e0e6ed;
            border-radius: 8px;
            background: white;
            color: #333333;
            font-size: 14px;
            transition: all 0.3s ease;
        }

        .search-input::placeholder {
            color: #999;
        }
        
        .btn-delete {
    background-color: #e74c3c; /* Red */
    color: white;
    padding: 6px 12px;
    border-radius: 6px;
    text-decoration: none;
    font-size: 14px;
    transition: background 0.2s ease-in-out;
}

.btn-delete:hover {
    background-color: #c0392b; /* Darker red */
}
        

        .search-input:focus {
            outline: none;
            border-color: #5F9EA0;
            box-shadow: 0 0 0 3px rgba(95, 158, 160, 0.1);
        }

        .search-icon {
            position: absolute;
            left: 12px;
            top: 50%;
            transform: translateY(-50%);
            color: #999;
            font-size: 16px;
        }

        .filter-select {
            padding: 12px 16px;
            border: 2px solid #e0e6ed;
            border-radius: 8px;
            background: white;
            color: #333333;
            font-size: 14px;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .filter-select:focus {
            outline: none;
            border-color: #5F9EA0;
            box-shadow: 0 0 0 3px rgba(95, 158, 160, 0.1);
        }

        .export-btn {
            background: linear-gradient(135deg, #8BA88E 0%, rgba(139, 168, 142, 0.8) 100%);
            color: white;
            border: none;
            padding: 12px 20px;
            border-radius: 8px;
            text-decoration: none;
            font-size: 14px;
            font-weight: 600;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 8px;
            white-space: nowrap;
            cursor: pointer;
        }

        .export-btn:hover {
            transform: translateY(-1px);
            box-shadow: 0 6px 20px rgba(139, 168, 142, 0.3);
        }

        /* Table Container */
        .table-container {
            background: white;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }

        .table {
            width: 100%;
            border-collapse: collapse;
        }

        .table th {
            background: #2C3E50;
            color: white;
            padding: 16px 12px;
            text-align: left;
            font-weight: 600;
            font-size: 14px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .table td {
            padding: 16px 12px;
            border-bottom: 1px solid #f0f0f0;
            color: #333333;
            font-size: 14px;
        }

        .table tbody tr {
            transition: all 0.3s ease;
            cursor: pointer;
        }

        .table tbody tr:hover {
            background: rgba(95, 158, 160, 0.1);
            transform: scale(1.002);
        }

        .table tbody tr:last-child td {
            border-bottom: none;
        }

        /* Order Status Badges */
        .status-badge {
            padding: 4px 8px;
            border-radius: 12px;
            font-size: 12px;
            font-weight: 600;
            text-transform: uppercase;
        }

        .status-badge.completed {
            background: rgba(139, 168, 142, 0.2);
            color: #8BA88E;
        }

        .status-badge.pending {
            background: rgba(230, 126, 34, 0.2);
            color: #E67E22;
        }

        .status-badge.cancelled {
            background: rgba(220, 53, 69, 0.2);
            color: #dc3545;
        }

        /* Price styling */
        .price-cell {
            font-weight: 600;
            color: #8BA88E;
            font-size: 15px;
        }

        /* Action Buttons */
        .action-buttons {
            display: flex;
            gap: 8px;
            align-items: center;
        }

        .btn-view {
            background: #5F9EA0;
            color: white;
            border: none;
            padding: 6px 12px;
            border-radius: 4px;
            text-decoration: none;
            font-size: 12px;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .btn-view:hover {
            background: #4a7c7e;
            transform: translateY(-1px);
        }

        .btn-print {
            background: #8BA88E;
            color: white;
            border: none;
            padding: 6px 12px;
            border-radius: 4px;
            text-decoration: none;
            font-size: 12px;
            font-weight: 500;
            transition: all 0.3s ease;
            cursor: pointer;
        }

        .btn-print:hover {
            background: #7a9b7d;
            transform: translateY(-1px);
        }

        /* Stats Bar */
        .stats-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 16px 24px;
            background: #f8f9fa;
            border-bottom: 1px solid #e0e6ed;
            font-size: 14px;
            color: #666;
        }

        .order-count {
            font-weight: 600;
            color: #5F9EA0;
        }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 48px 24px;
            color: #999;
        }

        .empty-state-icon {
            font-size: 48px;
            margin-bottom: 16px;
            opacity: 0.5;
        }

        /* Date Badge */
        .date-badge {
            background: rgba(95, 158, 160, 0.1);
            color: #5F9EA0;
            padding: 4px 8px;
            border-radius: 6px;
            font-size: 12px;
            font-weight: 500;
        }

        /* Order ID styling */
        .order-id {
            font-weight: 600;
            color: #2C3E50;
            font-family: 'Courier New', monospace;
        }

        /* Customer ID styling */
        .customer-id {
            color: #666;
            font-size: 13px;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .navbar {
                flex-direction: column;
                align-items: stretch;
                gap: 12px;
            }

            .navbar-nav {
                justify-content: space-between;
            }

            .controls {
                flex-direction: column;
                align-items: stretch;
            }

            .search-filter-section {
                max-width: none;
                flex-direction: column;
            }

            .stats-grid {
                grid-template-columns: 1fr;
            }

            .table-container {
                overflow-x: auto;
            }

            .table {
                min-width: 700px;
            }

            .page-title {
                font-size: 24px;
            }
        }

        /* Loading Animation */
        .loading {
            display: none;
            text-align: center;
            padding: 20px;
            color: #666;
        }

        .spinner {
            border: 2px solid #f3f3f3;
            border-top: 2px solid #5F9EA0;
            border-radius: 50%;
            width: 20px;
            height: 20px;
            animation: spin 1s linear infinite;
            display: inline-block;
            margin-right: 10px;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
    </style>
</head>
<body>
   <nav class="navbar">
    <div class="logo">
        <img src="images/PahanaEdu.jpg" alt="Pahana Edu Logo" class="logo-img">
        <span>Pahana Edu</span>
    </div>
    <div class="navbar-nav">
        <a href="dashboard.jsp" class="dashboard-btn">🏠 Dashboard</a>
    </div>
</nav>


    <!-- Main Container -->
    <div class="container">
        <!-- Page Header -->
        <div class="page-header">
            <h1 class="page-title">📋 Order History</h1>
            <p class="page-subtitle">Track and manage all customer orders, view details, and monitor sales</p>
        </div>

        <!-- Stats Cards -->
        <div class="stats-grid">
            <div class="stat-card">
                <h2><%= totalOrders %></h2>
                <p>Total Orders</p>
            </div>
           <%
double displayRevenue = totalRevenue;
String formattedRevenue;

if (displayRevenue >= 1_000_000_000) {
    formattedRevenue = String.format("%.1fB", displayRevenue / 1_000_000_000);
} else if (displayRevenue >= 1_000_000) {
    formattedRevenue = String.format("%.1fM", displayRevenue / 1_000_000);
} else if (displayRevenue >= 1_000) {
    formattedRevenue = String.format("%.1fK", displayRevenue / 1_000);
} else {
    formattedRevenue = String.format("%.2f", displayRevenue);
}
%>

<div class="stat-card success">
    <h2>Rs.<%= formattedRevenue %></h2>
    <p>Total Revenue</p>
</div>

            <div class="stat-card">
                <h2><%= todaysOrders %></h2>
                <p>Today's Orders</p>
            </div>
        </div>

        <!-- Controls -->
        <div class="controls">
            <div class="search-filter-section">
                <div class="search-box">
                    <span class="search-icon">🔍</span>
                    <input type="text" 
                           class="search-input" 
                           id="searchInput" 
                           placeholder="Search by Order ID, Customer ID, or date..."
                           onkeyup="filterOrders()">
                </div>
                <select class="filter-select" id="dateFilter" onchange="filterOrders()">
                    <option value="">All Dates</option>
                    <option value="today">Today</option>
                    <option value="week">This Week</option>
                    <option value="month">This Month</option>
                </select>
                <select class="filter-select" id="amountFilter" onchange="filterOrders()">
                    <option value="">All Amounts</option>
                    <option value="low">Under Rs.1000</option>
                    <option value="medium">Rs.1000-5000</option>
                    <option value="high">Over Rs.5000</option>
                </select>
            </div>
            
        </div>

        <!-- Table Container -->
        <div class="table-container">
            <div class="stats-bar">
                <span class="order-count">Total Orders: <%= totalOrders %></span>
                <span id="filteredCount">Showing: <%= totalOrders %></span>
            </div>
            
            <% if (orders != null && !orders.isEmpty()) { %>
                <table class="table" id="ordersTable">
                    <thead>
                        <tr>
                            <th>🆔 Order ID</th>
                            <th>👤 Customer ID</th>
                            <th>💰 Total Amount</th>
                            <th>📅 Order Date</th>
                            <th>📊 Status</th>
                            <th>⚙️ Actions</th>
                        </tr>
                    </thead>
<tbody id="orderTableBody">
    <% for (Order order : orders) { 
        String statusClass;
        String statusLabel;

        if (order.getTotal() == 0) {
            statusClass = "not-completed";
            statusLabel = "Not Completed";
        } else {
            statusClass = "completed";
            statusLabel = "Completed";
        }
    %>
        <tr class="order-row" 
            data-amount="<%= order.getTotal() %>" 
            data-date="<%= order.getOrderDate() %>">
            <td class="order-id">#<%= String.format("%06d", order.getOrderID()) %></td>
            <td class="customer-id">CUS-<%= String.format("%04d", order.getCustomerID()) %></td>
            <td class="price-cell">Rs.<%= String.format("%.2f", order.getTotal()) %></td>
            <td><span class="date-badge"><%= order.getOrderDate() %></span></td>
            <td>
                <span class="status-badge <%= statusClass %>"><%= statusLabel %></span>
            </td>
            <td>
                <div class="action-buttons">
                    <a href="OrderDetailsServlet?orderID=<%= order.getOrderID() %>" class="btn-view">👁️ View</a>
                      <a href="DeleteOrderServlet?orderID=<%= order.getOrderID() %>" 
           class="btn-delete" 
           onclick="return confirm('Are you sure you want to delete this order?');">
           🗑️ Delete
        </a>
                </div>
            </td>
        </tr>
    <% } %>
</tbody>

                </table>
            <% } else { %>
                <div class="empty-state">
                    <h3>No Orders Found</h3>
                    <p>No orders have been placed yet.</p>
                    <a href="dashboard.jsp" class="dashboard-btn">🏠 Back to Dashboard</a>
                </div>
            <% } %>
        </div>
    </div>

    <script>
        function filterOrders() {
            const searchTerm = document.getElementById('searchInput').value.toLowerCase();
            const dateFilter = document.getElementById('dateFilter').value;
            const amountFilter = document.getElementById('amountFilter').value;
            const rows = document.querySelectorAll('.order-row');
            let visibleCount = 0;

            const today = new Date();
            const startOfWeek = new Date(today);
            startOfWeek.setDate(today.getDate() - today.getDay());
            const startOfMonth = new Date(today.getFullYear(), today.getMonth(), 1);

            rows.forEach(row => {
                const orderID = row.querySelector('.order-id').textContent.toLowerCase();
                const customerID = row.querySelector('.customer-id').textContent.toLowerCase();
                const dateText = row.getAttribute('data-date').substring(0, 10);
                const amount = parseFloat(row.getAttribute('data-amount'));

                const matchesSearch = orderID.includes(searchTerm) || 
                                      customerID.includes(searchTerm) || 
                                      dateText.includes(searchTerm);

                let matchesDate = true;
                if (dateFilter) {
                    const orderDate = new Date(dateText);
                    if (dateFilter === "today") {
                        matchesDate = orderDate.toDateString() === today.toDateString();
                    } else if (dateFilter === "week") {
                        matchesDate = orderDate >= startOfWeek && orderDate <= today;
                    } else if (dateFilter === "month") {
                        matchesDate = orderDate >= startOfMonth && orderDate <= today;
                    }
                }

                let matchesAmount = true;
                if (amountFilter === 'low') {
                    matchesAmount = amount < 1000;
                } else if (amountFilter === 'medium') {
                    matchesAmount = amount >= 1000 && amount <= 5000;
                } else if (amountFilter === 'high') {
                    matchesAmount = amount > 5000;
                }

                if (matchesSearch && matchesDate && matchesAmount) {
                    row.style.display = '';
                    visibleCount++;
                } else {
                    row.style.display = 'none';
                }
            });

            document.getElementById('filteredCount').textContent = `Showing: ${visibleCount}`;
        }

        // Auto-sort by date (newest first)
        document.addEventListener("DOMContentLoaded", function() {
            const table = document.getElementById("ordersTable");
            if (!table) return;
            const rows = Array.from(table.querySelectorAll("tbody tr"));

            rows.sort((a, b) => {
                const dateA = new Date(a.getAttribute("data-date"));
                const dateB = new Date(b.getAttribute("data-date"));
                return dateB - dateA;
            });

            rows.forEach(row => table.querySelector("tbody").appendChild(row));
        });
    </script>
</body>
</html>
