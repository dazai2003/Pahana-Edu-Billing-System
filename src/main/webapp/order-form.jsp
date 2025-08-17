<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ page import="java.util.*, com.pahanaedu.model.Customer, com.pahanaedu.model.Item, com.pahanaedu.dao.CustomerDAO, com.pahanaedu.dao.ItemDAO" %>
<%@ page import="com.pahanaedu.model.User" %>
<%
User user = (User) session.getAttribute("loggedUser");
if (user == null) {
    response.sendRedirect("login.jsp");
    return;
}

List<Customer> customerList = CustomerDAO.getAllCustomers();
List<Item> itemList = ItemDAO.getAllItems();
%>
<!DOCTPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pahana Edu - Create New Order</title>
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

        /* Nabar */
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

        /* Main Container */
        .container {
            max-width: 1400px;
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

        /* Form Container */
        .form-container {
            background: white;
            border-radius: 12px;
            padding: 24px;
            margin-bottom: 24px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
            border-left: 6px solid #5F9EA0;
        }

        .form-section {
            margin-bottom: 32px;
        }

        .form-section:last-child {
            margin-bottom: 0;
        }

        .section-title {
            font-size: 18px;
            font-weight: 600;
            color: #2C3E50;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 8px;
            padding-bottom: 12px;
            border-bottom: 2px solid #f0f0f0;
        }

        /* Form Grid */
        .form-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 20px;
        }

        .form-group {
            display: flex;
            flex-direction: column;
        }

        .form-label {
            font-size: 14px;
            font-weight: 600;
            color: #2C3E50;
            margin-bottom: 8px;
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .form-input {
            padding: 12px 16px;
            border: 2px solid #e0e6ed;
            border-radius: 8px;
            background: white;
            color: #333333;
            font-size: 14px;
            transition: all 0.3s ease;
        }

        .form-input::placeholder {
            color: #999;
        }

        .form-input:focus {
            outline: none;
            border-color: #5F9EA0;
            box-shadow: 0 0 0 3px rgba(95, 158, 160, 0.1);
        }

        .form-input.error {
            border-color: #dc3545;
            box-shadow: 0 0 0 3px rgba(220, 53, 69, 0.1);
        }

        /* Customer Autocomplete */
        .customer-autocomplete {
            position: relative;
            display: inline-block;
            width: 100%;
        }

        .customer-suggestions {
            position: absolute;
            top: 100%;
            left: 0;
            width: 100%;
            background: white;
            border: 2px solid #e0e6ed;
            border-top: none;
            border-radius: 0 0 8px 8px;
            max-height: 200px;
            overflow-y: auto;
            z-index: 10000;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
            display: none;
        }

        .customer-suggestions.show {
            display: block;
        }

        .customer-suggestions div {
            padding: 12px 16px;
            cursor: pointer;
            transition: background-color 0.2s ease;
            border-bottom: 1px solid #f0f0f0;
        }

        .customer-suggestions div:last-child {
            border-bottom: none;
        }

        .customer-suggestions div:hover,
        .customer-suggestions div.autocomplete-active {
            background-color: rgba(95, 158, 160, 0.1);
        }

        /* Item Autocomplete */
        .item-autocomplete {
            position: relative;
            display: inline-block;
            width: 100%;
        }

        .item-suggestions {
            position: absolute;
            top: 100%;
            left: 0;
            width: max(100%, 350px);
            background: white;
            border: 2px solid #e0e6ed;
            border-top: none;
            border-radius: 0 0 8px 8px;
            max-height: 250px;
            overflow-y: auto;
            z-index: 99999;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
            display: none;
        }

        .item-suggestions.show {
            display: block;
        }

        .item-suggestions div {
            padding: 12px 16px;
            cursor: pointer;
            transition: background-color 0.2s ease;
            border-bottom: 1px solid #f0f0f0;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .item-suggestions div:last-child {
            border-bottom: none;
        }

        .item-suggestions div:hover,
        .item-suggestions div.autocomplete-active {
            background-color: rgba(95, 158, 160, 0.1);
        }

        .item-suggestions div.no-stock {
            background-color: rgba(220, 53, 69, 0.1);
            color: #dc3545;
            cursor: not-allowed;
        }

        .item-suggestions div.no-stock:hover {
            background-color: rgba(220, 53, 69, 0.15);
        }

        /* Customer Info Display */
        .customer-info {
            background: rgba(95, 158, 160, 0.05);
            border: 2px solid rgba(95, 158, 160, 0.2);
            border-radius: 8px;
            padding: 20px;
            margin-top: 20px;
            display: none;
        }

        .customer-info.show {
            display: block;
            animation: slideDown 0.3s ease;
        }

        @keyframes slideDown {
            from {
                opacity: 0;
                transform: translateY(-10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .customer-info h4 {
            color: #2C3E50;
            margin-bottom: 16px;
            font-size: 16px;
        }

        .info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 16px;
        }

        .info-item {
            display: flex;
            flex-direction: column;
            gap: 4px;
        }

        .info-label {
            font-size: 12px;
            font-weight: 600;
            color: #666;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .info-value {
            font-size: 14px;
            font-weight: 500;
            color: #2C3E50;
        }

        /* Items Section */
        .items-section {
            background: white;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            margin-bottom: 24px;
        }

        .table-header {
            background: #2C3E50;
            color: white;
            padding: 20px 24px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .table-title {
            font-size: 18px;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .add-item-btn {
            background: linear-gradient(135deg, #8BA88E 0%, rgba(139, 168, 142, 0.8) 100%);
            color: white;
            border: none;
            padding: 10px 16px;
            border-radius: 6px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .add-item-btn:hover {
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(139, 168, 142, 0.3);
        }

        .items-table {
            width: 100%;
            border-collapse: collapse;
            table-layout: fixed;
        }

        .items-table th {
            background: #f8f9fa;
            color: #2C3E50;
            padding: 16px 12px;
            text-align: left;
            font-weight: 600;
            font-size: 14px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            border-bottom: 2px solid #e0e6ed;
        }

        .items-table td {
            padding: 12px;
            border-bottom: 1px solid #f0f0f0;
            position: relative;
        }

        .items-table tbody tr {
            transition: all 0.3s ease;
        }

        .items-table tbody tr:hover {
            background: rgba(95, 158, 160, 0.05);
        }

        .table-input {
            width: 100%;
            padding: 8px 12px;
            border: 1px solid #e0e6ed;
            border-radius: 6px;
            font-size: 14px;
            transition: all 0.3s ease;
        }

        .table-input:focus {
            outline: none;
            border-color: #5F9EA0;
            box-shadow: 0 0 0 2px rgba(95, 158, 160, 0.1);
        }

        .table-input[readonly] {
            background: #f8f9fa;
            color: #666;
        }

        .remove-row-btn {
            background: #dc3545;
            color: white;
            border: none;
            padding: 8px 12px;
            border-radius: 6px;
            cursor: pointer;
            font-size: 12px;
            transition: all 0.3s ease;
        }

        .remove-row-btn:hover {
            background: #c82333;
            transform: translateY(-1px);
        }

        /* Stock Warning */
        .stock-warning {
            background: rgba(220, 53, 69, 0.1);
            border: 1px solid rgba(220, 53, 69, 0.3);
            color: #dc3545;
            padding: 8px 12px;
            border-radius: 6px;
            font-size: 12px;
            font-weight: 600;
            margin-top: 4px;
            display: none;
        }

        .stock-warning.show {
            display: block;
        }

        /* Payment Section */
        .payment-section {
            background: white;
            border-radius: 12px;
            padding: 24px;
            margin-bottom: 24px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
            border-left: 6px solid #8BA88E;
        }

        .payment-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-top: 20px;
        }

        .payment-input {
            padding: 12px 16px;
            border: 2px solid #e0e6ed;
            border-radius: 8px;
            background: white;
            color: #333333;
            font-size: 16px;
            font-weight: 600;
            text-align: right;
            transition: all 0.3s ease;
        }

        .payment-input:focus {
            outline: none;
            border-color: #8BA88E;
            box-shadow: 0 0 0 3px rgba(139, 168, 142, 0.1);
        }

        .payment-display {
            background: rgba(139, 168, 142, 0.1);
            border: 2px solid rgba(139, 168, 142, 0.3);
            border-radius: 8px;
            padding: 12px 16px;
            font-size: 16px;
            font-weight: 700;
            text-align: right;
            color: #8BA88E;
        }

        .change-display {
            background: rgba(95, 158, 160, 0.1);
            border: 2px solid rgba(95, 158, 160, 0.3);
            border-radius: 8px;
            padding: 12px 16px;
            font-size: 18px;
            font-weight: 700;
            text-align: right;
            color: #5F9EA0;
        }

        .change-display.negative {
            background: rgba(220, 53, 69, 0.1);
            border-color: rgba(220, 53, 69, 0.3);
            color: #dc3545;
        }

        /* Order Summary */
        .order-summary {
            background: white;
            border-radius: 12px;
            padding: 24px;
            margin-bottom: 24px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
            border-left: 6px solid #8BA88E;
        }

        .summary-title {
            font-size: 18px;
            font-weight: 600;
            color: #2C3E50;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .summary-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 16px;
        }

        .summary-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 12px 16px;
            background: rgba(139, 168, 142, 0.05);
            border-radius: 8px;
            transition: all 0.3s ease;
        }

        .summary-item:hover {
            background: rgba(139, 168, 142, 0.1);
        }

        .summary-item.total {
            background: rgba(95, 158, 160, 0.1);
            border: 2px solid rgba(95, 158, 160, 0.3);
            font-weight: 700;
        }

        .summary-label {
            font-size: 14px;
            font-weight: 600;
            color: #2C3E50;
        }

        .summary-value {
            font-size: 16px;
            font-weight: 700;
            color: #8BA88E;
        }

        .summary-item.total .summary-value {
            color: #5F9EA0;
            font-size: 18px;
        }

        /* Form Actions */
        .form-actions {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 16px;
            flex-wrap: wrap;
        }

        .btn-primary {
            background: linear-gradient(135deg, #8BA88E 0%, rgba(139, 168, 142, 0.8) 100%);
            color: white;
            border: none;
            padding: 14px 24px;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .btn-primary:hover {
            transform: translateY(-1px);
            box-shadow: 0 6px 20px rgba(139, 168, 142, 0.3);
        }

        .btn-primary:disabled {
            opacity: 0.6;
            cursor: not-allowed;
            transform: none;
            box-shadow: none;
        }

        .btn-secondary {
            background: white;
            color: #2C3E50;
            border: 2px solid #e0e6ed;
            padding: 14px 24px;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            text-decoration: none;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .btn-secondary:hover {
            border-color: #5F9EA0;
            background: rgba(95, 158, 160, 0.05);
        }

        /* Bill Actions */
        .bill-actions {
            display: flex;
            gap: 12px;
            flex-wrap: wrap;
        }

        .btn-bill {
            background: linear-gradient(135deg, #5F9EA0 0%, rgba(95, 158, 160, 0.8) 100%);
            color: white;
            border: none;
            padding: 12px 20px;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .btn-bill:hover {
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(95, 158, 160, 0.3);
        }

        /* Error Messages */
        .error-message {
            color: #dc3545;
            font-size: 12px;
            margin-top: 4px;
            display: none;
        }

        .error-message.show {
            display: block;
        }

        /* Loading Indicator */
        .loading {
            display: none;
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background: white;
            padding: 20px 30px;
            border-radius: 12px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3);
            z-index: 9999;
            text-align: center;
        }

        .spinner {
            border: 3px solid #f3f3f3;
            border-top: 3px solid #5F9EA0;
            border-radius: 50%;
            width: 24px;
            height: 24px;
            animation: spin 1s linear infinite;
            display: inline-block;
            margin-right: 10px;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        /* Quick Actions */
        .quick-actions {
            display: flex;
            gap: 12px;
            margin-top: 16px;
            flex-wrap: wrap;
        }

        .quick-btn {
            background: rgba(95, 158, 160, 0.1);
            color: #5F9EA0;
            border: 2px solid rgba(95, 158, 160, 0.3);
            padding: 8px 12px;
            border-radius: 6px;
            font-size: 12px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .quick-btn:hover {
            background: rgba(95, 158, 160, 0.2);
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

            .form-grid {
                grid-template-columns: 1fr;
            }

            .summary-grid {
                grid-template-columns: 1fr;
            }

            .payment-grid {
                grid-template-columns: 1fr;
            }

            .form-actions {
                flex-direction: column;
                align-items: stretch;
            }

            .bill-actions {
                flex-direction: column;
            }

            .items-table {
                min-width: 800px;
            }

            .items-section {
                overflow-x: auto;
            }
        }

        /* Print Styles */
        @media print {
            .navbar, .form-actions {
                display: none;
            }
            
            body {
                background: white;
            }
            
            .container {
                max-width: none;
                padding: 0;
            }
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
            <h1 class="page-title">🛒 Create New Order</h1>
            <p class="page-subtitle">Add items, select customers, process payments, and generate bills efficiently</p>
        </div>

        <form action="OrderServlet" method="post" id="orderForm">
            <!-- Customer Selection Section -->
            <div class="form-container">
                <div class="form-section">
                    <h3 class="section-title">👤 Customer Information</h3>
                    
                    <div class="form-grid">
                        <div class="form-group">
                            <label class="form-label" for="customerSearch">
                                🔍 Select Customer
                            </label>
                            <div class="customer-autocomplete">
                                <input type="text" 
                                       id="customerSearch" 
                                       class="form-input" 
                                       placeholder="Search customer by name or phone..." 
                                       required
                                       autocomplete="off">
                                <input type="hidden" name="customerID" id="customerID">
                                <div class="customer-suggestions" id="customerSuggestions"></div>
                            </div>
                            <div class="error-message" id="customerError">Please select a valid customer</div>
                            
                            <div class="quick-actions">
                                <a href="add-customer.jsp" class="quick-btn" target="_blank">
                                    ➕ Add New Customer
                                </a>
                            </div>
                        </div>
                    </div>

                    <div class="customer-info" id="customerInfo">
                        <h4>📋 Selected Customer Details</h4>
                        <div class="info-grid">
                            <div class="info-item">
                                <span class="info-label">👤 Name</span>
                                <span class="info-value" id="custName">-</span>
                            </div>
                            <div class="info-item">
                                <span class="info-label">📞 Phone</span>
                                <span class="info-value" id="custPhone">-</span>
                            </div>
                            <div class="info-item">
                                <span class="info-label">📧 Email</span>
                                <span class="info-value" id="custEmail">-</span>
                            </div>
                            <div class="info-item">
                                <span class="info-label">📍 Address</span>
                                <span class="info-value" id="custAddress">-</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Items Section -->
            <div class="items-section">
                <div class="table-header">
                    <h3 class="table-title">🛍️ Order Items</h3>
                    <div style="display: flex; gap: 12px;">
                        <button type="button" class="add-item-btn" onclick="addItemRow()">
                            ➕ Add Item
                        </button>
                        <button type="button" class="add-item-btn" onclick="clearAllItems()" style="background: #dc3545;">
                            🗑️ Clear All
                        </button>
                    </div>
                </div>

                <table class="items-table" id="itemsTable">
                    <thead>
                        <tr>
                            <th style="width: 30%;">📦 Item Name</th>
                            <th style="width: 15%;">🔢 Quantity</th>
                            <th style="width: 15%;">💰 Unit Price</th>
                            <th style="width: 15%;">🏷️ Discount (%)</th>
                            <th style="width: 15%;">💵 Total Price</th>
                            <th style="width: 10%;">⚙️ Actions</th>
                        </tr>
                    </thead>
                    <tbody id="itemsTableBody">
                        <!-- Dynamic rows will be added here -->
                    </tbody>
                </table>
            </div>

          <!-- Payment Section -->
<div class="payment-section">
    <h3 class="section-title">💳 Payment Information</h3>
    <div class="payment-grid">

        <!-- Customer Paid Amount -->
        <div class="form-group">
            <label class="form-label" for="customerMoney">
                💵 Customer Paid Amount
            </label>

            <input type="number" 
                   id="customerMoney" 
                   name="customerMoney"
                   class="payment-input" 
                   placeholder="0.00" 
                   step="0.01" 
                   min="0"
                   oninput="calculateChange()">

            <div class="quick-actions">
                <button type="button" class="quick-btn" onclick="setExactAmount()">
                    💯 Exact Amount
                </button>
                <button type="button" class="quick-btn" onclick="addQuickAmount(100)">
                    +Rs.100
                </button>
                <button type="button" class="quick-btn" onclick="addQuickAmount(500)">
                    +Rs.500
                </button>
                <button type="button" class="quick-btn" onclick="addQuickAmount(1000)">
                    +Rs.1000
                </button>
            </div>
        </div>

        <!-- Order Total -->
        <div class="form-group">
            <label class="form-label">
                💰 Order Total
            </label>
            <div class="payment-display" id="paymentTotal">Rs. 0.00</div>
        </div>

        <!-- Change to Return -->
        <div class="form-group">
            <label class="form-label">
                💸 Change to Return
            </label>
            <div class="change-display" id="changeAmount">Rs. 0.00</div>
            <!-- Hidden fields to pass values to bill.jsp -->
            <input type="hidden" name="givenMoney" id="givenMoney">
            <input type="hidden" name="changeGiven" id="changeGiven">
        </div>
    </div>
</div>

            <!-- Order Summary -->
            <div class="order-summary">
                <h3 class="summary-title">📊 Order Summary</h3>
                <div class="summary-grid">
                    <div class="summary-item">
                        <span class="summary-label">Total Items</span>
                        <span class="summary-value" id="totalItems">0</span>
                    </div>
                    <div class="summary-item">
                        <span class="summary-label">Subtotal</span>
                        <span class="summary-value">Rs. <span id="subtotal">0.00</span></span>
                    </div>
                    <div class="summary-item">
                        <span class="summary-label">Total Discount</span>
                        <span class="summary-value">Rs. <span id="totalDiscount">0.00</span></span>
                    </div>
                    <div class="summary-item total">
                        <span class="summary-label">Grand Total</span>
                        <span class="summary-value">Rs. <span id="grandTotal">0.00</span></span>
                    </div>
                </div>
            </div>

            <!-- Form Actions -->
            <div class="form-actions">
                <div>
                    <a href="dashboard.jsp" class="btn-secondary">
                        ❌ Cancel Order
                    </a>
                </div>
                
                <div class="bill-actions">
                   
                    <button type="submit" class="btn-primary" id="submitBtn">
                        <span class="spinner" id="submitSpinner" style="display: none;"></span>
                        ✅ Create Order & Generate Bill
                    </button>
                </div>
            </div>
        </form>

        <!-- Loading Indicator -->
        <div class="loading" id="loadingIndicator">
            <div class="spinner"></div>
            Processing order and generating bill...
        </div>
    </div>

    <script>
        let customers = [
            <% for (Customer c : customerList) { %>
                { 
                    id: <%= c.getCustomerID() %>, 
                    name: "<%= c.getName().replace("\"", "\\\"") %>", 
                    phone: "<%= c.getTelephone() %>", 
                    email: "<%= c.getEmail() %>", 
                    address: "<%= c.getAddress().replace("\"", "\\\"") %>" 
                },
            <% } %>
        ];

        let items = [
            <% for (Item i : itemList) { %>
                { 
                    id: <%= i.getItemID() %>, 
                    name: "<%= i.getName().replace("\"", "\\\"") %>", 
                    price: <%= i.getPrice() %>,
                    quantity: <%= i.getQuantity() %>
                },
            <% } %>
        ];

        let itemData = {};
        <% for (Item item : itemList) { %>
            itemData[<%= item.getItemID() %>] = { 
                price: <%= item.getPrice() %>,
                quantity: <%= item.getQuantity() %>
            };
        <% } %>

        let rowIndex = 0;
        let formChanged = false;
        let orderSubmitted = false;

        // Enhanced Autocomplete Function with stock checking
        function setupAutocomplete(input, data, onSelect, suggestionsId) {
            let currentFocus = -1;
            let suggestionsList = document.getElementById(suggestionsId);
            let debounceTimer;
            
            input.addEventListener("input", function () {
                clearTimeout(debounceTimer);
                debounceTimer = setTimeout(() => {
                    let val = this.value.trim();
                    clearSuggestions();
                    
                    if (!val) return;
                    
                    let matches = data.filter(d => 
                        d.name.toLowerCase().includes(val.toLowerCase()) ||
                        (d.phone && d.phone.includes(val))
                    );
                    
                    if (matches.length > 0) {
                        matches.slice(0, 8).forEach((match, index) => {
                            let itemDiv = document.createElement("div");
                            if (match.phone) {
                                // Customer suggestion
                                itemDiv.innerHTML = `
                                    <strong>${match.name}</strong><br>
                                    <small style="color: #666;">📞 ${match.phone} | 📧 ${match.email}</small>
                                `;
                            } else {
                                // Item suggestion with stock check
                                if (match.quantity <= 0) {
                                    itemDiv.innerHTML = `
                                        <strong>${match.name}</strong><br>
                                        <small style="color: #dc3545;">⚠️ Out of Stock - Rs. ${match.price.toFixed(2)}</small>
                                    `;
                                    itemDiv.classList.add('no-stock');
                                } else {
                                    itemDiv.innerHTML = `
                                        <strong>${match.name}</strong><br>
                                        <small style="color: #666;">💰 Rs. ${match.price.toFixed(2)} | 📦 Stock: ${match.quantity}</small>
                                    `;
                                }
                            }
                            
                            itemDiv.addEventListener("click", function (e) {
                                e.stopPropagation();
                                if (match.quantity !== undefined && match.quantity <= 0) {
                                    alert(`Sorry, "${match.name}" is currently out of stock and cannot be added to the order.`);
                                    return;
                                }
                                input.value = match.name;
                                onSelect(match);
                                clearSuggestions();
                            });
                            suggestionsList.appendChild(itemDiv);
                        });
                        suggestionsList.classList.add('show');
                    } else {
                        let noResultDiv = document.createElement("div");
                        noResultDiv.innerHTML = "<em style='color: #999; padding: 12px 16px;'>No results found</em>";
                        suggestionsList.appendChild(noResultDiv);
                        suggestionsList.classList.add('show');
                    }
                }, 300);
            });

            input.addEventListener("focus", function () {
                if (!this.value.trim()) {
                    showRecentSuggestions();
                }
            });

            input.addEventListener("keydown", function (e) {
                let items = suggestionsList.getElementsByTagName("div");
                
                if (e.keyCode == 40) { // down
                    e.preventDefault();
                    currentFocus++;
                    addActive(items);
                } else if (e.keyCode == 38) { // up
                    e.preventDefault();
                    currentFocus--;
                    addActive(items);
                } else if (e.keyCode == 13) { // enter
                    e.preventDefault();
                    if (currentFocus > -1 && items[currentFocus]) {
                        items[currentFocus].click();
                    } else if (items.length > 0 && items[0].innerHTML !== '<em style="color: #999; padding: 12px 16px;">No results found</em>') {
                        items[0].click();
                    }
                } else if (e.keyCode == 27) { // escape
                    clearSuggestions();
                }
            });

            function addActive(items) {
                if (!items || items.length === 0) return;
                removeActive(items);
                if (currentFocus >= items.length) currentFocus = 0;
                if (currentFocus < 0) currentFocus = items.length - 1;
                if (items[currentFocus]) {
                    items[currentFocus].classList.add("autocomplete-active");
                }
            }

            function removeActive(items) {
                for (let item of items) {
                    item.classList.remove("autocomplete-active");
                }
            }

            function clearSuggestions() {
                suggestionsList.innerHTML = '';
                suggestionsList.classList.remove('show');
                currentFocus = -1;
            }

            function showRecentSuggestions() {
                if (data === customers) {
                    clearSuggestions();
                    const recentCustomers = customers.slice(0, 5);
                    
                    const header = document.createElement("div");
                    header.innerHTML = "<strong style='color: #666; font-size: 12px;'>Recent Customers</strong>";
                    header.style.cssText = "padding: 8px 16px; background: #f8f9fa; border-bottom: 1px solid #e0e6ed;";
                    suggestionsList.appendChild(header);
                    
                    recentCustomers.forEach(customer => {
                        let itemDiv = document.createElement("div");
                        itemDiv.innerHTML = `
                            <strong>${customer.name}</strong><br>
                            <small style="color: #666;">📞 ${customer.phone} | 📧 ${customer.email}</small>
                        `;
                        itemDiv.addEventListener("click", function (e) {
                            e.stopPropagation();
                            input.value = customer.name;
                            onSelect(customer);
                            clearSuggestions();
                        });
                        suggestionsList.appendChild(itemDiv);
                    });
                    
                    suggestionsList.classList.add('show');
                }
            }

            document.addEventListener("click", function (e) {
                if (!input.parentNode.contains(e.target)) {
                    clearSuggestions();
                }
            });
        }

        // Price Calculation Functions with stock validation
        function updatePrice(index) {
            const itemId = document.getElementById(`itemID_${index}`).value;
            const quantity = parseInt(document.getElementById(`quantity_${index}`).value || 0);
            const discount = parseFloat(document.getElementById(`discount_${index}`).value || 0);
            const unitPriceField = document.getElementById(`unitPrice_${index}`);
            const totalPriceField = document.getElementById(`totalPrice_${index}`);
            const stockWarning = document.querySelector(`#stockWarning_${index}`);

            if (itemId && itemData[itemId]) {
                let basePrice = itemData[itemId].price;
                let availableStock = itemData[itemId].quantity;
                
                unitPriceField.value = basePrice.toFixed(2);
                
                // Stock validation
                if (quantity > availableStock) {
                    if (stockWarning) {
                        stockWarning.textContent = `⚠️ Only ${availableStock} items available in stock!`;
                        stockWarning.classList.add('show');
                    }
                    // Reset quantity to max available
                    document.getElementById(`quantity_${index}`).value = availableStock;
                    totalPriceField.value = "";
                    return;
                } else if (stockWarning) {
                    stockWarning.classList.remove('show');
                }
                
                let total = basePrice * quantity;
                let discountAmount = total * discount / 100;
                let finalTotal = total - discountAmount;
                
                totalPriceField.value = finalTotal.toFixed(2);
            } else {
                unitPriceField.value = "";
                totalPriceField.value = "";
                if (stockWarning) {
                    stockWarning.classList.remove('show');
                }
            }
            calculateOrderSummary();
        }

        function calculateOrderSummary() {
            let totalItems = 0;
            let subtotal = 0;
            let totalDiscount = 0;
            
            document.querySelectorAll("input[name='itemTotal']").forEach(field => {
                if (field.value) {
                    const row = field.closest('tr');
                    const quantity = parseInt(row.querySelector("input[name='quantity']").value || 0);
                    const unitPrice = parseFloat(row.querySelector("input[name='unitPrice']").value || 0);
                    const discount = parseFloat(row.querySelector("input[name='discount']").value || 0);
                    const total = parseFloat(field.value || 0);
                    
                    totalItems += quantity;
                    subtotal += unitPrice * quantity;
                    totalDiscount += (unitPrice * quantity * discount / 100);
                }
            });
            
            const grandTotal = subtotal - totalDiscount;
            
            document.getElementById("totalItems").textContent = totalItems;
            document.getElementById("subtotal").textContent = subtotal.toFixed(2);
            document.getElementById("totalDiscount").textContent = totalDiscount.toFixed(2);
            document.getElementById("grandTotal").textContent = grandTotal.toFixed(2);
            document.getElementById("paymentTotal").textContent = `Rs. ${grandTotal.toFixed(2)}`;
            
            calculateChange();
            formChanged = true;
        }

        // Payment Calculation Functions
        function calculateChange() {
            const customerMoney = parseFloat(document.getElementById("customerMoney").value || 0);
            const grandTotal = parseFloat(document.getElementById("grandTotal").textContent || 0);
            const change = customerMoney - grandTotal;
            
            const changeDisplay = document.getElementById("changeAmount");
            const changeHidden = document.getElementById("changeGiven");
            const givenMoneyHidden = document.getElementById("givenMoney");
            
            // Update hidden fields for form submission
            givenMoneyHidden.value = customerMoney.toFixed(2);
            
            if (change >= 0) {
                changeDisplay.textContent = `Rs. ${change.toFixed(2)}`;
                changeDisplay.classList.remove("negative");
                changeHidden.value = change.toFixed(2);
            } else {
                changeDisplay.textContent = `Rs. ${Math.abs(change).toFixed(2)} (Insufficient)`;
                changeDisplay.classList.add("negative");
                changeHidden.value = "0.00";
            }
        }

        function setExactAmount() {
            const grandTotal = parseFloat(document.getElementById("grandTotal").textContent || 0);
            document.getElementById("customerMoney").value = grandTotal.toFixed(2);
            calculateChange();
        }

        function addQuickAmount(amount) {
            const currentAmount = parseFloat(document.getElementById("customerMoney").value || 0);
            document.getElementById("customerMoney").value = (currentAmount + amount).toFixed(2);
            calculateChange();
        }

        // Item Management Functions
        function addItemRow() {
            const tableBody = document.getElementById("itemsTableBody");
            const row = document.createElement("tr");
            const currentIndex = rowIndex++;

            row.innerHTML = `
                <td>
                    <div class="item-autocomplete">
                        <input type="text" 
                               id="item_${currentIndex}" 
                               class="table-input"
                               placeholder="Search item..." 
                               required
                               autocomplete="off">
                        <input type="hidden" name="itemID" id="itemID_${currentIndex}">
                        <div class="item-suggestions" id="itemSuggestions_${currentIndex}"></div>
                        <div class="stock-warning" id="stockWarning_${currentIndex}"></div>
                    </div>
                </td>
                <td>
                    <input type="number" 
                           name="quantity" 
                           id="quantity_${currentIndex}" 
                           class="table-input"
                           min="1" 
                           value="1" 
                           oninput="updatePrice(${currentIndex})" 
                           required>
                </td>
                <td>
                    <input type="text" 
                           name="unitPrice" 
                           id="unitPrice_${currentIndex}" 
                           class="table-input"
                           readonly 
                           placeholder="0.00">
                </td>
                <td>
                    <input type="number" 
                           name="discount" 
                           id="discount_${currentIndex}" 
                           class="table-input"
                           min="0" 
                           max="100" 
                           value="0" 
                           oninput="updatePrice(${currentIndex})"
                           placeholder="0">
                </td>
                <td>
                    <input type="text" 
                           name="itemTotal" 
                           id="totalPrice_${currentIndex}" 
                           class="table-input"
                           readonly 
                           placeholder="0.00">
                </td>
                <td>
                    <button type="button" 
                            class="remove-row-btn" 
                            onclick="removeItemRow(this)"
                            title="Remove this item">
                        🗑️
                    </button>
                </td>
            `;

            tableBody.appendChild(row);

            // Setup autocomplete for the new row
            setupAutocomplete(
                document.getElementById(`item_${currentIndex}`), 
                items, 
                (selected) => {
                    document.getElementById(`itemID_${currentIndex}`).value = selected.id;
                    updatePrice(currentIndex);
                },
                `itemSuggestions_${currentIndex}`
            );

            calculateOrderSummary();
        }

        function removeItemRow(button) {
            if (document.getElementById("itemsTableBody").children.length > 1) {
                button.closest('tr').remove();
                calculateOrderSummary();
            } else {
                alert("At least one item is required for the order.");
            }
        }

        function clearAllItems() {
            if (confirm("Are you sure you want to clear all items?")) {
                document.getElementById("itemsTableBody").innerHTML = "";
                rowIndex = 0;
                addItemRow();
                calculateOrderSummary();
            }
        }

        // Customer Functions
        function selectCustomer(customer) {
            document.getElementById("customerID").value = customer.id;
            document.getElementById("custName").textContent = customer.name;
            document.getElementById("custPhone").textContent = customer.phone;
            document.getElementById("custEmail").textContent = customer.email;
            document.getElementById("custAddress").textContent = customer.address;
            document.getElementById("customerInfo").classList.add("show");
            
            // Remove error state
            document.getElementById("customerSearch").classList.remove("error");
            document.getElementById("customerError").classList.remove("show");
        }

        // Form Validation
        function validateForm() {
            let isValid = true;
            
            // Validate customer selection
            const customerID = document.getElementById("customerID").value;
            const customerInput = document.getElementById("customerSearch");
            const customerError = document.getElementById("customerError");
            
            if (!customerID) {
                customerInput.classList.add("error");
                customerError.classList.add("show");
                isValid = false;
            } else {
                customerInput.classList.remove("error");
                customerError.classList.remove("show");
            }
            
            // Validate items and stock
            const itemRows = document.querySelectorAll("#itemsTableBody tr");
            let hasValidItems = false;
            
            itemRows.forEach(row => {
                const itemID = row.querySelector("input[name='itemID']").value;
                const quantity = parseInt(row.querySelector("input[name='quantity']").value || 0);
                
                if (itemID && quantity > 0) {
                    // Check stock availability
                    if (itemData[itemID] && itemData[itemID].quantity < quantity) {
                        alert(`Insufficient stock for selected item. Only ${itemData[itemID].quantity} items available.`);
                        isValid = false;
                        return;
                    }
                    hasValidItems = true;
                }
            });
            
            if (!hasValidItems) {
                alert("Please add at least one valid item to the order.");
                isValid = false;
            }
            
            return isValid;
        }

        // Bill Preview Function
        function previewBill() {
            if (!validateForm()) {
                return;
            }
            
            const formData = {
                customerID: document.getElementById("customerID").value,
                customerName: document.getElementById("custName").textContent,
                customerPhone: document.getElementById("custPhone").textContent,
                customerEmail: document.getElementById("custEmail").textContent,
                customerAddress: document.getElementById("custAddress").textContent,
                customerMoney: document.getElementById("customerMoney").value || "0.00",
                changeGiven: document.getElementById("changeGiven").value || "0.00",
                items: [],
                orderSummary: {
                    totalItems: document.getElementById("totalItems").textContent,
                    subtotal: document.getElementById("subtotal").textContent,
                    totalDiscount: document.getElementById("totalDiscount").textContent,
                    grandTotal: document.getElementById("grandTotal").textContent
                }
            };
            
            document.querySelectorAll("#itemsTableBody tr").forEach(row => {
                const itemID = row.querySelector("input[name='itemID']").value;
                const itemName = row.querySelector("input[type='text']").value;
                const quantity = row.querySelector("input[name='quantity']").value;
                const unitPrice = row.querySelector("input[name='unitPrice']").value;
                const discount = row.querySelector("input[name='discount']").value;
                const total = row.querySelector("input[name='itemTotal']").value;
                
                if (itemID && quantity) {
                    formData.items.push({
                        itemID,
                        itemName,
                        quantity,
                        unitPrice,
                        discount,
                        total
                    });
                }
            });
            
            sessionStorage.setItem('billPreviewData', JSON.stringify(formData));
            window.open('bill.jsp?preview=true', '_blank', 'width=800,height=600,scrollbars=yes');
        }

        // Loading Functions
        function showLoading(show) {
            const loading = document.getElementById('loadingIndicator');
            const submitBtn = document.getElementById('submitBtn');
            const submitSpinner = document.getElementById('submitSpinner');
            
            if (show) {
                loading.style.display = 'block';
                submitBtn.disabled = true;
                submitSpinner.style.display = 'inline-block';
                submitBtn.innerHTML = '<span class="spinner"></span> Processing...';
            } else {
                loading.style.display = 'none';
                submitBtn.disabled = false;
                submitSpinner.style.display = 'none';
                submitBtn.innerHTML = '✅ Create Order & Generate Bill';
            }
        }

        // Initialize the form
        window.onload = () => {
            // Customer search autocomplete
            setupAutocomplete(
                document.getElementById("customerSearch"), 
                customers, 
                selectCustomer,
                "customerSuggestions"
            );

            // Add first item row
            addItemRow();

            // Form submission
            document.getElementById("orderForm").addEventListener("submit", function(e) {
                e.preventDefault();
                
                if (validateForm()) {
                    orderSubmitted = true;
                    showLoading(true);
                    
                    setTimeout(() => {
                        this.submit();
                    }, 1000);
                }
            });

            setInterval(() => {
                if (formChanged && !orderSubmitted) {
                    console.log("Auto-saving form data...");
                }
            }, 30000);
        };

        // Keyboard shortcuts
        document.addEventListener('keydown', function(e) {
            if (e.ctrlKey && e.key === 'Enter') {
                e.preventDefault();
                document.getElementById("orderForm").dispatchEvent(new Event('submit'));
            }
            
            if (e.ctrlKey && e.key === 'i') {
                e.preventDefault();
                addItemRow();
            }
            
            if (e.ctrlKey && e.key === 'p') {
                e.preventDefault();
                previewBill();
            }
            
            if (e.key === 'Escape') {
                if (confirm('Are you sure you want to cancel? All unsaved data will be lost.')) {
                    window.location.href = 'dashboard.jsp';
                }
            }
        });

        document.addEventListener('keydown', function(e) {
            if (e.key === 'Enter' && e.target.tagName === 'INPUT' && e.target.type !== 'submit') {
                e.preventDefault();
            }
        });

        document.addEventListener('input', function() {
            if (!orderSubmitted) {
                formChanged = true;
            }
        });

        window.addEventListener('beforeunload', function(e) {
            if (formChanged && !orderSubmitted) {
                e.preventDefault();
                e.returnValue = 'You have unsaved changes. Are you sure you want to leave?';
                return 'You have unsaved changes. Are you sure you want to leave?';
            }
        });

        document.getElementById("customerSearch").addEventListener('blur', function() {
            const customerID = document.getElementById("customerID").value;
            if (!customerID && this.value) {
                this.classList.add("error");
                document.getElementById("customerError").classList.add("show");
            }
        });
        function calculateChange() {
            let given = parseFloat(document.getElementById('customerMoney').value) || 0;
            let totalText = document.getElementById('paymentTotal').textContent.replace('Rs.', '').trim();
            let total = parseFloat(totalText) || 0;

            let change = given - total;
            if (change < 0) change = 0; // No negative change

            // Update visible change display
            document.getElementById('changeAmount').textContent = 'Rs. ' + change.toFixed(2);

            // Update hidden fields for form submission
            document.getElementById('givenMoney').value = given.toFixed(2);
            document.getElementById('changeGiven').value = change.toFixed(2);
        }

        // Quick action helpers
        function setExactAmount() {
            let totalText = document.getElementById('paymentTotal').textContent.replace('Rs.', '').trim();
            let total = parseFloat(totalText) || 0;
            document.getElementById('customerMoney').value = total.toFixed(2);
            calculateChange();
        }

        function addQuickAmount(amount) {
            let current = parseFloat(document.getElementById('customerMoney').value) || 0;
            document.getElementById('customerMoney').value = (current + amount).toFixed(2);
            calculateChange();
        }
    </script>
</body>
</html>