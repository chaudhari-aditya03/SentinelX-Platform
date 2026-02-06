<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>

<%
    // AUTH GUARD - Ensures only ADMIN role can access this page
    HttpSession sessionObj = request.getSession(false);
    if (sessionObj == null || sessionObj.getAttribute("role") == null ||
            !"ADMIN".equals(sessionObj.getAttribute("role"))) {
        response.sendRedirect(request.getContextPath() + "/views/auth/login.jsp?error=Unauthorized+Access");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Admin Dashboard - Nexus Crime Data & Analytics Hub">
    <title>Admin Dashboard | Nexus</title>

    <!-- Design System CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/base.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/layout.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/components.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/dashboard.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/theme.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/enhancements.css">
    
    <!-- External Dependencies -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
    <div class="dashboard-layout">
        <!-- Sidebar -->
        <aside class="sidebar" role="navigation" aria-label="Main navigation">
            <div class="sidebar-header">
                <div class="sidebar-logo">
                    <div class="sidebar-logo-icon">
                        <i class="bi bi-shield-check"></i>
                    </div>
                    <span class="sidebar-logo-text">NEXUS</span>
                </div>
                <button class="sidebar-toggle" id="sidebarToggle" aria-label="Toggle sidebar">
                    <i class="bi bi-list"></i>
                </button>
            </div>

            <nav class="sidebar-nav">
                <a href="#" class="sidebar-nav-item active" data-section="overview">
                    <i class="bi bi-speedometer2"></i>
                    <span>Dashboard</span>
                </a>
                <a href="${pageContext.request.contextPath}/views/admin/userManagement.jsp" class="sidebar-nav-item">
                    <i class="bi bi-people"></i>
                    <span>User Management</span>
                </a>
                <a href="${pageContext.request.contextPath}/views/admin/complaintMonitor.jsp" class="sidebar-nav-item">
                    <i class="bi bi-file-text"></i>
                    <span>Complaint Monitor</span>
                </a>
                <a href="${pageContext.request.contextPath}/views/admin/advanceAnalytics.jsp" class="sidebar-nav-item">
                    <i class="bi bi-graph-up-arrow"></i>
                    <span>Advanced Analytics</span>
                </a>
                <a href="${pageContext.request.contextPath}/views/admin/assignOfficer.jsp" class="sidebar-nav-item">
                    <i class="bi bi-person-badge"></i>
                    <span>Assign Officers</span>
                </a>
                <a href="${pageContext.request.contextPath}/views/admin/station_dept.jsp" class="sidebar-nav-item">
                    <i class="bi bi-building"></i>
                    <span>Stations & Depts</span>
                </a>
                <a href="${pageContext.request.contextPath}/views/admin/broadcast_alert.jsp" class="sidebar-nav-item">
                    <i class="bi bi-megaphone"></i>
                    <span>Broadcast Alerts</span>
                </a>
                <a href="${pageContext.request.contextPath}/views/admin/system_logs.jsp" class="sidebar-nav-item">
                    <i class="bi bi-journal-text"></i>
                    <span>System Logs</span>
                </a>
            </nav>

            <div class="sidebar-footer">
                <div class="sidebar-user">
                    <div class="sidebar-user-avatar">
                        <i class="bi bi-person-circle"></i>
                    </div>
                    <div class="sidebar-user-info">
                        <div class="sidebar-user-name">${sessionScope.username}</div>
                        <div class="sidebar-user-role">Administrator</div>
                    </div>
                </div>
                <a href="${pageContext.request.contextPath}/views/auth/logout.jsp" class="sidebar-nav-item logout-link">
                    <i class="bi bi-box-arrow-right"></i>
                    <span>Logout</span>
                </a>
            </div>
        </aside>

        <!-- Main Content -->
        <main class="main-content">
            <!-- Dashboard Header -->
            <header class="navbar-dashboard">
                <div class="navbar-left">
                    <button class="sidebar-toggle mobile-only" id="mobileSidebarToggle">
                        <i class="bi bi-list"></i>
                    </button>
                    <h1 class="page-title">Admin Dashboard</h1>
                </div>
                
                <div class="navbar-right">
                    <div class="navbar-search">
                        <i class="bi bi-search"></i>
                        <input type="search" placeholder="Search..." aria-label="Search">
                    </div>
                    
                    <button class="theme-toggle" id="themeToggle" aria-label="Toggle theme">
                        <i class="bi bi-moon-stars"></i>
                    </button>
                    
                    <div class="navbar-notifications">
                        <button class="notification-btn" aria-label="Notifications">
                            <i class="bi bi-bell"></i>
                            <span class="notification-badge">5</span>
                        </button>
                    </div>
                    
                    <div class="navbar-user">
                        <button class="user-menu-btn" aria-label="User menu">
                            <i class="bi bi-person-circle"></i>
                            <span>${sessionScope.username}</span>
                            <i class="bi bi-chevron-down"></i>
                        </button>
                    </div>
                </div>
            </header>

            <!-- Dashboard Content -->
            <div class="dashboard-content">
                <!-- Stats Grid -->
                <div class="dashboard-stats">
                    <div class="stat-card success">
                        <div class="stat-card-icon">
                            <i class="bi bi-people-fill"></i>
                        </div>
                        <div class="stat-card-content">
                            <div class="stat-card-label">Total Users</div>
                            <div class="stat-card-value">1,284</div>
                            <div class="stat-card-change positive">
                                <i class="bi bi-arrow-up"></i> 12% vs last month
                            </div>
                        </div>
                    </div>

                    <div class="stat-card primary">
                        <div class="stat-card-icon">
                            <i class="bi bi-file-text-fill"></i>
                        </div>
                        <div class="stat-card-content">
                            <div class="stat-card-label">Active Complaints</div>
                            <div class="stat-card-value">487</div>
                            <div class="stat-card-change positive">
                                <i class="bi bi-arrow-up"></i> 8% vs last week
                            </div>
                        </div>
                    </div>

                    <div class="stat-card warning">
                        <div class="stat-card-icon">
                            <i class="bi bi-exclamation-triangle-fill"></i>
                        </div>
                        <div class="stat-card-content">
                            <div class="stat-card-label">Pending Reviews</div>
                            <div class="stat-card-value">156</div>
                            <div class="stat-card-change negative">
                                <i class="bi bi-arrow-down"></i> 3% vs yesterday
                            </div>
                        </div>
                    </div>

                    <div class="stat-card danger">
                        <div class="stat-card-icon">
                            <i class="bi bi-check-circle-fill"></i>
                        </div>
                        <div class="stat-card-content">
                            <div class="stat-card-label">Resolved Cases</div>
                            <div class="stat-card-value">2,941</div>
                            <div class="stat-card-change positive">
                                <i class="bi bi-arrow-up"></i> 24% vs last month
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Charts Row -->
                <div class="dashboard-row">
                    <div class="dashboard-col-8">
                        <div class="widget">
                            <div class="widget-header">
                                <h3 class="widget-title">Complaint Trends</h3>
                                <div class="widget-actions">
                                    <button class="btn btn-sm btn-ghost">
                                        <i class="bi bi-download"></i> Export
                                    </button>
                                </div>
                            </div>
                            <div class="widget-body">
                                <canvas id="complaintTrendsChart" style="max-height: 300px;"></canvas>
                            </div>
                        </div>
                    </div>

                    <div class="dashboard-col-4">
                        <div class="widget">
                            <div class="widget-header">
                                <h3 class="widget-title">Status Distribution</h3>
                            </div>
                            <div class="widget-body">
                                <canvas id="statusDistributionChart" style="max-height: 300px;"></canvas>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Recent Activity -->
                <div class="dashboard-row">
                    <div class="dashboard-col-12">
                        <div class="widget">
                            <div class="widget-header">
                                <h3 class="widget-title">Recent Activity</h3>
                                <div class="widget-actions">
                                    <input type="search" placeholder="Search activity..." class="form-control" style="max-width: 250px;">
                                </div>
                            </div>
                            <div class="widget-body">
                                <table class="dashboard-table">
                                    <thead>
                                        <tr>
                                            <th>User</th>
                                            <th>Action</th>
                                            <th>Type</th>
                                            <th>Status</th>
                                            <th>Time</th>
                                            <th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>
                                                <div class="user-cell">
                                                    <div class="user-avatar"><i class="bi bi-person-circle"></i></div>
                                                    <div>
                                                        <div class="user-name">John Doe</div>
                                                        <div class="user-meta">Civilian</div>
                                                    </div>
                                                </div>
                                            </td>
                                            <td>Filed new complaint #C1234</td>
                                            <td><span class="badge badge-primary">Theft</span></td>
                                            <td><span class="badge badge-warning">Pending</span></td>
                                            <td>2 mins ago</td>
                                            <td>
                                                <button class="btn btn-sm btn-ghost"><i class="bi bi-eye"></i></button>
                                                <button class="btn btn-sm btn-ghost"><i class="bi bi-pencil"></i></button>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <div class="user-cell">
                                                    <div class="user-avatar"><i class="bi bi-person-circle"></i></div>
                                                    <div>
                                                        <div class="user-name">Officer Smith</div>
                                                        <div class="user-meta">Police</div>
                                                    </div>
                                                </div>
                                            </td>
                                            <td>Updated case #C5678</td>
                                            <td><span class="badge badge-danger">Assault</span></td>
                                            <td><span class="badge badge-success">Resolved</span></td>
                                            <td>15 mins ago</td>
                                            <td>
                                                <button class="btn btn-sm btn-ghost"><i class="bi bi-eye"></i></button>
                                                <button class="btn btn-sm btn-ghost"><i class="bi bi-pencil"></i></button>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <div class="user-cell">
                                                    <div class="user-avatar"><i class="bi bi-person-circle"></i></div>
                                                    <div>
                                                        <div class="user-name">Jane Wilson</div>
                                                        <div class="user-meta">Civilian</div>
                                                    </div>
                                                </div>
                                            </td>
                                            <td>Submitted evidence for #C9012</td>
                                            <td><span class="badge badge-warning">Fraud</span></td>
                                            <td><span class="badge badge-primary">Under Review</span></td>
                                            <td>1 hour ago</td>
                                            <td>
                                                <button class="btn btn-sm btn-ghost"><i class="bi bi-eye"></i></button>
                                                <button class="btn btn-sm btn-ghost"><i class="bi bi-pencil"></i></button>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>

    <!-- JavaScript -->
    <script src="${pageContext.request.contextPath}/js/app.js"></script>
    <script src="${pageContext.request.contextPath}/js/layout.js"></script>
    <script src="${pageContext.request.contextPath}/js/dashboard.js"></script>
    
    <script>
        // Initialize Charts
        document.addEventListener('DOMContentLoaded', function() {
            // Complaint Trends Chart
            const trendsCtx = document.getElementById('complaintTrendsChart');
            if (trendsCtx) {
                new Chart(trendsCtx, {
                    type: 'line',
                    data: {
                        labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'],
                        datasets: [{
                            label: 'Complaints Filed',
                            data: [65, 59, 80, 81, 56, 55],
                            borderColor: 'rgb(0, 163, 255)',
                            backgroundColor: 'rgba(0, 163, 255, 0.1)',
                            tension: 0.4
                        }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        plugins: {
                            legend: { display: false }
                        }
                    }
                });
            }
            
            // Status Distribution Chart
            const statusCtx = document.getElementById('statusDistributionChart');
            if (statusCtx) {
                new Chart(statusCtx, {
                    type: 'doughnut',
                    data: {
                        labels: ['Pending', 'Under Review', 'Resolved', 'Closed'],
                        datasets: [{
                            data: [156, 120, 250, 95],
                            backgroundColor: [
                                'rgb(255, 193, 7)',
                                'rgb(0, 163, 255)',
                                'rgb(0, 200, 81)',
                                'rgb(220, 53, 69)'
                            ]
                        }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        plugins: {
                            legend: { position: 'bottom' }
                        }
                    }
                });
            }
        });
    </script>
</body>
</html>
