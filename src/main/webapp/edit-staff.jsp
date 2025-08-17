<%@ page import="com.pahanaedu.dao.StaffDAO, com.pahanaedu.model.Staff" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
int userID = Integer.parseInt(request.getParameter("userID"));
Staff staff = StaffDAO.getStaffByID(userID);
if (staff == null) {
    out.println("<h3>Staff not found</h3>");
    return;
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Staff - Staff Management</title>
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
    <!-- Navigation Bar -->
    <nav class="navbar">
        <div class="logo">
            👥 Staff Management
        </div>
        <div class="navbar-nav">
            <a href="dashboard.jsp" class="dashboard-btn">Dashboard</a>
        </div>
    </nav>

    <!-- Main Container -->
    <div class="container">
       

        <!-- Page Header -->
        <div class="page-header">
            <h1 class="page-title">
                ✏️ Edit Staff Member
            </h1>
            <p class="page-subtitle">Update staff member information and access level</p>
        </div>

        <!-- Form Container -->
        <div class="form-container">
            <!-- Form Tips -->
           

            <!-- Staff Edit Form -->
            <form action="EditStaffServlet" method="post" id="editStaffForm">
                <!-- Hidden Staff ID -->
                <input type="hidden" name="userID" value="<%= staff.getUserID() %>">

                <!-- Login Credentials Section -->
                <div style="background: rgba(95, 158, 160, 0.05); border: 1px solid rgba(95, 158, 160, 0.2); border-left: 4px solid #5F9EA0; border-radius: 8px; padding: 16px; margin-bottom: 24px;">
                    <h4 style="color: #2C3E50; margin-bottom: 16px; font-size: 16px; font-weight: 600;">🔐 Login Credentials</h4>
                    
                    <!-- First Row: Username and Role -->
                    <div class="form-row">
                        <div class="form-group">
                            <label for="username" class="form-label">
                                👤 Username <span class="required">*</span>
                            </label>
                            <div class="input-group">
                                <span class="input-icon">👤</span>
                                <input type="text" 
                                       id="username" 
                                       name="username" 
                                       class="form-input" 
                                       value="<%= staff.getUsername() %>"
                                       placeholder="Enter unique username"
                                       pattern="[a-zA-Z0-9_]{3,20}"
                                       title="Username should be 3-20 characters, letters, numbers, and underscores only"
                                       maxlength="20"
                                       required>
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label for="role" class="form-label">
                                🪪 Role <span class="required">*</span>
                            </label>
                            <div class="input-group">
                                <span class="input-icon">🪪</span>
                                <select id="role" 
                                        name="role" 
                                        class="form-input" 
                                        required>
                                    <option value="">Select Role</option>
                                    <option value="admin" <%= "admin".equals(staff.getRole()) ? "selected" : "" %>>Administrator</option>
                                    <option value="staff" <%= "staff".equals(staff.getRole()) ? "selected" : "" %>>Staff Member</option>
                                </select>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Personal Information Section -->
                <div style="background: rgba(139, 168, 142, 0.05); border: 1px solid rgba(139, 168, 142, 0.2); border-left: 4px solid #8BA88E; border-radius: 8px; padding: 16px; margin-bottom: 24px;">
                    <h4 style="color: #2C3E50; margin-bottom: 16px; font-size: 16px; font-weight: 600;">👤 Personal Information</h4>
                    
                    <!-- Second Row: Full Name and Birth Date -->
                    <div class="form-row">
                        <div class="form-group">
                            <label for="fullName" class="form-label">
                                📝 Full Name <span class="required">*</span>
                            </label>
                            <div class="input-group">
                                <span class="input-icon">📝</span>
                                <input type="text" 
                                       id="fullName" 
                                       name="fullName" 
                                       class="form-input" 
                                       value="<%= staff.getFullName() %>"
                                       placeholder="Enter full name"
                                       maxlength="100"
                                       required>
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label for="birthDate" class="form-label">
                                🎂 Birth Date
                            </label>
                            <div class="input-group">
                                <span class="input-icon">🎂</span>
                                <input type="date" 
                                       id="birthDate" 
                                       name="birthDate" 
                                       class="form-input"
                                       value="<%= staff.getBirthDate() != null ? staff.getBirthDate() : "" %>"
                                       max="2006-01-01">
                            </div>
                        </div>
                    </div>

                    <!-- Third Row: Email and Phone -->
                    <div class="form-row">
                        <div class="form-group">
                            <label for="email" class="form-label">
                                📧 Email Address
                            </label>
                            <div class="input-group">
                                <span class="input-icon">📧</span>
                                <input type="email" 
                                       id="email" 
                                       name="email" 
                                       class="form-input" 
                                       value="<%= staff.getEmail() != null ? staff.getEmail() : "" %>"
                                       placeholder="email@example.com"
                                       maxlength="100">
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label for="phone" class="form-label">
                                📞 Phone Number
                            </label>
                            <div class="input-group">
                                <span class="input-icon">📞</span>
                                <input type="tel" 
                                       id="phone" 
                                       name="phone" 
                                       class="form-input phone-input" 
                                       value="<%= staff.getPhone() != null ? staff.getPhone() : "" %>"
                                       placeholder="+1 (555) 123-4567"
                                       maxlength="20">
                            </div>
                        </div>
                    </div>

                    <!-- Fourth Row: Address (Full Width) -->
                    <div class="form-row">
                        <div class="form-group full-width">
                            <label for="address" class="form-label">
                                🏠 Address
                            </label>
                            <div class="input-group">
                                <span class="input-icon">🏠</span>
                                <textarea id="address" 
                                          name="address" 
                                          class="form-input form-textarea" 
                                          placeholder="Enter complete address"
                                          maxlength="300"><%= staff.getAddress() != null ? staff.getAddress() : "" %></textarea>
                                <div class="char-counter" id="addressCounter">0/300</div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Current Staff Info Display -->
                <div class="form-row">
                    <div class="form-group full-width">
                        <div class="alert alert-info" style="background: rgba(95, 158, 160, 0.1); color: #5F9EA0; border: 1px solid rgba(95, 158, 160, 0.2); border-left: 4px solid #5F9EA0;">
                            <strong>📋 Current Staff Details:</strong><br>
                            Staff ID: #<%= staff.getUserID() %> | 
                            Current Role: <%= staff.getRole().toUpperCase() %> | 
                            Username: <%= staff.getUsername() %>
                        </div>
                    </div>
                </div>

                <!-- Form Actions -->
                <div class="form-actions">
                    <a href="view-staff.jsp" class="btn btn-outline">
                        ❌ Cancel
                    </a>
                    <button type="submit" class="btn btn-primary" id="updateBtn">
                        💾 Update Staff Member
                    </button>
                </div>
            </form>
        </div>
    </div>

    <!-- JavaScript for Form Enhancement -->
    <script>
        // Character counter for address textarea
        const addressTextarea = document.getElementById('address');
        const addressCounter = document.getElementById('addressCounter');
        
        function updateCharCounter() {
            const currentLength = addressTextarea.value.length;
            const maxLength = 300;
            addressCounter.textContent = currentLength + '/' + maxLength;
            
            // Update counter color based on usage
            if (currentLength > maxLength * 0.9) {
                addressCounter.className = 'char-counter danger';
            } else if (currentLength > maxLength * 0.7) {
                addressCounter.className = 'char-counter warning';
            } else {
                addressCounter.className = 'char-counter';
            }
        }
        
        // Initialize counter
        updateCharCounter();
        addressTextarea.addEventListener('input', updateCharCounter);
        
        // Username validation
        const usernameInput = document.getElementById('username');
        usernameInput.addEventListener('input', function(e) {
            // Remove invalid characters
            e.target.value = e.target.value.replace(/[^a-zA-Z0-9_]/g, '');
        });
        
        // Phone number formatting
        const phoneInput = document.getElementById('phone');
        phoneInput.addEventListener('input', function(e) {
            let value = e.target.value.replace(/\D/g, '');
            if (value.length >= 6) {
                value = value.replace(/(\d{3})(\d{3})(\d{4})/, '($1) $2-$3');
            } else if (value.length >= 3) {
                value = value.replace(/(\d{3})(\d{1,3})/, '($1) $2');
            }
            e.target.value = value;
        });
        
        // Birth date validation (must be at least 18 years old)
        const birthDateInput = document.getElementById('birthDate');
        const today = new Date();
        const maxDate = new Date(today.getFullYear() - 18, today.getMonth(), today.getDate());
        birthDateInput.max = maxDate.toISOString().split('T')[0];
        
        // Form submission with validation
        const form = document.getElementById('editStaffForm');
        const updateBtn = document.getElementById('updateBtn');
        
        form.addEventListener('submit', function(e) {
            // Add loading state
            updateBtn.classList.add('btn-loading');
            updateBtn.disabled = true;
            
            // Form validation
            const username = document.getElementById('username').value.trim();
            const role = document.getElementById('role').value;
            const fullName = document.getElementById('fullName').value.trim();
            const email = document.getElementById('email').value.trim();
            
            // Basic validation
            if (!username || !role || !fullName) {
                e.preventDefault();
                updateBtn.classList.remove('btn-loading');
                updateBtn.disabled = false;
                alert('Please fill in all required fields.');
                return false;
            }
            
            // Username validation
            if (username.length < 3) {
                e.preventDefault();
                updateBtn.classList.remove('btn-loading');
                updateBtn.disabled = false;
                alert('Username must be at least 3 characters long.');
                return false;
            }
            
            // Email validation (if provided)
            if (email && !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) {
                e.preventDefault();
                updateBtn.classList.remove('btn-loading');
                updateBtn.disabled = false;
                alert('Please enter a valid email address.');
                return false;
            }
            
            // Birth date validation (if provided)
            const birthDate = document.getElementById('birthDate').value;
            if (birthDate) {
                const birthDateObj = new Date(birthDate);
                const age = Math.floor((today - birthDateObj) / (365.25 * 24 * 60 * 60 * 1000));
                if (age < 18) {
                    e.preventDefault();
                    updateBtn.classList.remove('btn-loading');
                    updateBtn.disabled = false;
                    alert('Staff member must be at least 18 years old.');
                    return false;
                }
            }
        });
        
        // Auto-focus on first input
        document.getElementById('username').focus();
        
        // Role selection styling enhancement
        const roleSelect = document.getElementById('role');
        roleSelect.addEventListener('change', function(e) {
            const selectedOption = e.target.options[e.target.selectedIndex];
            if (selectedOption.value === 'admin') {
                // Add visual indicator for admin role
                e.target.style.borderColor = '#E67E22';
            } else if (selectedOption.value === 'staff') {
                e.target.style.borderColor = '#5F9EA0';
            } else {
                e.target.style.borderColor = '#e0e6ed';
            }
        });
        
        // Initialize role styling
        const currentRole = '<%= staff.getRole() %>';
        if (currentRole === 'admin') {
            roleSelect.style.borderColor = '#E67E22';
        } else if (currentRole === 'staff') {
            roleSelect.style.borderColor = '#5F9EA0';
        }
    </script>
</body>
</html>