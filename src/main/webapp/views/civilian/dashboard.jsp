<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<%
    // AUTH GUARD - Ensures only CIVILIAN role can access this page
    HttpSession sessionObj = request.getSession(false);
    if (sessionObj == null || sessionObj.getAttribute("role") == null ||
            !"CIVILIAN".equals(sessionObj.getAttribute("role"))) {
        response.sendRedirect(request.getContextPath() + "/views/auth/login.jsp?error=Unauthorized+Access");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Civilian Dashboard - Nexus Crime Data & Analytics Hub">
    <title>Civilian Dashboard | Nexus</title>

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
                <a href="#" class="sidebar-nav-item active" data-section="dashboard">
                    <i class="bi bi-house-door"></i>
                    <span>Dashboard</span>
                </a>
                <a href="#" class="sidebar-nav-item" data-section="file-complaint">
                    <i class="bi bi-file-earmark-plus"></i>
                    <span>File Complaint</span>
                </a>
                <a href="${pageContext.request.contextPath}/views/civilian/viewComplaints.jsp" class="sidebar-nav-item">
                    <i class="bi bi-file-text"></i>
                    <span>My Complaints</span>
                </a>
                <a href="${pageContext.request.contextPath}/views/civilian/profile.jsp" class="sidebar-nav-item">
                    <i class="bi bi-person"></i>
                    <span>My Profile</span>
                </a>
                <a href="${pageContext.request.contextPath}/views/civilian/help.jsp" class="sidebar-nav-item">
                    <i class="bi bi-question-circle"></i>
                    <span>Help & Support</span>
                </a>
            </nav>

            <div class="sidebar-footer">
                <div class="sidebar-user">
                    <div class="sidebar-user-avatar">
                        <i class="bi bi-person-circle"></i>
                    </div>
                    <div class="sidebar-user-info">
                        <div class="sidebar-user-name">${sessionScope.username}</div>
                        <div class="sidebar-user-role">Civilian</div>
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
                    <h1 class="page-title">My Dashboard</h1>
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
                            <span class="notification-badge">3</span>
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
            <div class="dashboard-content" id="dashboardView">
                <!-- Welcome Section -->
                <div class="alert alert-info" style="margin-bottom: var(--space-8);">
                    <i class="bi bi-info-circle" style="margin-right: var(--space-2);"></i>
                    <strong>Welcome back, ${sessionScope.username}!</strong> 
                    You can file new complaints, track existing ones, and stay informed about your cases.
                </div>

                <!-- Quick Actions -->
                <div class="quick-actions" style="margin-bottom: var(--space-8);">
                    <a href="#" class="quick-action-card primary" onclick="showSection('file-complaint')">
                        <i class="bi bi-file-earmark-plus"></i>
                        <span>File New Complaint</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/views/civilian/viewComplaints.jsp" class="quick-action-card success">
                        <i class="bi bi-file-text"></i>
                        <span>View My Complaints</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/views/civilian/profile.jsp" class="quick-action-card warning">
                        <i class="bi bi-person"></i>
                        <span>Edit Profile</span>
                    </a>
                    <a href="#" class="quick-action-card danger" onclick="showSection('help')">
                        <i class="bi bi-headset"></i>
                        <span>Get Help</span>
                    </a>
                </div>

                <!-- Stats Grid -->
                <div class="dashboard-stats">
                    <div class="stat-card primary">
                        <div class="stat-card-icon">
                            <i class="bi bi-file-text-fill"></i>
                        </div>
                        <div class="stat-card-content">
                            <div class="stat-card-label">Total Complaints</div>
                            <div class="stat-card-value">12</div>
                            <div class="stat-card-change">Filed this year</div>
                        </div>
                    </div>

                    <div class="stat-card warning">
                        <div class="stat-card-icon">
                            <i class="bi bi-clock-fill"></i>
                        </div>
                        <div class="stat-card-content">
                            <div class="stat-card-label">Pending</div>
                            <div class="stat-card-value">5</div>
                            <div class="stat-card-change">Under investigation</div>
                        </div>
                    </div>

                    <div class="stat-card success">
                        <div class="stat-card-icon">
                            <i class="bi bi-check-circle-fill"></i>
                        </div>
                        <div class="stat-card-content">
                            <div class="stat-card-label">Resolved</div>
                            <div class="stat-card-value">7</div>
                            <div class="stat-card-change">Cases closed</div>
                        </div>
                    </div>

                    <div class="stat-card danger">
                        <div class="stat-card-icon">
                            <i class="bi bi-hourglass-split"></i>
                        </div>
                        <div class="stat-card-content">
                            <div class="stat-card-label">Avg Response Time</div>
                            <div class="stat-card-value">3.5h</div>
                            <div class="stat-card-change">24% faster</div>
                        </div>
                    </div>
                </div>

                <!-- Recent Complaints -->
                <div class="dashboard-row">
                    <div class="dashboard-col-12">
                        <div class="widget">
                            <div class="widget-header">
                                <h3 class="widget-title">Recent Complaints</h3>
                                <div class="widget-actions">
                                    <a href="${pageContext.request.contextPath}/views/civilian/viewComplaints.jsp" class="btn btn-sm btn-primary">
                                        View All
                                    </a>
                                </div>
                            </div>
                            <div class="widget-body">
                                <table class="dashboard-table">
                                    <thead>
                                        <tr>
                                            <th>Complaint ID</th>
                                            <th>Type</th>
                                            <th>Description</th>
                                            <th>Status</th>
                                            <th>Filed Date</th>
                                            <th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td><strong>#C1234</strong></td>
                                            <td><span class="badge badge-primary">Theft</span></td>
                                            <td>Stolen vehicle from parking lot</td>
                                            <td><span class="badge badge-warning">Under Investigation</span></td>
                                            <td>2024-01-20</td>
                                            <td>
                                                <button class="btn btn-sm btn-ghost" title="View Details"><i class="bi bi-eye"></i></button>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td><strong>#C1189</strong></td>
                                            <td><span class="badge badge-danger">Assault</span></td>
                                            <td>Physical altercation reported</td>
                                            <td><span class="badge badge-success">Resolved</span></td>
                                            <td>2024-01-15</td>
                                            <td>
                                                <button class="btn btn-sm btn-ghost" title="View Details"><i class="bi bi-eye"></i></button>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td><strong>#C1056</strong></td>
                                            <td><span class="badge badge-warning">Vandalism</span></td>
                                            <td>Property damage in neighborhood</td>
                                            <td><span class="badge badge-primary">Assigned to Officer</span></td>
                                            <td>2024-01-10</td>
                                            <td>
                                                <button class="btn btn-sm btn-ghost" title="View Details"><i class="bi bi-eye"></i></button>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- File Complaint Form (Hidden by default) -->
            <div class="dashboard-content" id="fileComplaintView" style="display: none;">
                <div class="dashboard-row">
                    <div class="dashboard-col-12">
                        <div class="widget">
                            <div class="widget-header">
                                <h3 class="widget-title">File New Complaint</h3>
                                <button class="btn btn-sm btn-ghost" onclick="showSection('dashboard')">
                                    <i class="bi bi-x"></i> Cancel
                                </button>
                            </div>
                            <div class="widget-body">
                                <form action="${pageContext.request.contextPath}/complaint/submit" method="post" enctype="multipart/form-data">
                                    <div class="grid md:grid-cols-2 gap-4">
                                        <div class="form-group">
                                            <label for="complaintType" class="form-label">Complaint Type</label>
                                            <select name="complaint_type" id="complaintType" class="form-select" required>
                                                <option value="">-- Select Type --</option>
                                                <option value="THEFT">Theft</option>
                                                <option value="ASSAULT">Assault</option>
                                                <option value="VANDALISM">Vandalism</option>
                                                <option value="FRAUD">Fraud</option>
                                                <option value="HARASSMENT">Harassment</option>
                                                <option value="OTHER">Other</option>
                                            </select>
                                        </div>

                                        <div class="form-group">
                                            <label for="incidentDate" class="form-label">Incident Date</label>
                                            <input type="date" name="incident_date" id="incidentDate" class="form-control" required>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label for="location" class="form-label">Location</label>
                                        <input type="text" name="location" id="location" class="form-control" placeholder="Enter incident location" required>
                                    </div>

                                    <div class="form-group">
                                        <label for="description" class="form-label">Description</label>
                                        <textarea name="description" id="description" class="form-control" rows="5" placeholder="Provide detailed description of the incident..." required></textarea>
                                    </div>

                                    <div class="form-group">
                                        <label for="evidence" class="form-label">Upload Evidence (Optional)</label>
                                        <input type="file" name="evidence" id="evidence" class="form-control" accept="image/*,video/*,application/pdf" multiple>
                                        <small style="color: var(--nexus-text-secondary); display: block; margin-top: var(--space-2);">
                                            Accepted formats: Images, Videos, PDF (Max 10MB per file)
                                        </small>
                                    </div>

                                    <div class="flex gap-3 justify-end" style="margin-top: var(--space-6);">
                                        <button type="button" class="btn btn-secondary" onclick="showSection('dashboard')">Cancel</button>
                                        <button type="submit" class="btn btn-primary">
                                            <i class="bi bi-send"></i> Submit Complaint
                                        </button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Help Section (Hidden by default) -->
            <div class="dashboard-content" id="helpView" style="display: none;">
                <div class="dashboard-row">
                    <div class="dashboard-col-12">
                        <div class="widget">
                            <div class="widget-header">
                                <h3 class="widget-title">Help & Support</h3>
                                <button class="btn btn-sm btn-ghost" onclick="showSection('dashboard')">
                                    <i class="bi bi-x"></i> Close
                                </button>
                            </div>
                            <div class="widget-body">
                                <div style="padding: var(--space-6);">
                                    <h4>Frequently Asked Questions</h4>
                                    <div class="accordion" style="margin-top: var(--space-4);">
                                        <div class="accordion-item">
                                            <strong>Q: How do I track my complaint?</strong>
                                            <p>Navigate to "My Complaints" from the sidebar to view all your filed complaints and their current status.</p>
                                        </div>
                                        <div class="accordion-item">
                                            <strong>Q: What evidence can I upload?</strong>
                                            <p>You can upload images, videos, and PDF documents. Each file should be under 10MB.</p>
                                        </div>
                                        <div class="accordion-item">
                                            <strong>Q: How long does it take to process a complaint?</strong>
                                            <p>Average response time is 3-4 hours. You'll receive notifications as your case progresses.</p>
                                        </div>
                                    </div>
                                    <div style="margin-top: var(--space-6); padding: var(--space-4); background: var(--nexus-bg-secondary); border-radius: var(--radius-lg);">
                                        <h5>Emergency Contact</h5>
                                        <p>For immediate assistance, call: <strong>100 / 112</strong></p>
                                        <p>Email: <a href="mailto:support@nexus.gov">support@nexus.gov</a></p>
                                    </div>
                                </div>
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
        function showSection(section) {
            // Hide all views
            document.getElementById('dashboardView').style.display = 'none';
            document.getElementById('fileComplaintView').style.display = 'none';
            document.getElementById('helpView').style.display = 'none';
            
            // Show selected view
            if (section === 'dashboard') {
                document.getElementById('dashboardView').style.display = 'block';
            } else if (section === 'file-complaint') {
                document.getElementById('fileComplaintView').style.display = 'block';
            } else if (section === 'help') {
                document.getElementById('helpView').style.display = 'block';
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
    </script>
</body>
</html>
