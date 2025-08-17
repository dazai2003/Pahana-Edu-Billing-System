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
<title>Pahana Edu - Add New Item</title>
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
    max-width: 1100px;
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


<div class="container">
   

    <!-- Page Header -->
    <div class="page-header">
        <h1 class="page-title">📦 Add New Item</h1>
        <p class="page-subtitle">Expand your inventory with new educational materials and resources</p>
    </div>

    <!-- Error/Success Messages -->
    <% if (request.getAttribute("errorMessage") != null) { %>
        <div class="alert alert-error">
            ⚠️ <%= request.getAttribute("errorMessage") %>
        </div>
    <% } %>
    
    <% if (request.getAttribute("successMessage") != null) { %>
        <div class="alert alert-success">
            ✅ <%= request.getAttribute("successMessage") %>
        </div>
    <% } %>

   

    <!-- Add Item Form -->
    <div class="form-container">
        <form action="addItem" method="post" id="addItemForm" novalidate>
            
            <!-- Item Name -->
            <div class="form-row">
                <div class="form-group">
                    <label for="itemName" class="form-label">
                        📚 Item Name <span class="required">*</span>
                    </label>
                    <div class="input-group">
                        <span class="input-icon">📝</span>
                        <input type="text" 
                               id="itemName" 
                               name="name" 
                               class="form-input" 
                               placeholder="e.g., Advanced Mathematics Textbook"
                               required
                               maxlength="100"
                               autocomplete="off">
                    </div>
                    <div class="char-counter" id="nameCounter">0/100</div>
                    <div class="validation-message">Please enter a valid item name (2-100 characters)</div>
                </div>
            </div>

            <!-- Item Type -->
            <div class="form-row">
                <div class="form-group">
                    <label for="itemType" class="form-label">
                        🏷️ Item Category <span class="required">*</span>
                    </label>
                    <div class="input-group">
                        <span class="input-icon">📋</span>
                        <select id="itemType" name="item_type" class="form-input" required>
                            <option value="">-- Select Category --</option>
                            <option value="Textbooks">📚 Textbooks</option>
                            <option value="Workbooks">📖 Workbooks</option>
                            <option value="Reference Books">📑 Reference Books</option>
                            <option value="Digital Content">💿 Digital Content</option>
                            <option value="Stationery">✏️ Stationery</option>
                            <option value="Educational Software">💻 Educational Software</option>
                            <option value="Assessment Materials">📝 Assessment Materials</option>
                            <option value="Other">🔧 Other</option>
                            <option value="Novels">📚 Novels</option>
                        </select>
                    </div>
                    <div class="validation-message">Please select an item category</div>
                </div>
            </div>

            <!-- Description -->
            <div class="form-row">
                <div class="form-group full-width">
                    <label for="itemDescription" class="form-label">
                        📄 Description <span class="required">*</span>
                    </label>
                    <textarea id="itemDescription" 
                              name="description" 
                              class="form-input form-textarea" 
                              placeholder="Provide detailed description including key features, target audience, curriculum alignment, etc."
                              required
                              maxlength="500"
                              rows="1"></textarea>
                    <div class="char-counter" id="descCounter">0/500</div>
                    <div class="validation-message">Please provide a description (10-500 characters)</div>
                </div>
            </div>

            <!-- Price and Quantity Row -->
            <div class="form-row">
                <div class="form-group">
                    <label for="itemPrice" class="form-label">
                        💰 Price (LKR) <span class="required">*</span>
                    </label>
                    <div class="input-group">
                        <span class="input-icon">₨</span>
                        <input type="number" 
                               id="itemPrice" 
                               name="price" 
                               class="form-input" 
                               placeholder="0.00"
                               step="0.01"
                               min="0.01"
                               max="999999.99"
                               required>
                    </div>
                    <div class="validation-message">Please enter a valid price (0.01 - 999,999.99)</div>
                </div>
                
                <div class="form-group">
                    <label for="itemQuantity" class="form-label">
                        📦 Initial Stock Quantity <span class="required">*</span>
                    </label>
                    <div class="input-group">
                        <span class="input-icon">#</span>
                        <input type="number" 
                               id="itemQuantity" 
                               name="quantity" 
                               class="form-input" 
                               placeholder="0"
                               min="0"
                               max="99999"
                               required>
                    </div>
                    <div class="validation-message">Please enter a valid quantity (0-99,999)</div>
                </div>
            </div>

         

            <!-- Form Actions -->
            <div class="form-actions">
                <a href="dashboard.jsp" class="btn btn-secondary">
                    ❌ Cancel
                </a>
                <a href="view-items.jsp" class="btn btn-outline">
                    👁️ View All Items
                </a>
                <button type="submit" class="btn btn-primary" id="submitBtn">
                    ✅ Add Item to Inventory
                </button>
            </div>
        </form>
    </div>
</div>
 
