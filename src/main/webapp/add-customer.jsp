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
    <title>Add Customer - Pahana Edu</title>
    <style>
    /* Reset and Base Styles */
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
    line-height: 1.6;
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
    color: #ffffff; 
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
                                    margin-bottom:25px;
            
        }
}

/* Alert Messages */
.alert {
    padding: 16px 20px;
    border-radius: 8px;
    margin-bottom: 24px;
    font-size: 14px;
    font-weight: 500;
    display: flex;
    align-items: center;
    gap: 12px;
}

.alert-error {
    background: rgba(220, 53, 69, 0.1);
    color: #dc3545;
    border: 1px solid rgba(220, 53, 69, 0.2);
    border-left: 4px solid #dc3545;
}

.alert-success {
    background: rgba(40, 167, 69, 0.1);
    color: #28a745;
    border: 1px solid rgba(40, 167, 69, 0.2);
    border-left: 4px solid #28a745;
}

/* Form Container */
.form-container {
    background: white;
    border-radius: 12px;
    padding: 32px;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
    border-top: 4px solid #5F9EA0;
}

/* Form Styling */
.form-row {
    display: flex;
    gap: 8px;
    margin-bottom: 24px;
}

.form-group {
    flex: 1;
    position: relative;
}

.form-group.full-width {
    width: 100%;
}

.form-label {
    display: block;
    margin-bottom: 8px;
    font-weight: 600;
    color: #2C3E50;
    font-size: 14px;
    display: flex;
    align-items: center;
    gap: 8px;
}

.form-label .required {
    color: #dc3545;
    font-size: 16px;
}

.form-input {
    width: 100%;
    padding: 14px 16px;
    border: 2px solid #e0e6ed;
    border-radius: 8px;
    background: white;
    color: #333333;
    font-size: 15px;
    transition: all 0.3s ease;
    font-family: inherit;
}

.form-input:focus {
    outline: none;
    border-color: #5F9EA0;
    box-shadow: 0 0 0 3px rgba(95, 158, 160, 0.1);
    transform: translateY(-1px);
}

.form-input::placeholder {
    color: #999;
    font-style: italic;
}

.form-input:invalid:not(:placeholder-shown) {
    border-color: #dc3545;
}

.form-input:valid:not(:placeholder-shown) {
    border-color: #28a745;
}

/* Textarea specific */
.form-textarea {
    resize: vertical;
    min-height: 65px;
    max-height: 110px;
}

/* Input Groups */
.input-group {
    position: relative;
}

.input-icon {
    position: absolute;
    left: 12px;
    top: 50%;
    transform: translateY(-50%);
    color: #999;
    font-size: 16px;
    z-index: 1;
}

.input-group .form-input {
    padding-left: 40px;
}

/* Age Input Styling */
.age-input {
    max-width: 120px;
}

/* Phone Input Styling */
.phone-input {
    font-family: 'Courier New', monospace;
}

/* Form Actions */
.form-actions {
    display: flex;
    gap: 16px;
    justify-content: flex-end;
    align-items: center;
    padding-top: 24px;
    border-top: 2px solid #f0f0f0;
    margin-top: 32px;
}

.btn {
    padding: 14px 24px;
    border: none;
    border-radius: 8px;
    font-size: 15px;
    font-weight: 600;
    cursor: pointer;
    text-decoration: none;
    display: inline-flex;
    align-items: center;
    gap: 8px;
    transition: all 0.3s ease;
    min-width: 140px;
    justify-content: center;
}

