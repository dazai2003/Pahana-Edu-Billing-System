<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.pahanaedu.model.User" %>
<%
User user = (User) session.getAttribute("loggedUser");
if (user == null) {
    response.sendRedirect("login.jsp");
    return;
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Help & Support - Pahana Edu Billing System</title>
    <meta name="description" content="Comprehensive help and support for Pahana Edu Billing System users">
    
   <style>
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }

    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background: #F5F5F5;
        min-height: 100vh;
        color: #333333;
        line-height: 1.6;
    }
    
    .navbar {
    display: flex;
    justify-content: space-between;
    align-items: center;
    background-color: #2C3E50; /* adjust as neede.d */
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
    

    /* Navigation Bar */
    .navbar {
        background: #2C3E50;
        color: white;
        padding: 1rem 2rem;
        display: flex;
        justify-content: space-between;
        align-items: center;
        box-shadow: 0 2px 20px rgba(0, 0, 0, 0.1);
        position: sticky;
        top: 0;
        z-index: 100;
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

    .logo {
        font-size: 1.5rem;
        font-weight: bold;
        color: white;
        display: flex;
        align-items: center;
        gap: 0.5rem;
    }

    .user-info {
        display: flex;
        align-items: center;
        gap: 1rem;
        font-size: 0.9rem;
        color: white;
    }

    .logout-btn {
        background: #E67E22;
        color: white;
        border: none;
        padding: 0.5rem 1rem;
        border-radius: 20px;
        cursor: pointer;
        font-size: 0.85rem;
        transition: all 0.3s ease;
    }

    .logout-btn:hover {
        background: #cf6514;
        transform: translateY(-1px);
    }

    /* Main Container */
    .container {
        max-width: 1200px;
        margin: 0 auto;
        padding: 2rem;
    }

    /* Back Button */
    .back-btn {
        display: inline-flex;
        align-items: center;
        gap: 0.5rem;
        background: #5F9EA0;
        color: white;
        text-decoration: none;
        padding: 0.75rem 1.5rem;
        border-radius: 25px;
        font-weight: 500;
        transition: all 0.3s ease;
        margin-bottom: 2rem;
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
    }

    .back-btn:hover {
        background: #4b8284;
        transform: translateY(-2px);
        box-shadow: 0 6px 20px rgba(0, 0, 0, 0.15);
    }

    /* Header Section */
    .header {
        text-align: center;
        margin-bottom: 3rem;
        background: white;
        padding: 3rem 2rem;
        border-radius: 20px;
        box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
    }

    .page-title {
        font-size: 3rem;
        font-weight: 700;
        color: #2C3E50;
        margin-bottom: 1rem;
    }

    .page-subtitle {
        font-size: 1.2rem;
        color: #555;
        max-width: 600px;
        margin: 0 auto;
    }

    /* Content Grid */
    .content-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
        gap: 2rem;
        margin-bottom: 3rem;
    }

    /* Card Styles */
    .card {
        background: white;
        border-radius: 20px;
        padding: 2rem;
        box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
        transition: all 0.3s ease;
        border: 1px solid rgba(0, 0, 0, 0.05);
    }

    .card:hover {
        transform: translateY(-5px);
        box-shadow: 0 15px 40px rgba(0, 0, 0, 0.15);
    }

    .card-title {
        font-size: 1.5rem;
        font-weight: 600;
        color: #333333;
        margin-bottom: 1.5rem;
        display: flex;
        align-items: center;
        gap: 0.75rem;
    }

    .card-icon {
        font-size: 1.75rem;
        color: #5F9EA0;
    }

    /* Quick Actions */
    .quick-actions {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
        gap: 1rem;
    }

    .action-item {
        display: flex;
        align-items: center;
        gap: 1rem;
        padding: 1rem;
        background: rgba(95, 158, 160, 0.1);
        border-radius: 12px;
        text-decoration: none;
        color: #333333;
        transition: all 0.3s ease;
        border: 1px solid rgba(95, 158, 160, 0.2);
    }

    .action-item:hover {
        background: rgba(95, 158, 160, 0.2);
        transform: translateX(5px);
    }

    .action-icon {
        font-size: 1.5rem;
        min-width: 40px;
        text-align: center;
    }

    .action-text {
        flex: 1;
    }

    .action-title {
        font-weight: 600;
        color: #5F9EA0;
        margin-bottom: 0.25rem;
    }

    .action-desc {
        font-size: 0.9rem;
        color: #666;
    }

    /* FAQ Section */
    .faq-container {
        background: white;
        border-radius: 20px;
        padding: 2rem;
        box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
        margin-bottom: 2rem;
    }

    .faq-item {
        border-bottom: 1px solid rgba(95, 158, 160, 0.1);
        margin-bottom: 1rem;
        padding-bottom: 1rem;
    }

    .faq-item:last-child {
        border-bottom: none;
        margin-bottom: 0;
    }

    .faq-question {
        font-weight: 600;
        color: #333333;
        cursor: pointer;
        padding: 1rem;
        background: rgba(95, 158, 160, 0.05);
        border-radius: 10px;
        transition: all 0.3s ease;
        display: flex;
        justify-content: space-between;
        align-items: center;
        user-select: none;
    }

    .faq-question:hover {
        background: rgba(95, 158, 160, 0.1);
    }

    .faq-question.active {
        background: rgba(95, 158, 160, 0.15);
        color: #5F9EA0;
    }

    .faq-toggle {
        font-size: 1.2rem;
        transition: transform 0.3s ease;
    }

    .faq-question.active .faq-toggle {
        transform: rotate(180deg);
    }

    .faq-answer {
        display: none;
        padding: 1rem;
        color: #666;
        background: rgba(0, 0, 0, 0.02);
        border-radius: 0 0 10px 10px;
        margin-top: 0.5rem;
    }

    /* Contact Section */
    .contact-section {
        background: #8BA88E;
        color: white;
        border-radius: 20px;
        padding: 3rem 2rem;
        text-align: center;
        box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
    }

    .contact-title {
        font-size: 2rem;
        font-weight: 600;
        margin-bottom: 1rem;
    }

    .contact-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
        gap: 2rem;
        margin-top: 2rem;
    }

    .contact-item {
        background: rgba(255, 255, 255, 0.1);
        backdrop-filter: blur(10px);
        padding: 1.5rem;
        border-radius: 15px;
        border: 1px solid rgba(255, 255, 255, 0.2);
    }

    .contact-icon {
        font-size: 2rem;
        margin-bottom: 1rem;
    }

    .contact-label {
        font-weight: 600;
        margin-bottom: 0.5rem;
    }

    .contact-info {
        color: rgba(255, 255, 255, 0.9);
    }

    .contact-info a {
        color: white;
        text-decoration: none;
        transition: opacity 0.3s ease;
    }

    .contact-info a:hover {
        opacity: 0.8;
    }

    /* Search Functionality */
    .search-container {
        margin-bottom: 2rem;
        position: relative;
    }

    .search-input {
        width: 100%;
        padding: 1rem 1rem 1rem 3rem;
        border: none;
        border-radius: 25px;
        font-size: 1rem;
        background: white;
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        transition: all 0.3s ease;
    }

    .search-input:focus {
        outline: none;
        background: white;
        box-shadow: 0 6px 20px rgba(0, 0, 0, 0.15);
    }

    .search-icon {
        position: absolute;
        left: 1rem;
        top: 50%;
        transform: translateY(-50%);
        color: #666;
        font-size: 1.1rem;
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
        
        

        <!-- Header Section -->
        <header class="header">
            <h1 class="page-title">Help & Support Center</h1>
            <p class="page-subtitle">
                Your comprehensive guide to using the Pahana Edu Billing System effectively. 
                Find tutorials, troubleshooting guides, and get the support you need.
            </p>
        </header>

        <!-- Search Functionality -->
        <div class="search-container">
            <input type="text" class="search-input" id="helpSearch" placeholder="Search help topics, features, or FAQs..." aria-label="Search help content">
            <span class="search-icon">🔍</span>
        </div>

        <!-- Content Grid -->
        <div class="content-grid">
            <!-- Quick Start Guide -->
            <section class="card">
                <h2 class="card-title">
                    <span class="card-icon">🚀</span>
                    Quick Start Guide
                </h2>
                <div class="quick-actions">
                    <a href="add-customer.jsp" class="action-item" tabindex="0">
                        <div class="action-icon">👥</div>
                        <div class="action-text">
                            <div class="action-title">Add New Customer</div>
                            <div class="action-desc">Register customers before creating orders</div>
                        </div>
                    </a>
                    <a href="add-item.jsp" class="action-item" tabindex="0">
                        <div class="action-icon">📦</div>
                        <div class="action-text">
                            <div class="action-title">Add Inventory Items</div>
                            <div class="action-desc">Manage your products and stock levels</div>
                        </div>
                    </a>
                    <a href="order-form.jsp" class="action-item" tabindex="0">
                        <div class="action-icon">🛒</div>
                        <div class="action-text">
                            <div class="action-title">Create New Order</div>
                            <div class="action-desc">Process sales and generate invoices</div>
                        </div>
                    </a>
                    <a href="OrderHistoryServlet" class="action-item" tabindex="0">
                        <div class="action-icon">📊</div>
                        <div class="action-text">
                            <div class="action-title">View Reports</div>
                            <div class="action-desc">Analyze sales and track performance</div>
                        </div>
                    </a>
                    
                </div>
            </section>

            <!-- System Features -->
            <section class="card">
                <h2 class="card-title">
                    <span class="card-icon">⚙️</span>
                    System Features
                </h2>
                <div class="quick-actions">
                    <a href="view-customers.jsp" class="action-item" tabindex="0">
                        <div class="action-icon">👨‍👩‍👧‍👦</div>
                        <div class="action-text">
                            <div class="action-title">Customer Management</div>
                            <div class="action-desc">View, edit, and manage customer profiles</div>
                        </div>
                    </a>
                    <a href="view-items.jsp" class="action-item" tabindex="0">
                        <div class="action-icon">📋</div>
                        <div class="action-text">
                            <div class="action-title">Inventory Control</div>
                            <div class="action-desc">Track stock, update prices, manage products</div>
                        </div>
                    </a>
                    <a href="#billing" class="action-item" tabindex="0">
                        <div class="action-icon">💰</div>
                        <div class="action-text">
                            <div class="action-title">Billing & Invoicing</div>
                            <div class="action-desc">Generate bills, track payments, manage finances</div>
                        </div>
                    </a>
                    <a href="#reports" class="action-item" tabindex="0">
                        <div class="action-icon">📈</div>
                        <div class="action-text">
                            <div class="action-title">Analytics & Reports</div>
                            <div class="action-desc">Business insights and performance metrics</div>
                        </div>
                    </a>
                </div>
            </section>
        </div>

        <!-- FAQ Section -->
        <section class="faq-container">
            <h2 class="card-title">
                <span class="card-icon">❓</span>
                Frequently Asked Questions
            </h2>
            
            <div class="faq-item">
                <div class="faq-question" tabindex="0" role="button" aria-expanded="false">
                    <span>How do I create a new order for a customer?</span>
                    <span class="faq-toggle">⌄</span>
                </div>
                <div class="faq-answer">
                    <p><strong>Step-by-step process:</strong></p>
                    <ol>
                        <li>Navigate to <strong>"Create New Order"</strong> from the dashboard</li>
                        <li>Select an existing customer from the dropdown menu</li>
                        <li>Choose items from your inventory by clicking "Add Item"</li>
                        <li>Set quantities for each selected item</li>
                        <li>Review the total amount and apply any discounts if needed</li>
                        <li>Click "Submit Order" to complete the transaction</li>
                    </ol>
                    <p><em>Note: The system automatically updates stock levels and generates an invoice.</em></p>
                </div>
            </div>

            <div class="faq-item">
                <div class="faq-question" tabindex="0" role="button" aria-expanded="false">
                    <span>How do I update inventory stock levels?</span>
                    <span class="faq-toggle">⌄</span>
                </div>
                <div class="faq-answer">
                    <p><strong>Two methods to update stock:</strong></p>
                    <ul>
                        <li><strong>Individual Updates:</strong> Go to "Manage Items" → Click "Edit" on any product → Adjust quantity → Save changes</li>
                        <li><strong>Bulk Updates:</strong> Use the bulk import feature to upload a CSV file with updated stock levels</li>
                    </ul>
                    <p><em>Stock levels are automatically reduced when orders are processed.</em></p>
                </div>
            </div>

            <div class="faq-item">
                <div class="faq-question" tabindex="0" role="button" aria-expanded="false">
                    <span>What should I do if I can't log into the system?</span>
                    <span class="faq-toggle">⌄</span>
                </div>
                <div class="faq-answer">
                    <p><strong>Troubleshooting login issues:</strong></p>
                    <ul>
                        <li>Verify your username and password are entered correctly</li>
                        <li>Check if Caps Lock is enabled</li>
                        <li>Clear your browser cache and cookies</li>
                        <li>Try accessing the system from a different browser</li>
                        <li>If the problem persists, contact your system administrator</li>
                    </ul>
                    <p><em>For password resets, only administrators can update user credentials.</em></p>
                </div>
            </div>

            <div class="faq-item">
                <div class="faq-question" tabindex="0" role="button" aria-expanded="false">
                    <span>How can I generate and view sales reports?</span>
                    <span class="faq-toggle">⌄</span>
                </div>
                <div class="faq-answer">
                    <p><strong>Accessing reports:</strong></p>
                    <ul>
                        <li>Go to "Order History" to view all transactions</li>
                        <li>Use date filters to narrow down specific time periods</li>
                        <li>Export data to Excel for advanced analysis</li>
                        <li>View customer-specific purchase history</li>
                        <li>Track inventory movement and stock levels</li>
                    </ul>
                    <p><em>Reports are updated in real-time as new orders are processed.</em></p>
                </div>
            </div>

            <div class="faq-item">
                <div class="faq-question" tabindex="0" role="button" aria-expanded="false">
                    <span>How do I handle returns or order modifications?</span>
                    <span class="faq-toggle">⌄</span>
                </div>
                <div class="faq-answer">
                    <p><strong>Processing returns and modifications:</strong></p>
                    <ul>
                        <li>Navigate to "Order History" and locate the specific order</li>
                        <li>Click "View Details" to see the complete order information</li>
                        <li>For returns: Create a negative quantity order to reverse the transaction</li>
                        <li>Stock levels will be automatically adjusted</li>
                        <li>Document the reason for return in the order notes</li>
                    </ul>
                    <p><em>Contact support for complex return scenarios or system-level adjustments.</em></p>
                </div>
            </div>
        </section>

        <!-- Contact Support Section -->
        <section class="contact-section">
            <h2 class="contact-title">Need Additional Help?</h2>
            <p>Our support team is here to assist you with any questions or technical issues.</p>
            
            <div class="contact-grid">
                <div class="contact-item">
                    <div class="contact-icon">👨‍💻</div>
                    <div class="contact-label">System Administrator</div>
                    <div class="contact-info">Vihanga Wimalaweera</div>
                </div>
                
                <div class="contact-item">
                    <div class="contact-icon">📧</div>
                    <div class="contact-label">Email Support</div>
                    <div class="contact-info">
                        <a href="mailto:support@pahanaedu.com">support@pahanaedu.com</a>
                    </div>
                </div>
                
                <div class="contact-item">
                    <div class="contact-icon">📞</div>
                    <div class="contact-label">Phone Support</div>
                    <div class="contact-info">
                        <a href="tel:+94720707267">+94 72 0707 267</a>
                    </div>
                </div>
                
                <div class="contact-item">
                    <div class="contact-icon">🕒</div>
                    <div class="contact-label">Support Hours</div>
                    <div class="contact-info">Mon-Fri: 9:00 AM - 6:00 PM<br>Emergency: 24/7</div>
                </div>
            </div>
        </section>
    </div>

    <script>
        // FAQ Accordion functionality
        document.querySelectorAll('.faq-question').forEach(question => {
            question.addEventListener('click', function() {
                const isActive = this.classList.contains('active');
                
                // Close all other FAQ items
                document.querySelectorAll('.faq-question').forEach(q => {
                    q.classList.remove('active');
                    q.setAttribute('aria-expanded', 'false');
                    const answer = q.nextElementSibling;
                    answer.style.display = 'none';
                });
                
                // Toggle current item
                if (!isActive) {
                    this.classList.add('active');
                    this.setAttribute('aria-expanded', 'true');
                    const answer = this.nextElementSibling;
                    answer.style.display = 'block';
                }
            });
            
            // Keyboard accessibility
            question.addEventListener('keydown', function(e) {
                if (e.key === 'Enter' || e.key === ' ') {
                    e.preventDefault();
                    this.click();
                }
            });
        });

        // Search functionality
        document.getElementById('helpSearch').addEventListener('input', function() {
            const searchTerm = this.value.toLowerCase();
            const faqItems = document.querySelectorAll('.faq-item');
            const actionItems = document.querySelectorAll('.action-item');
            
            // Search in FAQ items
            faqItems.forEach(item => {
                const question = item.querySelector('.faq-question').textContent.toLowerCase();
                const answer = item.querySelector('.faq-answer').textContent.toLowerCase();
                
                if (question.includes(searchTerm) || answer.includes(searchTerm) || searchTerm === '') {
                    item.style.display = 'block';
                } else {
                    item.style.display = 'none';
                }
            });
            
            // Search in action items
            actionItems.forEach(item => {
                const title = item.querySelector('.action-title').textContent.toLowerCase();
                const desc = item.querySelector('.action-desc').textContent.toLowerCase();
                
                if (title.includes(searchTerm) || desc.includes(searchTerm) || searchTerm === '') {
                    item.style.display = 'flex';
                } else {
                    item.style.display = 'none';
                }
            });
        });

        // Smooth scrolling for anchor links
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function (e) {
                e.preventDefault();
                const targetId = this.getAttribute('href');
                const targetElement = document.querySelector(targetId);
                if (targetElement) {
                    targetElement.scrollIntoView({
                        behavior: 'smooth',
                        block: 'start'
                    });
                }
            });
        });

        // Add loading state for external links
        document.querySelectorAll('a[href$=".jsp"], a[href*="Servlet"]').forEach(link => {
            link.addEventListener('click', function() {
                this.style.opacity = '0.7';
                this.style.pointerEvents = 'none';
                
                // Reset after 2 seconds in case navigation fails
                setTimeout(() => {
                    this.style.opacity = '1';
                    this.style.pointerEvents = 'auto';
                }, 2000);
            });
        });
    </script>
</body>
</html>