<script>
// Form validation and enhancement
document.addEventListener('DOMContentLoaded', function() {
    const form = document.getElementById('addItemForm');
    const submitBtn = document.getElementById('submitBtn');
    
    // Character counters
    const counters = [
        { input: 'itemName', counter: 'nameCounter', max: 100 },
        { input: 'itemDescription', counter: 'descCounter', max: 500 },
        { input: 'itemSKU', counter: 'skuCounter', max: 50 },
        { input: 'itemSupplier', counter: 'supplierCounter', max: 100 }
    ];
    
    counters.forEach(({ input, counter, max }) => {
        const inputEl = document.getElementById(input);
        const counterEl = document.getElementById(counter);
        
        if (inputEl && counterEl) {
            inputEl.addEventListener('input', function() {
                const length = this.value.length;
                counterEl.textContent = `${length}/${max}`;
                
                if (length > max * 0.9) {
                    counterEl.className = 'char-counter danger';
                } else if (length > max * 0.75) {
                    counterEl.className = 'char-counter warning';
                } else {
                    counterEl.className = 'char-counter';
                }
            });
        }
    });
    
    // Auto-generate SKU based on name and type.
    const nameInput = document.getElementById('itemName');
    const typeInput = document.getElementById('itemType');
    const skuInput = document.getElementById('itemSKU');
    
    function generateSKU() {
        if (nameInput.value && typeInput.value && !skuInput.value) {
            const name = nameInput.value.toUpperCase().replace(/[^A-Z0-9]/g, '').substring(0, 8);
            const type = typeInput.value.toUpperCase().replace(/[^A-Z]/g, '').substring(0, 4);
            const year = new Date().getFullYear();
            skuInput.value = `${type}-${name}-${year}`;
            
            // Trigger character counter update
            const event = new Event('input');
            skuInput.dispatchEvent(event);
        }
    }
    
    nameInput.addEventListener('blur', generateSKU);
    typeInput.addEventListener('change', generateSKU);
    
    // Price formatting
    const priceInput = document.getElementById('itemPrice');
    priceInput.addEventListener('blur', function() {
        if (this.value) {
            this.value = parseFloat(this.value).toFixed(2);
        }
    });
    
    // Form validation
    function validateField(field) {
        const value = field.value.trim();
        const type = field.type;
        const required = field.required;
        const min = field.min;
        const max = field.max;
        const maxLength = field.maxLength;
        
        let isValid = true;
        let message = '';
        
        if (required && !value) {
            isValid = false;
            message = 'This field is required';
        } else if (value) {
            switch (type) {
                case 'text':
                case 'textarea':
                    if (value.length < 2) {
                        isValid = false;
                        message = 'Must be at least 2 characters long';
                    } else if (maxLength && value.length > maxLength) {
                        isValid = false;
                        message = `Must not exceed ${maxLength} characters`;
                    }
                    break;
                case 'number':
                    const num = parseFloat(value);
                    if (isNaN(num)) {
                        isValid = false;
                        message = 'Must be a valid number';
                    } else if (min && num < parseFloat(min)) {
                        isValid = false;
                        message = `Must be at least ${min}`;
                    } else if (max && num > parseFloat(max)) {
                        isValid = false;
                        message = `Must not exceed ${max}`;
                    }
                    break;
            }
        }
        
        const formGroup = field.closest('.form-group');
        const validationMessage = formGroup.querySelector('.validation-message');
        
        if (isValid) {
            formGroup.classList.remove('error');
            if (validationMessage) validationMessage.textContent = '';
        } else {
            formGroup.classList.add('error');
            if (validationMessage) validationMessage.textContent = message;
        }
        
        return isValid;
    }
    
    // Real-time validation
    const inputs = form.querySelectorAll('input, textarea, select');
    inputs.forEach(input => {
        input.addEventListener('blur', () => validateField(input));
        input.addEventListener('input', () => {
            if (input.closest('.form-group').classList.contains('error')) {
                validateField(input);
            }
        });
    });
    
    // Form submission
    form.addEventListener('submit', function(e) {
        e.preventDefault();
        
        let isFormValid = true;
        inputs.forEach(input => {
            if (!validateField(input)) {
                isFormValid = false;
            }
        });
        
        if (isFormValid) {
            // Show loading state
            submitBtn.classList.add('btn-loading');
            submitBtn.disabled = true;
            
            // Submit form
            setTimeout(() => {
                form.submit();
            }, 500);
        } else {
            // Focus on first invalid field
            const firstError = form.querySelector('.form-group.error input, .form-group.error textarea, .form-group.error select');
            if (firstError) {
                firstError.focus();
            }
        }
    });
    
    // Auto-save to localStorage (optional)
    const formData = {};
    inputs.forEach(input => {
        const savedValue = localStorage.getItem(`addItem_${input.name}`);
        if (savedValue && input.type !== 'submit') {
            input.value = savedValue;
            // Trigger input event for character counters
            const event = new Event('input');
            input.dispatchEvent(event);
        }
        
        input.addEventListener('input', () => {
            if (input.name && input.type !== 'submit') {
                localStorage.setItem(`addItem_${input.name}`, input.value);
            }
        });
    });
    
    // Clear localStorage on successful submission
    form.addEventListener('submit', () => {
        inputs.forEach(input => {
            if (input.name) {
                localStorage.removeItem(`addItem_${input.name}`);
            }
        });
    });
    
    // Keyboard shortcuts
    document.addEventListener('keydown', (e) => {
        if (e.ctrlKey && e.key === 's') {
            e.preventDefault();
            form.dispatchEvent(new Event('submit'));
        }
        
        if (e.key === 'Escape') {
            window.location.href = 'dashboard.jsp';
        }
    });
});

// Price calculation helpers
function calculateMarkup(cost, markup) {
    return (cost * (1 + markup / 100)).toFixed(2);
}



// Add price suggestion on category change
document.getElementById('itemType').addEventListener('change', suggestPrice);
</script>

</body>
</html>