.btn-primary {
    background: linear-gradient(135deg, #E67E22 0%, rgba(230, 126, 34, 0.9) 100%);
    color: white;
    box-shadow: 0 2px 8px rgba(230, 126, 34, 0.2);
}

.btn-primary:hover {
    transform: translateY(-2px);
    box-shadow: 0 6px 20px rgba(230, 126, 34, 0.3);
}

.btn-primary:active {
    transform: translateY(0);
}

.btn-secondary {
    background: #6c757d;
    color: white;
}

.btn-secondary:hover {
    background: #5a6268;
    transform: translateY(-1px);
}

.btn-outline {
    background: transparent;
    color: #5F9EA0;
    border: 2px solid #5F9EA0;
}

.btn-outline:hover {
    background: #5F9EA0;
    color: white;
    transform: translateY(-1px);
}

/* Back Link */
.back-link {
    display: inline-flex;
    align-items: center;
    gap: 8px;
    color: #5F9EA0;
    text-decoration: none;
    font-weight: 500;
    margin-bottom: 24px;
    padding: 8px 0;
    transition: all 0.3s ease;
}

.back-link:hover {
    color: #4a7c7e;
    transform: translateX(-4px);
}

/* Form Validation Messages */
.validation-message {
    position: absolute;
    bottom: -20px;
    left: 0;
    font-size: 12px;
    color: #dc3545;
    display: none;
}

.form-group.error .validation-message {
    display: block;
}

.form-group.error .form-input {
    border-color: #dc3545;
    box-shadow: 0 0 0 3px rgba(220, 53, 69, 0.1);
}

/* Loading State */
.btn-loading {
    position: relative;
    color: transparent;
}

.btn-loading::after {
    content: "";
    position: absolute;
    width: 20px;
    height: 20px;
    top: 50%;
    left: 50%;
    margin-left: -10px;
    margin-top: -10px;
    border: 2px solid transparent;
    border-top-color: currentColor;
    border-radius: 50%;
    animation: spin 1s linear infinite;
}

@keyframes spin {
    0% { transform: rotate(0deg); }
    100% { transform: rotate(360deg); }
}

/* Success State */
.form-success {
    text-align: center;
    padding: 48px;
    background: white;
    border-radius: 12px;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
}

.success-icon {
    font-size: 64px;
    color: #28a745;
    margin-bottom: 16px;
}

.success-title {
    font-size: 24px;
    font-weight: 700;
    color: #2C3E50;
    margin-bottom: 8px;
}

.success-message {
    color: #5F9EA0;
    margin-bottom: 24px;
}

/* Form Tips */
.form-tips {
    background: rgba(95, 158, 160, 0.05);
    border: 1px solid rgba(95, 158, 160, 0.2);
    border-left: 4px solid #5F9EA0;
    border-radius: 8px;
    padding: 16px;
    margin-bottom: 24px;
}

.form-tips h4 {
    color: #2C3E50;
    margin-bottom: 8px;
    font-size: 14px;
    font-weight: 600;
}

.form-tips ul {
    margin: 0;
    padding-left: 20px;
    color: #666;
    font-size: 13px;
}

.form-tips li {
    margin-bottom: 4px;
}

/* Character Counter */
.char-counter {
    position: absolute;
    bottom: -18px;
    right: 0;
    font-size: 11px;
    color: #999;
}

.char-counter.warning {
    color: #E67E22;
}

.char-counter.danger {
    color: #dc3545;
}

/* Responsive Design */
@media (max-width: 768px) {
    .container {
        padding: 16px;
    }
    
    .form-container {
        padding: 24px 20px;
    }
    
    .form-row {
        flex-direction: column;
        gap: 0;
    }
    
    .form-actions {
        flex-direction: column-reverse;
        gap: 12px;
    }
    
    .btn {
        width: 100%;
    }
    
    .page-title {
        font-size: 24px;
    }
    
    .navbar {
        padding: 12px 16px;
    }
}

@media (max-width: 480px) {
    .form-container {
        padding: 20px 16px;
    }
    
    .page-header {
        padding: 20px;
    }
}

/* Focus Management */
.form-input:focus + .validation-message {
    display: none;
}

/* Dark Mode Support (Optional) */
@media (prefers-color-scheme: dark) {
    :root {
        --bg-color: #1a1a1a;
        --text-color: #e0e0e0;
        --card-bg: #2d2d2d;
    }
}

/* Print Styles */
@media print {
    .navbar,
    .form-actions,
    .back-link {
        display: none;
    }
    
    .container {
        max-width: none;
        padding: 0;
    }
    
    .form-container {
        box-shadow: none;
        border: 1px solid #ccc;
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
        <!-- Back Link -->
        

        <!-- Page Header -->
        <div class="page-header">
            <h1 class="page-title">
                ➕ Add New Customer
            </h1>
            <p class="page-subtitle">Enter customer information to add them to your system</p>
        </div>

        <!-- Error Message Alert -->
        <% if (request.getAttribute("errorMessage") != null) { %>
            <div class="alert alert-error">
                ⚠️ <%= request.getAttribute("errorMessage") %>
            </div>
        <% } %>

        <!-- Success Message Alert -->
        <% if (request.getAttribute("successMessage") != null) { %>
            <div class="alert alert-success">
                ✅ <%= request.getAttribute("successMessage") %>
            </div>
        <% } %>

        

        <!-- Form Container -->
        <div class="form-container">
            <form action="add-customer" method="post" id="customerForm" novalidate>
                <!-- Name and Age Row -->
                <div class="form-row">
                    <div class="form-group">
                        <label for="name" class="form-label">
                            👤 Full Name <span class="required">*</span>
                        </label>
                        <div class="input-group">
                            <span class="input-icon">👤</span>
                            <input type="text" 
                                   id="name" 
                                   name="name" 
                                   class="form-input" 
                                   placeholder="Enter customer's full name"
                                   required
                                   maxlength="100"
                                   pattern="[A-Za-z\s]{2,100}"
                                   title="Name should contain only letters and spaces (2-100 characters)">
                        </div>
                        <div class="validation-message">Please enter a valid name (2-100 characters, letters only)</div>
                        <div class="char-counter">0/100</div>
                    </div>
                    
                    <div class="form-group">
                        <label for="age" class="form-label">
                            🎂 Age <span class="required">*</span>
                        </label>
                        <div class="input-group">
                            <span class="input-icon">🎂</span>
                            <input type="number" 
                                   id="age" 
                                   name="age" 
                                   class="form-input age-input" 
                                   placeholder="Age"
                                   required
                                   min="1"
                                   max="120"
                                   title="Age must be between 1 and 120">
                        </div>
                        <div class="validation-message">Please enter a valid age (1-120)</div>
                    </div>
                </div>

                <!-- Address Row -->
                <div class="form-row">
                    <div class="form-group full-width">
                        <label for="address" class="form-label">
                            🏠 Address <span class="required">*</span>
                        </label>
                        <div class="input-group">
                            <span class="input-icon">🏠</span>
                            <textarea id="address" 
                                      name="address" 
                                      class="form-input form-textarea" 
                                      placeholder="Enter complete address with city"
                                      required
                                      maxlength="500"
                                      rows="1"></textarea>
                        </div>
                        <div class="validation-message">Please enter a complete address</div>
                        <div class="char-counter">0/500</div>
                    </div>
                </div>

                <!-- Contact Information Row -->
                <div class="form-row">
                    <div class="form-group">
                        <label for="telephone" class="form-label">
                            📞 Phone Number <span class="required">*</span>
                        </label>
                        <div class="input-group">
                            <span class="input-icon">📞</span>
                            <input type="tel" 
                                   id="telephone" 
                                   name="telephone" 
                                   class="form-input phone-input" 
                                   placeholder="+94 XX XXX XXX"
                                   required
                                   pattern="[\+]?[0-9\s\-\(\)]{9,15}"
                                   title="Please enter a valid phone number">
                        </div>
                        <div class="validation-message">Please enter a valid phone number</div>
                    </div>
                    
                    <div class="form-group">
                        <label for="email" class="form-label">
                            📧 Email Address <span class="required">*</span>
                        </label>
                        <div class="input-group">
                            <span class="input-icon">📧</span>
                            <input type="email" 
                                   id="email" 
                                   name="email" 
                                   class="form-input" 
                                   placeholder="customer@example.com"
                                   required
                                   maxlength="100"
                                   title="Please enter a valid email address">
                        </div>
                        <div class="validation-message">Please enter a valid email address</div>
                        <div class="char-counter">0/100</div>
                    </div>
                </div>

                <!-- Form Actions -->
                <div class="form-actions">
                    <a href="view-customers.jsp" class="btn btn-outline">
                        👥 View All Customers
                    </a>
                    <button type="reset" class="btn btn-secondary" onclick="resetForm()">
                        🔄 Reset Form
                    </button>
                    <button type="submit" class="btn btn-primary" id="submitBtn">
                        ➕ Add Customer
                    </button>
                </div>
            </form>
        </div>
    </div>
   
    <script>
        // Form validation and enhancement
        document.addEventListener('DOMContentLoaded', function() {
            const form = document.getElementById('customerForm');
            const submitBtn = document.getElementById('submitBtn');
            const inputs = form.querySelectorAll('.form-input');
            
            // Character counters
            inputs.forEach(input => {
                if (input.hasAttribute('maxlength')) {
                    const counter = input.parentElement.parentElement.querySelector('.char-counter');
                    if (counter) {
                        input.addEventListener('input', function() {
                            const current = this.value.length;
                            const max = this.getAttribute('maxlength');
                            counter.textContent = `${current}/${max}`;
                            
                            if (current > max * 0.8) {
                                counter.classList.add('warning');
                            } else {
                                counter.classList.remove('warning');
                            }
                            
                            if (current === parseInt(max)) {
                                counter.classList.add('danger');
                            } else {
                                counter.classList.remove('danger');
                            }
                        });
                    }
                }
            });

            // Real-time validation
            inputs.forEach(input => {
                input.addEventListener('blur', function() {
                    validateField(this);
                });
                
                input.addEventListener('input', function() {
                    if (this.classList.contains('error')) {
                        validateField(this);
                    }
                });
            });

            // Form submission
            form.addEventListener('submit', function(e) {
                e.preventDefault();
                
                let isValid = true;
                inputs.forEach(input => {
                    if (!validateField(input)) {
                        isValid = false;
                    }
                });
                
                if (isValid) {
                    submitBtn.classList.add('btn-loading');
                    submitBtn.disabled = true;
                    
                    // Simulate loading delay (remove in production)
                    setTimeout(() => {
                        form.submit();
                    }, 500);
                } else {
                    // Focus on first invalid field
                    const firstInvalid = form.querySelector('.form-group.error .form-input');
                    if (firstInvalid) {
                        firstInvalid.focus();
                    }
                }
            });

            // Phone number formatting
            const phoneInput = document.getElementById('telephone');
            phoneInput.addEventListener('input', function() {
                let value = this.value.replace(/\D/g, '');
                if (value.startsWith('94')) {
                    value = '+' + value;
                } else if (value.startsWith('0')) {
                    value = '+94' + value.substring(1);
                }
                // Format: +94 77 123 4567
                if (value.length > 3) {
                    value = value.replace(/(\+94)(\d{2})(\d{3})(\d{4})/, '$1 $2 $3 $4');
                }
                this.value = value;
            });

            // Age validation with helpful messages
            const ageInput = document.getElementById('age');
            ageInput.addEventListener('input', function() {
                const age = parseInt(this.value);
                const validationMsg = this.parentElement.parentElement.querySelector('.validation-message');
                
                if (age < 13) {
                    validationMsg.textContent = 'Note: Customers under 13 may need parental consent';
                } else if (age > 65) {
                    validationMsg.textContent = 'Note: Senior citizen - consider offering special discounts';
                } else {
                    validationMsg.textContent = 'Please enter a valid age (1-120)';
                }
            });

            // Email domain suggestions
            const emailInput = document.getElementById('email');
            const commonDomains = ['gmail.com', 'yahoo.com', 'hotmail.com', 'outlook.com'];
            
            emailInput.addEventListener('blur', function() {
                const email = this.value;
                if (email.includes('@') && !email.includes('.')) {
                    const parts = email.split('@');
                    if (parts.length === 2) {
                        const suggestion = commonDomains.find(domain => 
                            domain.startsWith(parts[1].toLowerCase())
                        );
                        if (suggestion) {
                            if (confirm(`Did you mean: ${parts[0]}@${suggestion}?`)) {
                                this.value = `${parts[0]}@${suggestion}`;
                            }
                        }
                    }
                }
            });
        });

        // Field validation function
        function validateField(field) {
            const formGroup = field.closest('.form-group');
            const isValid = field.checkValidity() && field.value.trim() !== '';
            
            if (isValid) {
                formGroup.classList.remove('error');
                return true;
            } else {
                formGroup.classList.add('error');
                return false;
            }
        }

        // Reset form function
        function resetForm() {
            const form = document.getElementById('customerForm');
            const formGroups = form.querySelectorAll('.form-group');
            const counters = form.querySelectorAll('.char-counter');
            
            // Reset form
            form.reset();
            
            // Clear validation states
            formGroups.forEach(group => {
                group.classList.remove('error');
            });
            
            // Reset counters
            counters.forEach(counter => {
                const maxLength = counter.textContent.split('/')[1];
                counter.textContent = `0/${maxLength}`;
                counter.classList.remove('warning', 'danger');
            });
            
            // Focus on first input
            document.getElementById('name').focus();
        }

        // Keyboard shortcuts
        document.addEventListener('keydown', function(e) {
            // Ctrl+Enter to submit
            if (e.ctrlKey && e.key === 'Enter') {
                e.preventDefault();
                document.getElementById('submitBtn').click();
            }
            
            // Escape to reset
            if (e.key === 'Escape') {
                if (confirm('Reset the form? All entered data will be lost.')) {
                    resetForm();
                }
            }
        });

      
    </script>
</body>
</html>