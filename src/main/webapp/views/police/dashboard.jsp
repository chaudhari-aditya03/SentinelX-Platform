<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>

<%
    // AUTH GUARD - Ensures only POLICE role can access this page
    HttpSession sessionObj = request.getSession(false);
    if (sessionObj == null || sessionObj.getAttribute("role") == null ||
            !"POLICE".equals(sessionObj.getAttribute("role"))) {
        response.sendRedirect(request.getContextPath() + "/views/auth/login.jsp?error=Unauthorized+Access");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Police Officer Dashboard - Nexus Crime Data & Analytics Hub">
    <title>Police Dashboard | Nexus</title>

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
                <a href="#" class="sidebar-nav-item" data-section="assignments">
                    <i class="bi bi-inbox-fill"></i>
                    <span>Case Assignments</span>
                    <span class="sidebar-badge">12</span>
                </a>
                <a href="#" class="sidebar-nav-item" data-section="investigation">
                    <i class="bi bi-search"></i>
                    <span>Investigations</span>
                </a>
                <a href="#" class="sidebar-nav-item" data-section="analytics">
                    <i class="bi bi-graph-up-arrow"></i>
                    <span>Crime Analytics</span>
                </a>
                <a href="#" class="sidebar-nav-item" data-section="reports">
                    <i class="bi bi-file-earmark-text"></i>
                    <span>Reports</span>
                </a>
                <a href="${pageContext.request.contextPath}/views/police/profile.jsp" class="sidebar-nav-item">
                    <i class="bi bi-person-badge"></i>
                    <span>Officer Profile</span>
                </a>
            </nav>

            <div class="sidebar-footer">
                <div class="sidebar-user">
                    <div class="sidebar-user-avatar">
                        <i class="bi bi-person-circle"></i>
                    </div>
                    <div class="sidebar-user-info">
                        <div class="sidebar-user-name">${sessionScope.username}</div>
                        <div class="sidebar-user-role">Police Officer</div>
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
                    <h1 class="page-title">Police Dashboard</h1>
                </div>
                
                <div class="navbar-right">
                    <div class="navbar-search">
                        <i class="bi bi-search"></i>
                        <input type="search" placeholder="Search cases..." aria-label="Search">
                    </div>
                    
                    <button class="theme-toggle" id="themeToggle" aria-label="Toggle theme">
                        <i class="bi bi-moon-stars"></i>
                    </button>
                    
                    <div class="navbar-notifications">
                        <button class="notification-btn" aria-label="Notifications">
                            <i class="bi bi-bell"></i>
                            <span class="notification-badge">8</span>
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
            <div class="dashboard-content" id="overviewView">
                <!-- Alert Banner -->
                <div class="alert alert-warning" style="margin-bottom: var(--space-8);">
                    <i class="bi bi-exclamation-triangle-fill" style="margin-right: var(--space-2);"></i>
                    <strong>Priority Alert:</strong> 3 high-priority cases require immediate attention.
                </div>

                <!-- Stats Grid -->
                <div class="dashboard-stats">
                    <div class="stat-card primary">
                        <div class="stat-card-icon">
                            <i class="bi bi-folder-fill"></i>
                        </div>
                        <div class="stat-card-content">
                            <div class="stat-card-label">Assigned Cases</div>
                            <div class="stat-card-value">24</div>
                            <div class="stat-card-change positive">
                                <i class="bi bi-arrow-up"></i> 4 new today
                            </div>
                        </div>
                    </div>

                    <div class="stat-card warning">
                        <div class="stat-card-icon">
                            <i class="bi bi-clock-history"></i>
                        </div>
                        <div class="stat-card-content">
                            <div class="stat-card-label">Pending Action</div>
                            <div class="stat-card-value">12</div>
                            <div class="stat-card-change">Requires update</div>
                        </div>
                    </div>

                    <div class="stat-card success">
                        <div class="stat-card-icon">
                            <i class="bi bi-check-circle-fill"></i>
                        </div>
                        <div class="stat-card-content">
                            <div class="stat-card-label">Resolved This Month</div>
                            <div class="stat-card-value">18</div>
                            <div class="stat-card-change positive">
                                <i class="bi bi-arrow-up"></i> 12% increase
                            </div>
                        </div>
                    </div>

                    <div class="stat-card danger">
                        <div class="stat-card-icon">
                            <i class="bi bi-exclamation-octagon-fill"></i>
                        </div>
                        <div class="stat-card-content">
                            <div class="stat-card-label">High Priority</div>
                            <div class="stat-card-value">3</div>
                            <div class="stat-card-change">Immediate attention</div>
                        </div>
                    </div>
                </div>

                <!-- Recent Cases -->
                <div class="dashboard-row">
                    <div class="dashboard-col-8">
                        <div class="widget">
                            <div class="widget-header">
                                <h3 class="widget-title">Recent Case Assignments</h3>
                                <div class="widget-actions">
                                    <button class="btn btn-sm btn-ghost" onclick="showSection('assignments')">
                                        View All
                                    </button>
                                </div>
                            </div>
                            <div class="widget-body">
                                <table class="dashboard-table">
                                    <thead>
                                        <tr>
                                            <th>Case ID</th>
                                            <th>Type</th>
                                            <th>Location</th>
                                            <th>Priority</th>
                                            <th>Status</th>
                                            <th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td><strong>#C5678</strong></td>
                                            <td><span class="badge badge-danger">Assault</span></td>
                                            <td>Downtown District</td>
                                            <td><span class="badge badge-danger">High</span></td>
                                            <td><span class="badge badge-warning">In Progress</span></td>
                                            <td>
                                                <button class="btn btn-sm btn-primary"><i class="bi bi-eye"></i></button>
                                                <button class="btn btn-sm btn-ghost"><i class="bi bi-pencil"></i></button>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td><strong>#C5621</strong></td>
                                            <td><span class="badge badge-primary">Theft</span></td>
                                            <td>Market Area</td>
                                            <td><span class="badge badge-warning">Medium</span></td>
                                            <td><span class="badge badge-primary">Evidence Collection</span></td>
                                            <td>
                                                <button class="btn btn-sm btn-primary"><i class="bi bi-eye"></i></button>
                                                <button class="btn btn-sm btn-ghost"><i class="bi bi-pencil"></i></button>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td><strong>#C5598</strong></td>
                                            <td><span class="badge badge-warning">Vandalism</span></td>
                                            <td>Park District</td>
                                            <td><span class="badge badge-success">Low</span></td>
                                            <td><span class="badge badge-success">Report Filed</span></td>
                                            <td>
                                                <button class="btn btn-sm btn-primary"><i class="bi bi-eye"></i></button>
                                                <button class="btn btn-sm btn-ghost"><i class="bi bi-pencil"></i></button>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>

                    <div class="dashboard-col-4">
                        <div class="widget">
                            <div class="widget-header">
                                <h3 class="widget-title">Priority Distribution</h3>
                            </div>
                            <div class="widget-body">
                                <canvas id="priorityChart" style="max-height: 250px;"></canvas>
                            </div>
                        </div>

                        <div class="widget" style="margin-top: var(--space-6);">
                            <div class="widget-header">
                                <h3 class="widget-title">Quick Actions</h3>
                            </div>
                            <div class="widget-body">
                                <div class="quick-links">
                                    <a href="#" class="quick-link">
                                        <i class="bi bi-file-earmark-plus"></i>
                                        <span>New Report</span>
                                    </a>
                                    <a href="#" class="quick-link">
                                        <i class="bi bi-camera"></i>
                                        <span>Upload Evidence</span>
                                    </a>
                                    <a href="#" class="quick-link">
                                        <i class="bi bi-people"></i>
                                        <span>Request Backup</span>
                                    </a>
                                    <a href="#" class="quick-link">
                                        <i class="bi bi-printer"></i>
                                        <span>Print Report</span>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Case Assignments View (Hidden by default) -->
            <div class="dashboard-content" id="assignmentsView" style="display: none;">
                <div class="dashboard-row">
                    <div class="dashboard-col-12">
                        <div class="widget">
                            <div class="widget-header">
                                <h3 class="widget-title">All Case Assignments</h3>
                                <button class="btn btn-sm btn-ghost" onclick="showSection('overview')">
                                    <i class="bi bi-arrow-left"></i> Back to Dashboard
                                </button>
                            </div>
                            <div class="widget-body">
                                <div class="flex gap-3 items-center" style="margin-bottom: var(--space-4);">
                                    <input type="search" placeholder="Search cases..." class="form-control" style="max-width: 300px;">
                                    <select class="form-select" style="max-width: 200px;">
                                        <option>All Priorities</option>
                                        <option>High</option>
                                        <option>Medium</option>
                                        <option>Low</option>
                                    </select>
                                    <select class="form-select" style="max-width: 200px;">
                                        <option>All Statuses</option>
                                        <option>New</option>
                                        <option>In Progress</option>
                                        <option>Resolved</option>
                                    </select>
                                </div>
                                <table class="dashboard-table">
                                    <thead>
                                        <tr>
                                            <th>Case ID</th>
                                            <th>Type</th>
                                            <th>Complainant</th>
                                            <th>Location</th>
                                            <th>Date Filed</th>
                                            <th>Priority</th>
                                            <th>Status</th>
                                            <th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td><strong>#C5678</strong></td>
                                            <td><span class="badge badge-danger">Assault</span></td>
                                            <td>John Doe</td>
                                            <td>Downtown District</td>
                                            <td>2024-01-28</td>
                                            <td><span class="badge badge-danger">High</span></td>
                                            <td><span class="badge badge-warning">In Progress</span></td>
                                            <td>
                                                <button class="btn btn-sm btn-primary"><i class="bi bi-eye"></i></button>
                                                <button class="btn btn-sm btn-ghost"><i class="bi bi-pencil"></i></button>
                                                <button class="btn btn-sm btn-ghost"><i class="bi bi-check-circle"></i></button>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Other views can be added similarly -->
        </main>
    </div>

    <!-- JavaScript -->
    <script src="${pageContext.request.contextPath}/js/app.js"></script>
    <script src="${pageContext.request.contextPath}/js/layout.js"></script>
    <script src="${pageContext.request.contextPath}/js/dashboard.js"></script>
    
    <script>
        function showSection(section) {
            // Hide all views
            document.getElementById('overviewView').style.display = 'none';
            document.getElementById('assignmentsView').style.display = 'none';
            
            // Show selected view
            if (section === 'overview') {
                document.getElementById('overviewView').style.display = 'block';
            } else if (section === 'assignments') {
                document.getElementById('assignmentsView').style.display = 'block';
            }
            
            // Update active nav item
            document.querySelectorAll('.sidebar-nav-item').forEach(item => {
                item.classList.remove('active');
                if (item.getAttribute('data-section') === section) {
                    item.classList.add('active');
                }
            });
        }
        
        // Handle sidebar navigation clicks
        document.querySelectorAll('.sidebar-nav-item[data-section]').forEach(item => {
            item.addEventListener('click', function(e) {
                e.preventDefault();
                const section = this.getAttribute('data-section');
                showSection(section);
            });
        });
        
        // Initialize Charts
        document.addEventListener('DOMContentLoaded', function() {
            const priorityCtx = document.getElementById('priorityChart');
            if (priorityCtx) {
                new Chart(priorityCtx, {
                    type: 'doughnut',
                    data: {
                        labels: ['High', 'Medium', 'Low'],
                        datasets: [{
                            data: [3, 9, 12],
                            backgroundColor: [
                                'rgb(220, 53, 69)',
                                'rgb(255, 193, 7)',
                                'rgb(0, 200, 81)'
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
