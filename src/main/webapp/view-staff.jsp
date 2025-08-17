<%@ page import="java.util.*, com.pahanaedu.dao.StaffDAO, com.pahanaedu.model.Staff, com.pahanaedu.model.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
User user = (User) session.getAttribute("loggedUser");
if (user == null) {
    response.sendRedirect("login.jsp");
    return;
}

List<Staff> staffList = StaffDAO.getAllStaff();
int totalStaff = staffList.size();
int adminCount = 0;
int staffCount = 0;

for (Staff s : staffList) {
    if ("admin".equals(s.getRole())) {
        adminCount++;
    } else {
        staffCount++;
    }
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Pahana Edu - Manage Staff</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<style>
/* Reset */
* {margin:0; padding:0; box-sizing:border-box;}
body {
    font-family: 'Segoe UI', Tahoma, sans-serif;
    background-color: #F5F5F5; /* Soft off-white */
    color: #333; /* Dark gray */
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
    color: #ffffff; /* white text for contrast. */
}
.back-btn {
    background-color:#5F9EA0; /* Muted teal */
    color:white;
    border:none;
    padding:8px 14px;
    border-radius:6px;
    cursor:pointer;
    font-size:14px;
    text-decoration:none;
    display:inline-block;
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
    display:flex;
    justify-content:space-between;
    align-items:center;
    padding:15px 30px;
    background-color:#2C3E50; /* Deep navy */
    color:white;
    position:sticky;
    top:0;
    z-index:10;
}
.navbar .logo {
    font-size:20px;
    font-weight:bold;
}

.back-btn:hover {
    background-color:#4a7c7f;
}

/* Main Container */
.main {
    padding:20px;
    max-width:1400px;
    margin:auto;
}

/* Header */
.header {
    margin-bottom:25px;
}
.header h1 {
    font-size:28px;
    font-weight:600;
    color:#2C3E50;
    margin-bottom:8px;
}
.header p {
    font-size:14px;
    color:#5F9EA0;
}

/* Stats Cards */
.stats {
    display:grid;
    grid-template-columns:repeat(auto-fit, minmax(200px, 1fr));
    gap:20px;
    margin-bottom:30px;
}
.stat-card {
    background:white;
    border-radius:12px;
    padding:20px;
    text-align:center;
    box-shadow:0 2px 8px rgba(0,0,0,0.08);
    border-left:6px solid #8BA88E; /* Sage green */
}
.stat-card h2 {
    font-size:24px;
    margin-bottom:5px;
    color:#2C3E50;
}
.stat-card p {
    font-size:14px;
    color:#5F9EA0;
}

/* Action Bar */
.action-bar {
    display:flex;
    justify-content:space-between;
    align-items:center;
    margin-bottom:25px;
    gap:15px;
    flex-wrap:wrap;
}
.add-btn {
    background-color:#E67E22; /* Warm orange */
    color:white;
    border:none;
    padding:12px 20px;
    border-radius:8px;
    cursor:pointer;
    font-size:14px;
    font-weight:500;
    text-decoration:none;
    display:inline-flex;
    align-items:center;
    gap:8px;
    transition:0.3s;
}
.add-btn:hover {
    background-color:#d35400;
    transform:translateY(-1px);
}

/* Search and Filter */
.search-filter {
    display:flex;
    gap:15px;
    flex:1;
    max-width:600px;
}
.search-box, .filter-select {
    padding:10px 14px;
    border:2px solid #e1e5e9;
    border-radius:8px;
    font-size:14px;
    background:white;
    transition:0.3s;
}
.search-box:focus, .filter-select:focus {
    outline:none;
    border-color:#8BA88E;
}
.search-box {
    flex:1;
}

/* Table Container */
.table-container {
    background:white;
    border-radius:12px;
    box-shadow:0 2px 8px rgba(0,0,0,0.08);
    overflow:hidden;
    border-left:6px solid #8BA88E;
}

/* Table */
.staff-table {
    width:100%;
    border-collapse:collapse;
}
.staff-table th {
    background-color:#2C3E50;
    color:white;
    padding:15px 12px;
    text-align:left;
    font-weight:600;
    font-size:14px;
    border:none;
}
.staff-table td {
    padding:12px;
    border-bottom:1px solid #e8ecef;
    font-size:14px;
    vertical-align:middle;
}
.staff-table tr:hover {
    background-color:#f8f9fa;
}
.staff-table tr:last-child td {
    border-bottom:none;
}

/* Role Badge */
.role-badge {
    padding:4px 10px;
    border-radius:15px;
    font-size:12px;
    font-weight:500;
    text-transform:uppercase;
}
.role-admin {
    background-color:#E67E22;
    color:white;
}
.role-staff {
    background-color:#8BA88E;
    color:white;
}

/* Action Buttons */
.action-buttons {
    display:flex;
    gap:8px;
}
.btn {
    padding:6px 12px;
    border:none;
    border-radius:6px;
    cursor:pointer;
    font-size:12px;
    font-weight:500;
    text-decoration:none;
    display:inline-flex;
    align-items:center;
    gap:4px;
    transition:0.3s;
}
.btn-edit {
    background-color:#5F9EA0;
    color:white;
}
.btn-edit:hover {
    background-color:#4a7c7f;
}
.btn-delete {
    background-color:#e74c3c;
    color:white;
}
.btn-delete:hover {
    background-color:#c0392b;
}

/* Empty State */
.empty-state {
    text-align:center;
    padding:60px 20px;
    color:#666;
}
.empty-state h3 {
    font-size:18px;
    margin-bottom:8px;
    color:#2C3E50;
}

/* Loading */
.loading {
    text-align:center;
    padding:40px;
    color:#5F9EA0;
    font-size:14px;
}

/* Mobile Responsive */
@media (max-width: 768px) {
    .action-bar {
        flex-direction:column;
        align-items:stretch;
    }
    .search-filter {
        max-width:none;
    }
    .stats {
        grid-template-columns:1fr;
    }
    .table-container {
        overflow-x:auto;
    }
    .staff-table {
        min-width:800px;
    }
}

/* Animations */
@keyframes fadeIn {
    from { opacity:0; transform:translateY(10px); }
    to { opacity:1; transform:translateY(0); }
}
.staff-table tr {
    animation:fadeIn 0.3s ease-out;
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


<!-- Main -->
<div class="main">
    <!-- Header -->
    <div class="header">
        <h1>Staff Management 🧑‍💼</h1>
        <p>Manage and monitor all staff members in your system.</p>
    </div>

    <!-- Stats -->
    <div class="stats">
        <div class="stat-card">
            <h2><%= totalStaff %></h2>
            <p>Total Staff</p>
        </div>
        <div class="stat-card">
            <h2><%= adminCount %></h2>
            <p>Administrators</p>
        </div>
        <div class="stat-card">
            <h2><%= staffCount %></h2>
            <p>Staff Members</p>
        </div>
    </div>

    <!-- Action Bar -->
    <div class="action-bar">
        <div class="search-filter">
            <input type="text" class="search-box" id="searchBox" placeholder="🔍 Search by name, username, or email...">
            <select class="filter-select" id="roleFilter">
                <option value="">All Roles</option>
                <option value="admin">Admin</option>
                <option value="staff">Staff</option>
            </select>
        </div>
        <a href="add-staff.jsp" class="add-btn">
            ➕ Add New Staff
        </a>
    </div>

    <!-- Table -->
    <div class="table-container">
        <table class="staff-table">
            <thead>
                <tr>
                    <th>Staff ID</th>
                    <th>Username</th>
                    <th>Role</th>
                    <th>Full Name</th>
                    <th>Email</th>
                    <th>Phone</th>
                    <th>Birth Date</th>
                    <th>Address</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody id="staffTableBody">
                <% if (staffList.isEmpty()) { %>
                    <tr>
                        <td colspan="9" class="empty-state">
                            <h3>No Staff Members Found</h3>
                            <p>Get started by adding your first staff member.</p>
                        </td>
                    </tr>
                <% } else { %>
                    <% for (Staff s : staffList) { %>
                        <tr class="staff-row" 
                            data-username="<%= s.getUsername().toLowerCase() %>"
                            data-name="<%= s.getFullName().toLowerCase() %>"
                            data-email="<%= s.getEmail().toLowerCase() %>"
                            data-role="<%= s.getRole().toLowerCase() %>">
                            <td><strong>#<%= s.getUserID() %></strong></td>
                            <td><%= s.getUsername() %></td>
                            <td>
                                <span class="role-badge role-<%= s.getRole() %>">
                                    <%= s.getRole() %>
                                </span>
                            </td>
                            <td><%= s.getFullName() %></td>
                            <td><%= s.getEmail() %></td>
                            <td><%= s.getPhone() %></td>
                            <td><%= s.getBirthDate() != null ? s.getBirthDate() : "N/A" %></td>
                            <td title="<%= s.getAddress() %>">
                                <%= s.getAddress().length() > 30 ? s.getAddress().substring(0, 30) + "..." : s.getAddress() %>
                            </td>
                            <td>
                                <div class="action-buttons">
                                    <a href="edit-staff.jsp?userID=<%= s.getUserID() %>" class="btn btn-edit">
                                        ✏️ Edit
                                    </a>
                                    <a href="DeleteStaffServlet?userID=<%= s.getUserID() %>" 
                                       class="btn btn-delete"
                                       onclick="return confirm('⚠️ Are you sure you want to delete <%= s.getFullName() %>?\n\nThis action cannot be undone.');">
                                        🗑️ Delete
                                    </a>
                                </div>
                            </td>
                        </tr>
                    <% } %>
                <% } %>
            </tbody>
        </table>
    </div>
</div>

<script>
// Search and Filter Functionality
document.addEventListener('DOMContentLoaded', function() {
    const searchBox = document.getElementById('searchBox');
    const roleFilter = document.getElementById('roleFilter');
    const staffRows = document.querySelectorAll('.staff-row');

    function filterStaff() {
        const searchTerm = searchBox.value.toLowerCase();
        const selectedRole = roleFilter.value.toLowerCase();
        let visibleCount = 0;

        staffRows.forEach(row => {
            const username = row.dataset.username;
            const name = row.dataset.name;
            const email = row.dataset.email;
            const role = row.dataset.role;

            const matchesSearch = !searchTerm || 
                username.includes(searchTerm) || 
                name.includes(searchTerm) || 
                email.includes(searchTerm);
            
            const matchesRole = !selectedRole || role === selectedRole;

            if (matchesSearch && matchesRole) {
                row.style.display = '';
                visibleCount++;
            } else {
                row.style.display = 'none';
            }
        });

        // Show/hide empty state
        const tbody = document.getElementById('staffTableBody');
        const existingEmptyState = tbody.querySelector('.filter-empty-state');
        
        if (visibleCount === 0 && staffRows.length > 0) {
            if (!existingEmptyState) {
                const emptyRow = document.createElement('tr');
                emptyRow.className = 'filter-empty-state';
                emptyRow.innerHTML = `
                    <td colspan="9" class="empty-state">
                        <h3>No Staff Found</h3>
                        <p>Try adjusting your search criteria.</p>
                    </td>
                `;
                tbody.appendChild(emptyRow);
            }
        } else if (existingEmptyState) {
            existingEmptyState.remove();
        }
    }

    // Add event listeners with debouncing for search
    let searchTimeout;
    searchBox.addEventListener('input', function() {
        clearTimeout(searchTimeout);
        searchTimeout = setTimeout(filterStaff, 300);
    });

    roleFilter.addEventListener('change', filterStaff);

    // Keyboard shortcuts
    document.addEventListener('keydown', function(e) {
        if (e.ctrlKey && e.key === 'f') {
            e.preventDefault();
            searchBox.focus();
        }
        if (e.ctrlKey && e.key === 'n') {
            e.preventDefault();
            window.location.href = 'add-staff.jsp';
        }
    });

    // Enhanced delete confirmation
    document.querySelectorAll('.btn-delete').forEach(btn => {
        btn.addEventListener('click', function(e) {
            const staffName = this.closest('tr').querySelector('td:nth-child(4)').textContent;
            if (!confirm(`⚠️ Delete Staff Member\n\nAre you sure you want to permanently delete "${staffName}"?\n\nThis action cannot be undone and will remove all associated data.`)) {
                e.preventDefault();
            }
        });
    });

    console.log('🎉 Staff Management System Loaded - Advanced Features Active');
});
</script>

</body>
</html>