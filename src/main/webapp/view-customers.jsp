<% if (request.getParameter("success") != null) { %>
    <div style="background:#d4edda; color:#155724; padding:10px; border-radius:4px; margin-bottom:15px;">
        ✅ Customer added successfully!
    </div>
<% } %>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.pahanaedu.dao.CustomerDAO, com.pahanaedu.model.Customer, com.pahanaedu.model.User" %>
<%

User user = (User) session.getAttribute("loggedUser");
if (user == null) {
    response.sendRedirect("login.jsp");
    return;
}

List<Customer> customers = CustomerDAO.getAllCustomers();
int totalCustomers = customers.size();
int adultCustomers = 0;
int youthCustomers = 0;

// Calculate customer analytics
for (Customer customer : customers) {
    if (customer.getAge() >= 18) {
        adultCustomers++;
    } else {
        youthCustomers++;
    }
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pahana Edu - View Customers</title>
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
            color: #ffffff; /* white text for contrast  */
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

        /* Page Header */
        .page-title {
            font-size:28px;
            font-weight:600;
            color:#2C3E50;
            margin-bottom:8px;
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

        .stat-card.adult {
            border-left-color: #5F9EA0;
        }

        .stat-card.adult h2 {
            color: #5F9EA0;
        }

        .stat-card.youth {
            border-left-color: #E67E22;
        }

        .stat-card.youth h2 {
            color: #E67E22;
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

        .add-customer-btn {
            background: linear-gradient(135deg, #E67E22 0%, rgba(230, 126, 34, 0.8) 100%);
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
        }

        .add-customer-btn:hover {
            transform: translateY(-1px);
            box-shadow: 0 6px 20px rgba(230, 126, 34, 0.3);
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
            transform: scale(1.005);
        }

        .table tbody tr:last-child td {
            border-bottom: none;
        }

        /* Customer Status Badges */
        .age-badge {
            padding: 4px 8px;
            border-radius: 12px;
            font-size: 12px;
            font-weight: 600;
            text-transform: uppercase;
        }

        .age-badge.adult {
            background: rgba(95, 158, 160, 0.2);
            color: #5F9EA0;
        }

        .age-badge.youth {
            background: rgba(230, 126, 34, 0.2);
            color: #E67E22;
        }

        /* Contact styling */
        .contact-cell {
            font-weight: 500;
            color: #8BA88E;
        }

        .email-cell {
            color: #5F9EA0;
            font-size: 13px;
        }

        /* Action Buttons */
        .action-buttons {
            display: flex;
            gap: 8px;
            align-items: center;
        }

        .btn-edit {
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

        .btn-edit:hover {
            background: #4a7c7e;
            transform: translateY(-1px);
        }

        .btn-delete {
            background: #dc3545;
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

        .btn-delete:hover {
            background: #c82333;
            transform: translateY(-1px);
        }

        .btn-contact {
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

        .btn-contact:hover {
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

        .customer-count {
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

        /* Customer Name styling */
        .customer-name {
            font-weight: 600;
            color: #2C3E50;
        }

        /* Address truncation for long addresses */
        .customer-address {
            max-width: 200px;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
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
                min-width: 800px;
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

        /* Tooltip for truncated addresses */
        .customer-address:hover {
            position: relative;
        }

        .customer-address[title]:hover::after {
            content: attr(title);
            position: absolute;
            bottom: 100%;
            left: 0;
            background: #2C3E50;
            color: white;
            padding: 8px 12px;
            border-radius: 4px;
            font-size: 12px;
            white-space: normal;
            max-width: 300px;
            z-index: 1000;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.2);
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
            <h1 class="page-title">
                👥 Customer Management
            </h1>
            <p class="page-subtitle">Manage customer information, track demographics, and maintain customer relationships</p>
        </div>

        <!-- Stats Cards -->
        <div class="stats-grid">
            <div class="stat-card">
                <h2><%= totalCustomers %></h2>
                <p>Total Customers</p>
            </div>
            <div class="stat-card adult">
                <h2><%= adultCustomers %></h2>
                <p>Adult Customers (>18)</p>
            </div>
            <div class="stat-card youth">
                <h2><%= youthCustomers %></h2>
                <p>Youth Customers (<18)</p>
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
                           placeholder="Search customers by name, email, phone, or address..."
                           onkeyup="filterCustomers()">
                </div>
                <select class="filter-select" id="ageFilter" onchange="filterCustomers()">
                    <option value="">All Ages</option>
                    <option value="adult">Adults (>18)</option>
                    <option value="youth">Youth (<18)</option>
                </select>
                <select class="filter-select" id="locationFilter" onchange="filterCustomers()">
                    <option value="">All Locations</option>
                    <!-- This will be populated dynamically -->
                </select>
            </div>
            <a href="add-customer.jsp" class="add-customer-btn">
                ➕ Add New Customer
            </a>
        </div>

        <!-- Table Container -->
        <div class="table-container">
            <div class="stats-bar">
                <span class="customer-count">Total Customers: <%= totalCustomers %></span>
                <span id="filteredCount">Showing: <%= totalCustomers %></span>
            </div>
            
            <% if (customers.size() > 0) { %>
                <table class="table" id="customersTable">
                    <thead>
                        <tr>
                            <th>👤 Name</th>
                            <th>📍 Address</th>
                            <th>🎂 Age</th>
                            <th>📞 Contact</th>
                            <th>📧 Email</th>
                            <th>⚙️ Actions</th>
                        </tr>
                    </thead>
                    <tbody id="customerTableBody">
                        <% for (Customer customer : customers) { 
                            String ageCategory = customer.getAge() >= 18 ? "adult" : "youth";
                            String ageBadgeText = customer.getAge() >= 18 ? "Adult" : "youth";
                        %>
                            <tr class="customer-row" data-age-category="<%= ageCategory %>" data-location="<%= customer.getAddress().toLowerCase() %>">
                                <td class="customer-name"><%= customer.getName() %></td>
                                <td class="customer-address" title="<%= customer.getAddress() %>"><%= customer.getAddress() %></td>
                                <td>
                                    <span class="age-badge <%= ageCategory %>">
                                        <%= customer.getAge() %> (<%= ageBadgeText %>)
                                    </span>
                                </td>
                                <td class="contact-cell customer-phone"><%= customer.getTelephone() %></td>
                                <td class="email-cell customer-email"><%= customer.getEmail() %></td>
                                <td>
                                    <div class="action-buttons">
                                        <a href="edit-customer.jsp?id=<%= customer.getCustomerID() %>" 
                                           class="btn-edit">✏️ Edit</a>
                                        <button onclick="advancedContactCustomer('<%= customer.getEmail() %>', '<%= customer.getTelephone() %>', '<%= customer.getName().replace("'", "\\'") %>')" 
                                                class="btn-contact">📞 Contact</button>
                                        <button onclick="confirmDelete(<%= customer.getCustomerID() %>, '<%= customer.getName() %>')" 
                                                class="btn-delete">🗑️ Delete</button>
                                    </div>
                                </td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            <% } else { %>
                <div class="empty-state">
                    <div class="empty-state-icon">👥</div>
                    <h3>No Customers Found</h3>
                    <p>Start building your customer base by adding your first customer to the system.</p>
                    <br>
                    <a href="add-customer.jsp" class="add-customer-btn">
                        ➕ Add First Customer
                    </a>
                </div>
            <% } %>
        </div>

        <div class="loading" id="loadingIndicator">
            <div class="spinner"></div>
            Processing...
        </div>
    </div>

    <script>
        // Enhanced contact function with Gmail and calling app redirects
        function advancedContactCustomer(email, phone, customerName) {
            if (!email && !phone) {
                alert("No contact information available.");
                return;
            }

            // Create modal container with better styling
            const modal = document.createElement("div");
            modal.style.cssText = `
                position:fixed; top:0; left:0; width:100%; height:100%;
                background:rgba(0,0,0,0.5); display:flex; align-items:center; justify-content:center;
                z-index:1000; backdrop-filter: blur(2px);
            `;

            // Modal content with customer name
            modal.innerHTML = `
                <div style="background:#fff; padding:25px; border-radius:12px; text-align:center; min-width:300px; box-shadow:0 10px 30px rgba(0,0,0,0.2);">
                    <h3 style="margin-bottom:10px; color:#2C3E50;">Contact ${customerName}</h3>
                    <p style="margin-bottom:20px; color:#666; font-size:14px;">Choose your preferred contact method:</p>
                    
                    ${email ? `
                        <button id="gmailBtn" style="
                            margin:5px; padding:12px 20px; background:#4285f4; color:white; 
                            border:none; border-radius:6px; cursor:pointer; font-weight:500;
                            display:flex; align-items:center; justify-content:center; gap:8px;
                            width:100%; transition:background 0.3s;
                        " onmouseover="this.style.background='#3367d6'" onmouseout="this.style.background='#4285f4'">
                            <span>📧</span> Email via Gmail
                        </button>
                        <button id="mailtoBtn" style="
                            margin:5px; padding:8px 16px; background:transparent; color:#4285f4; 
                            border:1px solid #4285f4; border-radius:6px; cursor:pointer; font-size:12px;
                            width:100%;
                        ">
                            📨 Use default email client
                        </button>
                    ` : ""}
                    
                    ${phone ? `
                        <button id="phoneBtn" style="
                            margin:10px 5px 5px 5px; padding:12px 20px; background:#25D366; color:white; 
                            border:none; border-radius:6px; cursor:pointer; font-weight:500;
                            display:flex; align-items:center; justify-content:center; gap:8px;
                            width:100%; transition:background 0.3s;
                        " onmouseover="this.style.background='#1eb856'" onmouseout="this.style.background='#25D366'">
                            <span>📞</span> Call ${phone}
                        </button>
                    ` : ""}
                    
                    <button id="cancelBtn" style="
                        margin:15px 5px 5px 5px; padding:10px 15px; background:#f8f9fa; 
                        border:1px solid #ddd; border-radius:6px; cursor:pointer; color:#666;
                        width:100%;
                    ">
                        ❌ Cancel
                    </button>
                </div>
            `;

            document.body.appendChild(modal);

            // Gmail button
            if (email && modal.querySelector("#gmailBtn")) {
                modal.querySelector("#gmailBtn").onclick = () => {
                    const subject = `Customer Inquiry - ${customerName}`;
                    const body = `Dear ${customerName},

Thank you for choosing Pahana Edu. We hope you are satisfied with our services.

If you have any questions or concerns, please don't hesitate to reach out.

Best regards,
Pahana Edu Team`;
                    
                    const gmailUrl = `https://mail.google.com/mail/?view=cm&fs=1&to=${encodeURIComponent(email)}&su=${encodeURIComponent(subject)}&body=${encodeURIComponent(body)}`;
                    window.open(gmailUrl, '_blank');
                    modal.remove();
                };
            }

            // Mailto button (fallback)
            if (email && modal.querySelector("#mailtoBtn")) {
                modal.querySelector("#mailtoBtn").onclick = () => {
                    const subject = `Customer Inquiry - ${customerName}`;
                    const body = `Dear ${customerName},%0D%0A%0D%0AThank you for choosing Pahana Edu.%0D%0A%0D%0ABest regards,%0D%0APahana Edu Team`;
                    window.location.href = `mailto:${email}?subject=${encodeURIComponent(subject)}&body=${body}`;
                    modal.remove();
                };
            }

            // Phone button
            if (phone && modal.querySelector("#phoneBtn")) {
                modal.querySelector("#phoneBtn").onclick = () => {
                    const cleanPhone = phone.replace(/[^\d+]/g, '');
                    window.location.href = `tel:${cleanPhone}`;
                    modal.remove();
                };
            }

            // Cancel button
            modal.querySelector("#cancelBtn").onclick = () => modal.remove();

            // Close modal when clicking outside
            modal.onclick = (e) => {
                if (e.target === modal) {
                    modal.remove();
                }
            };
        }

        // Filter functionality
        function filterCustomers() {
            const searchTerm = document.getElementById('searchInput').value.toLowerCase();
            const ageFilter = document.getElementById('ageFilter').value;
            const locationFilter = document.getElementById('locationFilter').value.toLowerCase();
            const rows = document.querySelectorAll('.customer-row');
            let visibleCount = 0;

            rows.forEach(row => {
                const name = row.querySelector('.customer-name').textContent.toLowerCase();
                const email = row.querySelector('.customer-email').textContent.toLowerCase();
                const phone = row.querySelector('.customer-phone').textContent.toLowerCase();
                const address = row.querySelector('.customer-address').textContent.toLowerCase();
                const ageCategory = row.getAttribute('data-age-category');
                const location = row.getAttribute('data-location');

                const matchesSearch = name.includes(searchTerm) || 
                                    email.includes(searchTerm) || 
                                    phone.includes(searchTerm) || 
                                    address.includes(searchTerm);
                
                const matchesAge = !ageFilter || ageCategory === ageFilter;
                const matchesLocation = !locationFilter || location.includes(locationFilter);

                if (matchesSearch && matchesAge && matchesLocation) {
                    row.style.display = '';
                    visibleCount++;
                } else {
                    row.style.display = 'none';
                }
            });

            document.getElementById('filteredCount').textContent = `Showing: ${visibleCount}`;
        }

        // Delete confirmation
        function confirmDelete(customerId, customerName) {
            // Create modal overlay
            const modal = document.createElement("div");
            modal.style.cssText = `
                position:fixed; top:0; left:0; width:100%; height:100%;
                background:rgba(0,0,0,0.4); display:flex; align-items:center; justify-content:center;
                z-index:1000;
            `;

            // Modal content
            modal.innerHTML = `
                <div style="background:#fff; padding:20px; border-radius:8px; text-align:center; max-width:350px; box-shadow:0 2px 8px rgba(0,0,0,0.2);">
                    <h3 style="color:#d9534f; margin-bottom:15px;">⚠️ Confirm Delete</h3>
                    <p style="margin-bottom:20px; font-size:14px; line-height:1.5;">
                        Are you sure you want to delete customer <b>"${customerName}"</b>?
                        <br><br>
                        This action <b>cannot be undone</b> and will remove all associated order history.
                    </p>
                    <div style="display:flex; justify-content:center; gap:10px; flex-wrap:wrap;">
                        <button id="deleteBtn" style="padding:10px 15px; background:#d9534f; color:white; border:none; border-radius:5px; cursor:pointer;">
                            🗑️ Delete
                        </button>
                        <button id="cancelBtn" style="padding:10px 15px; background:#ccc; border:none; border-radius:5px; cursor:pointer;">
                            ❌ Cancel
                        </button>
                    </div>
                </div>
            `;

            document.body.appendChild(modal);

            // Event listeners
            modal.querySelector("#deleteBtn").onclick = () => {
                modal.remove();
                showLoading(true);
                window.location.href = `delete-customer?id=${customerId}`;
            };

            modal.querySelector("#cancelBtn").onclick = () => {
                modal.remove();
            };
        }

        // Loading indicator
        function showLoading(show) {
            const loading = document.getElementById('loadingIndicator');
            const table = document.querySelector('.table-container');
            
            if (show) {
                loading.style.display = 'block';
                table.style.opacity = '0.5';
            } else {
                loading.style.display = 'none';
                table.style.opacity = '1';
            }
        }

        // Enhanced search with debouncing
        let searchTimeout;
        document.getElementById('searchInput').addEventListener('input', function() {
            clearTimeout(searchTimeout);
            searchTimeout = setTimeout(filterCustomers, 300);
        });

        // Row double-click to edit
        document.addEventListener('DOMContentLoaded', function() {
            const rows = document.querySelectorAll('.customer-row');
            rows.forEach(row => {
                row.addEventListener('dblclick', function() {
                    const editBtn = this.querySelector('.btn-edit');
                    if (editBtn) {
                        window.location.href = editBtn.href;
                    }
                });
            });

            // Populate location filter dynamically
            populateLocationFilter();
        });

        // Populate location filter with unique locations
        function populateLocationFilter() {
            const locationFilter = document.getElementById('locationFilter');
            const rows = document.querySelectorAll('.customer-row');
            const locations = new Set();
            
            rows.forEach(row => {
                const address = row.querySelector('.customer-address').textContent.trim();
                if (address) {
                    // Extract city/area from address (you can customize this logic)
                    const addressParts = address.split(',');
                    if (addressParts.length > 1) {
                        locations.add(addressParts[addressParts.length - 1].trim());
                    } else {
                        locations.add(address);
                    }
                }
            });
            
            // Add unique locations to filter
            locations.forEach(location => {
                if (location) {
                    const option = document.createElement('option');
                    option.value = location.toLowerCase();
                    option.textContent = location;
                    locationFilter.appendChild(option);
                }
            });
        }

        // Keyboard shortcuts
        document.addEventListener('keydown', function(e) {
            // Ctrl+F to focus search
            if (e.ctrlKey && e.key === 'f') {
                e.preventDefault();
                document.getElementById('searchInput').focus();
            }
            // Ctrl+N to add new customer
            if (e.ctrlKey && e.key === 'n') {
                e.preventDefault();
                window.location.href = 'add-customer.jsp';
            }
        });

        // Export functionality (bonus feature)
        function exportCustomers() {
            showLoading(true);
            
            const rows = document.querySelectorAll('.customer-row:not([style*="display: none"])');
            let csvContent = "Name,Address,Age,Phone,Email\n";
            
            rows.forEach(row => {
                const name = row.querySelector('.customer-name').textContent;
                const address = row.querySelector('.customer-address').textContent;
                const age = row.querySelector('.age-badge').textContent.split(' ')[0];
                const phone = row.querySelector('.customer-phone').textContent;
                const email = row.querySelector('.customer-email').textContent;
                
                csvContent += `"${name}","${address}","${age}","${phone}","${email}"\n`;
            });
            
            const blob = new Blob([csvContent], { type: 'text/csv' });
            const url = window.URL.createObjectURL(blob);
            const a = document.createElement('a');
            a.style.display = 'none';
            a.href = url;
            a.download = 'customers.csv';
            document.body.appendChild(a);
            a.click();
            window.URL.revokeObjectURL(url);
            document.body.removeChild(a);
            
            setTimeout(() => {
                showLoading(false);
                alert('Customer data exported successfully!');
            }, 1000);
        }

        // Additional utility functions for better user experience
        
        // Auto-save search preferences to sessionStorage (if available)
        function saveSearchPreferences() {
            try {
                const preferences = {
                    searchTerm: document.getElementById('searchInput').value,
                    ageFilter: document.getElementById('ageFilter').value,
                    locationFilter: document.getElementById('locationFilter').value
                };
                sessionStorage.setItem('customerSearchPreferences', JSON.stringify(preferences));
            } catch (e) {
                // Ignore if sessionStorage is not available
            }
        }

        // Load search preferences from sessionStorage
        function loadSearchPreferences() {
            try {
                const saved = sessionStorage.getItem('customerSearchPreferences');
                if (saved) {
                    const preferences = JSON.parse(saved);
                    document.getElementById('searchInput').value = preferences.searchTerm || '';
                    document.getElementById('ageFilter').value = preferences.ageFilter || '';
                    document.getElementById('locationFilter').value = preferences.locationFilter || '';
                    filterCustomers();
                }
            } catch (e) {
                // Ignore if sessionStorage is not available or data is corrupted
            }
        }

        // Save preferences when filters change
        document.getElementById('searchInput').addEventListener('input', saveSearchPreferences);
        document.getElementById('ageFilter').addEventListener('change', saveSearchPreferences);
        document.getElementById('locationFilter').addEventListener('change', saveSearchPreferences);

        // Load preferences on page load
        window.addEventListener('load', loadSearchPreferences);

        // Print customer list functionality
        function printCustomerList() {
            const printWindow = window.open('', '_blank');
            const visibleRows = document.querySelectorAll('.customer-row:not([style*="display: none"])');
            
            let printContent = `
                <html>
                <head>
                    <title>Customer List - Pahana Edu</title>
                    <style>
                        body { font-family: Arial, sans-serif; margin: 20px; }
                        h1 { color: #2C3E50; text-align: center; }
                        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
                        th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
                        th { background-color: #2C3E50; color: white; }
                        .footer { text-align: center; margin-top: 20px; font-size: 12px; color: #666; }
                    </style>
                </head>
                <body>
                    <h1>Customer List - Pahana Edu</h1>
                    <p>Generated on: ${new Date().toLocaleString()}</p>
                    <table>
                        <thead>
                            <tr>
                                <th>Name</th>
                                <th>Address</th>
                                <th>Age</th>
                                <th>Phone</th>
                                <th>Email</th>
                            </tr>
                        </thead>
                        <tbody>
            `;

            visibleRows.forEach(row => {
                const name = row.querySelector('.customer-name').textContent;
                const address = row.querySelector('.customer-address').textContent;
                const age = row.querySelector('.age-badge').textContent.split(' ')[0];
                const phone = row.querySelector('.customer-phone').textContent;
                const email = row.querySelector('.customer-email').textContent;
                
                printContent += `
                    <tr>
                        <td>${name}</td>
                        <td>${address}</td>
                        <td>${age}</td>
                        <td>${phone}</td>
                        <td>${email}</td>
                    </tr>
                `;
            });

            printContent += `
                        </tbody>
                    </table>
                    <div class="footer">
                        <p>Total Customers: ${visibleRows.length}</p>
                        <p>© ${new Date().getFullYear()} Pahana Edu - Customer Management System</p>
                    </div>
                </body>
                </html>
            `;

            printWindow.document.write(printContent);
            printWindow.document.close();
            printWindow.print();
        }

        // Toast notification system
        function showToast(message, type = 'info') {
            const toast = document.createElement('div');
            toast.style.cssText = `
                position: fixed; top: 20px; right: 20px; z-index: 10000;
                background: ${type === 'success' ? '#28a745' : type === 'error' ? '#dc3545' : '#17a2b8'};
                color: white; padding: 12px 20px; border-radius: 6px;
                font-size: 14px; font-weight: 500; box-shadow: 0 4px 12px rgba(0,0,0,0.15);
                transform: translateX(100%); transition: transform 0.3s ease;
            `;
            toast.textContent = message;
            document.body.appendChild(toast);

            // Animate in
            setTimeout(() => toast.style.transform = 'translateX(0)', 100);

            // Auto remove after 3 seconds
            setTimeout(() => {
                toast.style.transform = 'translateX(100%)';
                setTimeout(() => document.body.removeChild(toast), 300);
            }, 3000);
        }

        // Success message handling
        <% if (request.getParameter("success") != null) { %>
            window.addEventListener('load', () => {
                showToast('Customer operation completed successfully!', 'success');
            });
        <% } %>

        // Error message handling
        <% if (request.getParameter("error") != null) { %>
            window.addEventListener('load', () => {
                showToast('An error occurred. Please try again.', 'error');
            });
        <% } %>
    </script>
</body>
</html>