<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="com.pahanaedu.model.Order" %>
<%@ page import="com.pahanaedu.model.OrderItem" %>
<%@ page import="com.pahanaedu.model.User" %>
<%
User user = (User) session.getAttribute("loggedUser");
if (user == null) {
    response.sendRedirect("login.jsp");
    return;
}

Order order = (Order) request.getAttribute("order");
List<OrderItem> items = (List<OrderItem>) request.getAttribute("orderItems");

// Calculate order statistics
int totalItems = 0;
double totalDiscount = 0.0;
double subtotal = 0.0;

if (items != null) {
    for (OrderItem item : items) {
        totalItems += item.getQuantity();
        totalDiscount += (item.getTotal() * item.getDiscount() / 100);
        subtotal += item.getTotal();
    }
}

// Determine order status
String statusClass;
String statusLabel;
if (order != null) {
    if (order.getTotal() == 0) {
        statusClass = "pending";
        statusLabel = "Pending";
    } else {
        statusClass = "completed";
        statusLabel = "Completed";
    }
} else {
    statusClass = "error";
    statusLabel = "Error";
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pahana Edu - Order Details</title>
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

        .nav-btn {
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

        .nav-btn:hover {
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(95, 158, 160, 0.3);
        }

        .nav-btn.secondary {
            background: linear-gradient(135deg, #8BA88E 0%, rgba(139, 168, 142, 0.8) 100%);
        }

        .nav-btn.secondary:hover {
            box-shadow: 0 4px 12px rgba(139, 168, 142, 0.3);
        }

        /* Main Container */
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 24px;
        }

        /* Page Header */
        .page-header {
            margin-bottom: 32px;
        }

        .page-title {
            font-size: 28px;
            font-weight: 600;
            color: #2C3E50;
            margin-bottom: 8px;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .page-subtitle {
            color: #5F9EA0;
            font-size: 16px;
            font-weight: 400;
        }

        /* Breadcrumb */
        .breadcrumb {
            display: flex;
            align-items: center;
            gap: 8px;
            margin-bottom: 24px;
            font-size: 14px;
            color: #666;
        }

        .breadcrumb a {
            color: #5F9EA0;
            text-decoration: none;
        }

        .breadcrumb a:hover {
            text-decoration: underline;
        }

        /* Order Header Card */
        .order-header {
            background: white;
            border-radius: 12px;
            padding: 24px;
            margin-bottom: 24px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
            border-left: 6px solid #5F9EA0;
        }

        .order-header-content {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 24px;
        }

        .order-info-group h3 {
            font-size: 14px;
            font-weight: 600;
            color: #666;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 8px;
        }

        .order-info-value {
            font-size: 18px;
            font-weight: 600;
            color: #2C3E50;
        }

        .order-id {
            font-family: 'Courier New', monospace;
            background: rgba(95, 158, 160, 0.1);
            padding: 4px 8px;
            border-radius: 6px;
            display: inline-block;
        }

        .customer-name {
            color: #5F9EA0;
        }

        .order-total {
            color: #8BA88E;
            font-size: 22px;
        }

        .order-date {
            background: rgba(95, 158, 160, 0.1);
            color: #5F9EA0;
            padding: 4px 8px;
            border-radius: 6px;
            display: inline-block;
            font-size: 16px;
        }

        /* Status Badge */
        .status-badge {
            padding: 6px 12px;
            border-radius: 12px;
            font-size: 14px;
            font-weight: 600;
            text-transform: uppercase;
            display: inline-block;
        }

        .status-badge.completed {
            background: rgba(139, 168, 142, 0.2);
            color: #8BA88E;
        }

        .status-badge.pending {
            background: rgba(230, 126, 34, 0.2);
            color: #E67E22;
        }

        .status-badge.error {
            background: rgba(220, 53, 69, 0.2);
            color: #dc3545;
        }

        /* Stats Cards */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 16px;
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

        .stat-card h3 {
            font-size: 24px;
            margin-bottom: 8px;
            color: #2C3E50;
            font-weight: 700;
        }

        .stat-card p {
            font-size: 14px;
            color: #5F9EA0;
            font-weight: 500;
        }

        /* Items Table */
        .items-section {
            background: white;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            margin-bottom: 24px;
        }

        .section-header {
            background: #2C3E50;
            color: white;
            padding: 20px 24px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .section-title {
            font-size: 18px;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .item-count {
            background: rgba(255, 255, 255, 0.2);
            padding: 4px 8px;
            border-radius: 12px;
            font-size: 12px;
        }

        .table {
            width: 100%;
            border-collapse: collapse;
        }

        .table th {
            background: #f8f9fa;
            color: #2C3E50;
            padding: 16px 20px;
            text-align: left;
            font-weight: 600;
            font-size: 14px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            border-bottom: 2px solid #e0e6ed;
        }

        .table td {
            padding: 16px 20px;
            border-bottom: 1px solid #f0f0f0;
            color: #333333;
            font-size: 14px;
        }

        .table tbody tr {
            transition: all 0.3s ease;
        }

        .table tbody tr:hover {
            background: rgba(95, 158, 160, 0.05);
        }

        .table tbody tr:last-child td {
            border-bottom: none;
        }

        /* Item styling */
        .item-name {
            font-weight: 600;
            color: #2C3E50;
        }

        .quantity-badge {
            background: rgba(95, 158, 160, 0.1);
            color: #5F9EA0;
            padding: 4px 8px;
            border-radius: 12px;
            font-weight: 600;
            display: inline-block;
        }

        .discount-badge {
            background: rgba(230, 126, 34, 0.1);
            color: #E67E22;
            padding: 4px 8px;
            border-radius: 12px;
            font-weight: 600;
            display: inline-block;
        }

        .item-total {
            font-weight: 600;
            color: #8BA88E;
            font-size: 15px;
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

        /* Action Buttons */
        .action-section {
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 16px;
            margin-top: 24px;
        }

        .btn {
            padding: 12px 20px;
            border-radius: 8px;
            text-decoration: none;
            font-size: 14px;
            font-weight: 600;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 8px;
            cursor: pointer;
            border: none;
        }

        .btn-primary {
            background: linear-gradient(135deg, #5F9EA0 0%, rgba(95, 158, 160, 0.8) 100%);
            color: white;
        }

        .btn-primary:hover {
            transform: translateY(-1px);
            box-shadow: 0 6px 20px rgba(95, 158, 160, 0.3);
        }

        .btn-secondary {
            background: linear-gradient(135deg, #8BA88E 0%, rgba(139, 168, 142, 0.8) 100%);
            color: white;
        }

        .btn-secondary:hover {
            transform: translateY(-1px);
            box-shadow: 0 6px 20px rgba(139, 168, 142, 0.3);
        }

        .btn-outline {
            background: white;
            color: #2C3E50;
            border: 2px solid #e0e6ed;
        }

        .btn-outline:hover {
            border-color: #5F9EA0;
            background: rgba(95, 158, 160, 0.05);
        }

        /* Error State */
        .error-message {
            background: #f8d7da;
            color: #721c24;
            padding: 16px 20px;
            border-radius: 8px;
            border-left: 4px solid #dc3545;
            margin-bottom: 24px;
        }

        /* Print Styles */
        @media print {
            .navbar, .action-section, .breadcrumb {
                display: none;
            }
            
            body {
                background: white;
            }
            
            .container {
                max-width: none;
                padding: 0;
            }
            
            .order-header, .items-section {
                box-shadow: none;
                border: 1px solid #ddd;
            }
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

            .order-header-content {
                grid-template-columns: 1fr;
                gap: 16px;
            }

            .stats-grid {
                grid-template-columns: 1fr;
            }

            .table-container {
                overflow-x: auto;
            }

            .table {
                min-width: 600px;
            }

            .action-section {
                flex-direction: column;
                align-items: stretch;
            }

            .page-title {
                font-size: 24px;
            }
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar">
        <div class="logo">📚 Pahana Edu</div>
        <div class="navbar-nav">
            <a href="dashboard.jsp" class="nav-btn">🏠 Dashboard</a>
           
        </div>
    </nav>

    <!-- Main Container -->
    <div class="container">
        <!-- Breadcrumb -->
        

        <!-- Page Header -->
        <div class="page-header">
            <h1 class="page-title">📄 Order Details</h1>
            <p class="page-subtitle">Complete information about this order and its items</p>
        </div>

        <% if (order != null) { %>
            <!-- Order Header Card -->
            <div class="order-header">
                <div class="order-header-content">
                    <div class="order-info-group">
                        <h3>🆔 Order ID</h3>
                        <div class="order-info-value">
                            <span class="order-id">#<%= String.format("%06d", order.getOrderID()) %></span>
                        </div>
                    </div>
                    
                    <div class="order-info-group">
                        <h3>👤 Customer</h3>
                        <div class="order-info-value customer-name">
                            <%= order.getCustomerName() %>
                        </div>
                        <div style="font-size: 14px; color: #666; margin-top: 4px;">
                            ID: CUS-<%= String.format("%04d", order.getCustomerID()) %>
                        </div>
                    </div>
                    
                    <div class="order-info-group">
                        <h3>💰 Order Total</h3>
                        <div class="order-info-value order-total">
                            Rs.<%= String.format("%.2f", order.getTotal()) %>
                        </div>
                    </div>
                    
                    <div class="order-info-group">
                        <h3>📅 Order Date</h3>
                        <div class="order-info-value">
                            <span class="order-date"><%= order.getOrderDate() %></span>
                        </div>
                    </div>
                    
                    <div class="order-info-group">
                        <h3>📊 Status</h3>
                        <div class="order-info-value">
                            <span class="status-badge <%= statusClass %>"><%= statusLabel %></span>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Stats Cards -->
            <div class="stats-grid">
                <div class="stat-card">
                    <h3><%= totalItems %></h3>
                    <p>Total Items</p>
                </div>
                <div class="stat-card">
                    <h3><%= items != null ? items.size() : 0 %></h3>
                    <p>Products</p>
                </div>
                <div class="stat-card">
                    <h3>Rs.<%= String.format("%.2f", totalDiscount) %></h3>
                    <p>Total Discount</p>
                </div>
                <div class="stat-card">
                    <h3>Rs.<%= String.format("%.2f", subtotal) %></h3>
                    <p>Subtotal</p>
                </div>
            </div>

            <!-- Items Table -->
            <div class="items-section">
                <div class="section-header">
                    <h2 class="section-title">
                        🛍️ Order Items
                    </h2>
                    <span class="item-count"><%= items != null ? items.size() : 0 %> items</span>
                </div>
                
                <% if (items != null && !items.isEmpty()) { %>
                    <table class="table">
                        <thead>
                            <tr>
                                <th>📦 Item Name</th>
                                <th>🔢 Quantity</th>
                                <th>🏷️ Discount</th>
                                <th>💰 Item Total</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (OrderItem item : items) { %>
                                <tr>
                                    <td class="item-name"><%= item.getItemName() %></td>
                                    <td>
                                        <span class="quantity-badge">×<%= item.getQuantity() %></span>
                                    </td>
                                    <td>
                                        <% if (item.getDiscount() > 0) { %>
                                            <span class="discount-badge"><%= item.getDiscount() %>% OFF</span>
                                        <% } else { %>
                                            <span style="color: #999;">No discount</span>
                                        <% } %>
                                    </td>
                                    <td class="item-total">Rs.<%= String.format("%.2f", item.getTotal()) %></td>
                                </tr>
                            <% } %>
                        </tbody>
                    </table>
                <% } else { %>
                    <div class="empty-state">
                        <div class="empty-state-icon">📦</div>
                        <h3>No Items Found</h3>
                        <p>This order doesn't contain any items.</p>
                    </div>
                <% } %>
            </div>

        <% } else { %>
            <!-- Error State -->
            <div class="error-message">
                <h3>❌ Order Not Found</h3>
                <p>The requested order could not be found or there was an error loading the order details.</p>
            </div>
        <% } %>

        <!-- Action Buttons -->
        <div class="action-section">
            <div style="display: flex; gap: 12px; flex-wrap: wrap;">
                <a href="OrderHistoryServlet" class="btn btn-primary">
                    ← Back to Order History
                </a>
                
            </div>
            
            <div style="display: flex; gap: 12px; flex-wrap: wrap;">
                <% if (order != null) { %>
                   <button onclick="window.print()" class="btn btn-secondary">
                    🖨️ Print Order
                </button>
                <% } %>
            </div>
        </div>
    </div>

    <script>
        function downloadOrderPDF() {
            // This would typically call a servlet to generate PDF
            alert('PDF download feature would be implemented here');
        }

        function sendOrderEmail() {
            // This would typically call a servlet to send email
            alert('Email feature would be implemented here');
        }

        // Auto-focus print dialog if print parameter is present
        if (new URLSearchParams(window.location.search).get('print') === 'true') {
            window.onload = function() {
                window.print();
            };
        }
    </script>
</body>
</html>