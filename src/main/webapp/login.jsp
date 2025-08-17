<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Pahana Edu - Login</title>

<style>
/* === Reset === */
* { margin:0; padding:0; box-sizing:border-box; }

/* === Page Layout === */
body {
    font-family: 'Segoe UI', Roboto, sans-serif;
    background: linear-gradient(120deg, #5F9EA0, #8BA88E);
    display: flex;
    justify-content: center;
    align-items: center;
    min-height: 100vh;
}

.brand-side {
    flex: 1;
    background: linear-gradient(135deg, #2C3E50, #5F9EA0);
    color: white;
    padding: 40px 30px;
    display: flex;
    flex-direction: column;
    justify-content: center; /* vertical center */
    align-items: center;     /* horizontal center */
    text-align: center;
}

.brand-side img {
    width: 90px;
    height: 90px;
    object-fit: cover;
    border-radius: 12px;
    margin-bottom: 10px;
    box-shadow: 0 3px 6px rgba(0,0,0,0.2);
}

.brand-side h1 {
    font-size: 32px;
    margin: 5px 0 8px 0;
}


/* === Wrapper === */
.wrapper {
    display: flex;
    width: 100%;
    max-width: 900px;
    background: white;
    border-radius: 16px;
    box-shadow: 0 10px 40px rgba(0,0,0,0.1);
    overflow: hidden;
    animation: fadeIn 0.6s ease;
}

/* === Branding Side === */
.brand-side {
    flex: 1;
    background: linear-gradient(135deg, #2C3E50, #5F9EA0);
    color: white;
    padding: 40px 30px;
    display: flex;
    flex-direction: column;
    justify-content: center;
    text-align: center;
}
.brand-side img {
    width: 90px;
    height: 90px;
    object-fit: cover;
    border-radius: 12px;
    margin-bottom: 15px;
    box-shadow: 0 3px 6px rgba(0,0,0,0.2);
}
.brand-side h1 { font-size: 32px; margin-bottom: 10px; }
.brand-side p { font-size: 14px; opacity: 0.9; }

/* === Form Side === */
.form-side {
    flex: 1;
    padding: 40px 35px;
}
.form-side h2 {
    font-size: 24px;
    margin-bottom: 20px;
    color: #2C3E50;
    font-weight: bold;
}
.form-group { margin-bottom: 18px; position: relative; }
.form-label {
    font-size: 13px;
    font-weight: 600;
    color: #333;
    margin-bottom: 6px;
    display: block;
}
.form-input {
    width: 100%;
    padding: 12px 40px 12px 14px;
    border: 1px solid #CCC;
    border-radius: 8px;
    font-size: 15px;
    background-color: #FAFAFA;
    transition: all 0.3s ease;
}
.form-input:focus {
    border-color: #5F9EA0;
    background: white;
    box-shadow: 0 0 0 3px rgba(95,158,160,0.15);
    outline: none;
}

/* === Password Toggle Icon === */
.toggle-password {
    position: absolute;
    right: 12px;
    top: 36px;
    cursor: pointer;
    user-select: none;
}
.toggle-password img {
    width: 18px;
    height: 18px;
}

/* === Caps Lock Warning === */
.caps-warning {
    font-size: 12px;
    color: #A84448;
    display: none;
    margin-top: 4px;
}

/* === Submit Button === */
.login-button {
    width: 100%;
    background-color: #E67E22;
    border: none;
    padding: 14px;
    font-size: 15px;
    font-weight: bold;
    border-radius: 8px;
    color: white;
    cursor: pointer;
    transition: all 0.3s ease;
}
.login-button:hover {
    background-color: #cf6e1c;
    transform: translateY(-1px);
}
.login-button:disabled {
    background-color: #ccc;
    cursor: not-allowed;
}

/* === Remember Me === */
.remember-me {
    font-size: 13px;
    display: flex;
    align-items: center;
    gap: 6px;
    margin-bottom: 15px;
}

/* === Error Message === */
.error-message {
    background-color: #A84448;
    color: white;
    padding: 12px;
    border-radius: 8px;
    font-size: 14px;
    margin-top: 15px;
    text-align: center;
}

/* === Footer === */
.login-footer {
    text-align: center;
    font-size: 12px;
    color: #777;
    margin-top: 25px;
}

/* === Animation === */
@keyframes fadeIn {
    from { opacity: 0; transform: translateY(-10px); }
    to { opacity: 1; transform: translateY(0); }
}

/* === Responsive === */
@media (max-width: 768px) {
    .wrapper { flex-direction: column; }
}
</style>
</head>
<body>

<div class="wrapper">
    <!-- Branding Side -->
    <div class="brand-side">
        <img src="images/PahanaEdu.jpg" alt="Pahana Edu Logo">
        <h1>Pahana Edu</h1>
        <p>Welcome to our secure billing system. Please log in to continue.</p>
    </div>

    <!-- Form Side -->
    <div class="form-side">
        <h2>Sign In</h2>
        <form id="loginForm" action="login" method="post">
            <div class="form-group">
                <label class="form-label" for="username">Username</label>
                <input type="text" id="username" name="username" class="form-input" placeholder="Enter your username" required>
            </div>

            <div class="form-group">
                <label class="form-label" for="password">Password</label>
                <input type="password" id="password" name="password" class="form-input" placeholder="Enter your password" required>
                <span class="toggle-password" id="togglePassword">
                    <img id="toggleIcon" src="images/eye.png" alt="Show Password">
                </span>
                <div class="caps-warning" id="capsWarning">⚠ Caps Lock is ON</div>
            </div>

            <div class="remember-me">
                <input type="checkbox" id="rememberMe">
                <label for="rememberMe">Remember Me</label>
            </div>

            <button type="submit" id="loginBtn" class="login-button" disabled>Sign In</button>
        </form>

        <% if (request.getAttribute("errorMessage") != null) { %>
            <div class="error-message">
                <%= request.getAttribute("errorMessage") %>
            </div>
        <% } %>

        <div class="login-footer">
            &copy; <%= java.time.Year.now() %> Pahana Edu. All rights reserved.
        </div>
    </div>
</div>

<script>
// Autofocus Username
document.getElementById("username").focus();

// Password Toggle with Images
document.getElementById("togglePassword").addEventListener("click", function() {
    const passwordField = document.getElementById("password");
    const icon = document.getElementById("toggleIcon");

    if (passwordField.type === "password") {
        passwordField.type = "text";
        icon.src = "images/hidden.png";
        icon.alt = "Hide Password";
    } else {
        passwordField.type = "password";
        icon.src = "images/eye.png";
        icon.alt = "Show Password";
    }
});

// Caps Lock Detection
document.getElementById("password").addEventListener("keyup", function(e) {
    const capsWarning = document.getElementById("capsWarning");
    capsWarning.style.display = e.getModifierState("CapsLock") ? "block" : "none";
});

// Remember Me
document.getElementById("rememberMe").addEventListener("change", function() {
    if (this.checked) {
        localStorage.setItem("savedUsername", document.getElementById("username").value);
    } else {
        localStorage.removeItem("savedUsername");
    }
});
if (localStorage.getItem("savedUsername")) {
    document.getElementById("username").value = localStorage.getItem("savedUsername");
    document.getElementById("rememberMe").checked = true;
}

// Enable Submit When Valid
document.querySelectorAll("#username, #password").forEach(input => {
    input.addEventListener("input", function() {
        const usernameFilled = document.getElementById("username").value.trim() !== "";
        const passwordFilled = document.getElementById("password").value.trim() !== "";
        document.getElementById("loginBtn").disabled = !(usernameFilled && passwordFilled);
    });
});
</script>

</body>
</html>
 