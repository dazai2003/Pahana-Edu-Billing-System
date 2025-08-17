<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.pahanaedu.dao.ItemDAO, com.pahanaedu.model.Item, java.util.List, com.pahanaedu.model.User" %>
<%
User user = (User) session.getAttribute("loggedUser");
if (user == null) {
    response.sendRedirect("login.jsp");
    return;
}

List<Item> items = ItemDAO.getAllItems();
int totalItems = items.size();
int lowStockItems = 0;
double totalValue = 0.0;

for (Item item : items) {
    if (item.getQuantity() < 10) {
        lowStockItems++;
    }
    totalValue += item.getPrice() * item.getQuantity();
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pahana Edu - View Items</title>
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
    color: #ffffff; /* white text or contrast */
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
    margin-bottom:8px
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .page-subtitle {
            color: #5F9EA0;
            font-size: 16px;
            font-weight: 400;
            margin-bottom:25px;
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

        .stat-card.warning h2 {
            color: #E67E22;
        }

        .stat-card.warning {
            border-left-color: #E67E22;
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

        .add-item-btn {
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

        .add-item-btn:hover {
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

        /* Item Status Badges */
        .stock-badge {
            padding: 4px 8px;
            border-radius: 12px;
            font-size: 12px;
            font-weight: 600;
            text-transform: uppercase;
        }

        .stock-badge.in-stock {
            background: rgba(139, 168, 142, 0.2);
            color: #8BA88E;
        }

        .stock-badge.low-stock {
            background: rgba(230, 126, 34, 0.2);
            color: #E67E22;
        }

        .stock-badge.out-stock {
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

        .item-count {
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
            <h1 class="page-title">
                📚 Inventory Management
            </h1>
            <p class="page-subtitle">Manage your book inventory, track stock levels, and monitor item details</p>
        </div>

        <!-- Stats Cards -->
        <div class="stats-grid">
            <div class="stat-card">
                <h2><%= totalItems %></h2>
                <p>Total Items</p>
            </div>
            <div class="stat-card <%= lowStockItems > 0 ? "warning" : "" %>">
                <h2><%= lowStockItems %></h2>
                <p>Low Stock Items</p>
            </div>
           <%
double displayValue = totalValue;
String formattedValue;

if (displayValue >= 1_000_000_000) { // Billions
    formattedValue = String.format("%.1fB", displayValue / 1_000_000_000);
} else if (displayValue >= 1_000_000) { // Millions
    formattedValue = String.format("%.1fM", displayValue / 1_000_000);
} else if (displayValue >= 1_000) { // Thousands
    formattedValue = String.format("%.1fK", displayValue / 1_000);
} else {
    formattedValue = String.format("%.2f", displayValue);
}
%>

<div class="stat-card">
    <h2>Rs.<%= formattedValue %></h2>
    <p>Total Inventory Value</p>
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
                           placeholder="Search items by name, description, or type..."
                           onkeyup="filterItems()">
                </div>
                <select class="filter-select" id="typeFilter" onchange="filterItems()">
                    <option value="">All Types</option>
                    <option value="Book">Books</option>
                    <option value="Stationery">Stationery</option>
                    <option value="Equipment">Equipment</option>
                </select>
                <select class="filter-select" id="stockFilter" onchange="filterItems()">
                    <option value="">All Stock</option>
                    <option value="in-stock">In Stock</option>
                    <option value="low-stock">Low Stock</option>
                    <option value="out-stock">Out of Stock</option>
                </select>
            </div>
            <a href="add-item.jsp" class="add-item-btn">
                ➕ Add New Item
            </a>
        </div>

        <!-- Table Container -->
        <div class="table-container">
            <div class="stats-bar">
                <span class="item-count">Total Items: <%= totalItems %></span>
                <span id="filteredCount">Showing: <%= totalItems %></span>
            </div>
            
            <% if (items.size() > 0) { %>
                <table class="table" id="itemsTable">
                    <thead>
                        <tr>
                            <th>📖 Name</th>
                            <th>📝 Description</th>
                            <th>💰 Price</th>
                            <th>📦 Quantity</th>
                            <th>🏷️ Type</th>
                            <th>📊 Status</th>
                            <th>⚙️ Actions</th>
                        </tr>
                    </thead>
                    <tbody id="itemTableBody">
                        <% for (Item item : items) { 
                            String stockStatus = "in-stock";
                            String stockLabel = "In Stock";
                            if (item.getQuantity() == 0) {
                                stockStatus = "out-stock";
                                stockLabel = "Out of Stock";
                            } else if (item.getQuantity() < 10) {
                                stockStatus = "low-stock";
                                stockLabel = "Low Stock";
                            }
                        %>
                            <tr class="item-row" data-type="<%= item.getItemType() %>" data-stock="<%= stockStatus %>">
                                <td class="item-name"><%= item.getName() %></td>
                                <td class="item-description"><%= item.getDescription() %></td>
                                <td class="price-cell">Rs.<%= String.format("%.2f", item.getPrice()) %></td>
                                <td class="item-quantity"><%= item.getQuantity() %></td>
                                <td class="item-type"><%= item.getItemType() %></td>
                                <td>
                                    <span class="stock-badge <%= stockStatus %>">
                                        <%= stockLabel %>
                                    </span>
                                </td>
                                <td>
                                    <div class="action-buttons">
                                        <a href="edit-item.jsp?id=<%= item.getItemID() %>" 
                                           class="btn-edit">✏️ Edit</a>
                                        <button onclick="confirmDelete(<%= item.getItemID() %>, '<%= item.getName() %>')" 
                                                class="btn-delete">🗑️ Delete</button>
                                    </div>
                                </td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            <% } else { %>
                <div class="empty-state">
                    <div class="empty-state-icon">📚</div>
                    <h3>No Items Found</h3>
                    <p>Start by adding your first item to the inventory.</p>
                    <br>
                    <a href="add-item.jsp" class="add-item-btn">
                        ➕ Add First Item
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
        // Filter functionality
        function filterItems() {
            const searchTerm = document.getElementById('searchInput').value.toLowerCase();
            const typeFilter = document.getElementById('typeFilter').value;
            const stockFilter = document.getElementById('stockFilter').value;
            const rows = document.querySelectorAll('.item-row');
            let visibleCount = 0;

            rows.forEach(row => {
                const name = row.querySelector('.item-name').textContent.toLowerCase();
                const description = row.querySelector('.item-description').textContent.toLowerCase();
                const type = row.querySelector('.item-type').textContent;
                const itemType = row.getAttribute('data-type');
                const stockStatus = row.getAttribute('data-stock');

                const matchesSearch = name.includes(searchTerm) || 
                                    description.includes(searchTerm) || 
                                    type.toLowerCase().includes(searchTerm);
                
                const matchesType = !typeFilter || itemType === typeFilter;
                const matchesStock = !stockFilter || stockStatus === stockFilter;

                if (matchesSearch && matchesType && matchesStock) {
                    row.style.display = '';
                    visibleCount++;
                } else {
                    row.style.display = 'none';
                }
            });

            document.getElementById('filteredCount').textContent = `Showing: ${visibleCount}`;
        }

        // Delete confirmation
       function confirmDelete(itemId, itemName) {
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
                Are you sure you want to delete item <b>"${itemName}"</b>?
                <br><br>
                This action <b>cannot be undone</b>.
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
        window.location.href = `deleteItem?id=${itemId}`;
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
            searchTimeout = setTimeout(filterItems, 300);
        });

        // Row double-click to edit
        document.addEventListener('DOMContentLoaded', function() {
            const rows = document.querySelectorAll('.item-row');
            rows.forEach(row => {
                row.addEventListener('dblclick', function() {
                    const editBtn = this.querySelector('.btn-edit');
                    if (editBtn) {
                        window.location.href = editBtn.href;
                    }
                });
            });
        });

        // Keyboard shortcuts
        document.addEventListener('keydown', function(e) {
            // Ctrl+F to focus search
            if (e.ctrlKey && e.key === 'f') {
                e.preventDefault();
                document.getElementById('searchInput').focus();
            }
            // Ctrl+N to add new item
            if (e.ctrlKey && e.key === 'n') {
                e.preventDefault();
                window.location.href = 'add-item.jsp';
            }
        });

        // Auto-populate type filter based on available types
        document.addEventListener('DOMContentLoaded', function() {
            const typeFilter = document.getElementById('typeFilter');
            const rows = document.querySelectorAll('.item-row');
            const types = new Set();
            
            rows.forEach(row => {
                types.add(row.getAttribute('data-type'));
            });
            
            // Clear existing options except "All Types"
            while (typeFilter.children.length > 1) {
                typeFilter.removeChild(typeFilter.lastChild);
            }
            
            // Add unique types
            types.forEach(type => {
                if (type) {
                    const option = document.createElement('option');
                    option.value = type;
                    option.textContent = type;
                    typeFilter.appendChild(option);
                }
            });
        });
    </script>
</body>
</html>