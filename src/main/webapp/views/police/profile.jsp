<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

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
    <meta name="description" content="Police Officer Profile - Nexus Crime Data & Analytics Hub">
    <title>Officer Profile | Nexus</title>

    <!-- Design System CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/base.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/layout.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/components.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/dashboard.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/theme.css">
    
    <!-- External Dependencies -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <style>
        .profile-header {
            background: linear-gradient(135deg, var(--nexus-primary) 0%, var(--nexus-accent) 100%);
            color: white;
            padding: var(--space-12) var(--space-6);
            border-radius: var(--radius-2xl);
            margin-bottom: var(--space-8);
            box-shadow: var(--shadow-lg);
        }

        .profile-avatar {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            border: 5px solid white;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
            object-fit: cover;
            margin: 0 auto var(--space-4);
            display: block;
        }

        .profile-info {
            text-align: center;
        }

        .profile-name {
            font-size: var(--font-3xl);
            font-weight: var(--font-extrabold);
            margin-bottom: var(--space-2);
        }

        .profile-badge {
            font-size: var(--font-lg);
            font-weight: var(--font-semibold);
            color: rgba(255, 255, 255, 0.9);
            margin-bottom: var(--space-4);
        }

        .profile-stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
            gap: var(--space-4);
            margin-top: var(--space-6);
        }

        .stat-item {
            background: rgba(255, 255, 255, 0.15);
            backdrop-filter: blur(10px);
            padding: var(--space-4);
            border-radius: var(--radius-lg);
            text-align: center;
        }

        .stat-value {
            font-size: var(--font-2xl);
            font-weight: var(--font-bold);
            display: block;
        }

        .stat-label {
            font-size: var(--font-sm);
            opacity: 0.9;
            margin-top: var(--space-2);
        }

        .profile-section {
            background: white;
            padding: var(--space-8);
            border-radius: var(--radius-2xl);
            box-shadow: var(--shadow-md);
            margin-bottom: var(--space-6);
        }

        .section-title {
            font-size: var(--font-xl);
            font-weight: var(--font-bold);
            color: var(--nexus-primary);
            margin-bottom: var(--space-6);
            padding-bottom: var(--space-3);
            border-bottom: 3px solid var(--nexus-accent);
            display: flex;
            align-items: center;
            gap: var(--space-3);
        }

        .info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: var(--space-6);
        }

        .info-item {
            display: flex;
            flex-direction: column;
        }

        .info-label {
            font-size: var(--font-sm);
            font-weight: var(--font-semibold);
            color: var(--nexus-text-secondary);
            margin-bottom: var(--space-2);
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .info-value {
            font-size: var(--font-base);
            color: var(--nexus-text-primary);
            padding: var(--space-3) var(--space-4);
            background-color: var(--nexus-gray-50);
            border-radius: var(--radius-lg);
            font-weight: var(--font-medium);
        }

        .status-badge {
            display: inline-block;
            padding: var(--space-2) var(--space-4);
            border-radius: var(--radius-full);
            font-size: var(--font-sm);
            font-weight: var(--font-semibold);
        }

        .status-active {
            background-color: #d1fae5;
            color: #065f46;
        }

        .status-inactive {
            background-color: #fee2e2;
            color: #991b1b;
        }
    </style>
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
                <a href="${pageContext.request.contextPath}/police/dashboard" class="sidebar-nav-item">
                    <i class="bi bi-speedometer2"></i>
                    <span>Dashboard</span>
                </a>
                <a href="#" class="sidebar-nav-item">
                    <i class="bi bi-inbox-fill"></i>
                    <span>Case Assignments</span>
                </a>
                <a href="#" class="sidebar-nav-item">
                    <i class="bi bi-search"></i>
                    <span>Investigations</span>
                </a>
                <a href="#" class="sidebar-nav-item">
                    <i class="bi bi-graph-up-arrow"></i>
                    <span>Crime Analytics</span>
                </a>
                <a href="#" class="sidebar-nav-item">
                    <i class="bi bi-file-earmark-text"></i>
                    <span>Reports</span>
                </a>
                <a href="${pageContext.request.contextPath}/views/police/profile.jsp" class="sidebar-nav-item active">
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
                        <div class="sidebar-user-name">${sessionScope.user_name}</div>
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
                    <h1 class="page-title">Officer Profile</h1>
                </div>
                
                <div class="navbar-right">
                    <div class="navbar-item">
                        <button class="btn-icon" aria-label="Notifications">
                            <i class="bi bi-bell"></i>
                            <span class="badge">3</span>
                        </button>
                    </div>
                </div>
            </header>

            <!-- Profile Content -->
            <div class="content-wrapper">
                <!-- Profile Header -->
                <div class="profile-header">
                    <div class="profile-info">
                        <img 
                            src="${pageContext.request.contextPath}/uploads/profile/police_${sessionScope.police_reg_id}.jpg" 
                            onerror="this.src='https://cdn-icons-png.flaticon.com/512/3135/3135768.png'"
                            class="profile-avatar"
                            alt="Officer Photo">
                        <h1 class="profile-name">${sessionScope.user_name}</h1>
                        <p class="profile-badge">
                            <i class="bi bi-shield-fill"></i>
                            ${sessionScope.user.rankDetails != null ? sessionScope.user.rankDetails : 'Police Officer'}
                        </p>
                        <span class="status-badge status-active">Active Duty</span>

                        <div class="profile-stats">
                            <div class="stat-item">
                                <span class="stat-value">42</span>
                                <span class="stat-label">Cases Resolved</span>
                            </div>
                            <div class="stat-item">
                                <span class="stat-value">12</span>
                                <span class="stat-label">Active Cases</span>
                            </div>
                            <div class="stat-item">
                                <span class="stat-value">98%</span>
                                <span class="stat-label">Success Rate</span>
                            </div>
                            <div class="stat-item">
                                <span class="stat-value">5</span>
                                <span class="stat-label">Years Service</span>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Personal Information -->
                <div class="profile-section">
                    <h2 class="section-title">
                        <i class="bi bi-person-vcard"></i>
                        Personal Information
                    </h2>
                    <div class="info-grid">
                        <div class="info-item">
                            <span class="info-label">Full Name</span>
                            <span class="info-value">${sessionScope.user_name}</span>
                        </div>
                        <div class="info-item">
                            <span class="info-label">Email</span>
                            <span class="info-value">${sessionScope.user.email != null ? sessionScope.user.email : 'N/A'}</span>
                        </div>
                        <div class="info-item">
                            <span class="info-label">Phone</span>
                            <span class="info-value">${sessionScope.user.phone != null ? sessionScope.user.phone : 'N/A'}</span>
                        </div>
                        <div class="info-item">
                            <span class="info-label">Badge Number</span>
                            <span class="info-value">${sessionScope.user.badgeNumber != null ? sessionScope.user.badgeNumber : 'N/A'}</span>
                        </div>
                    </div>
                </div>

                <!-- Service Information -->
                <div class="profile-section">
                    <h2 class="section-title">
                        <i class="bi bi-award"></i>
                        Service Information
                    </h2>
                    <div class="info-grid">
                        <div class="info-item">
                            <span class="info-label">Rank</span>
                            <span class="info-value">${sessionScope.user.rankDetails != null ? sessionScope.user.rankDetails : 'Police Officer'}</span>
                        </div>
                        <div class="info-item">
                            <span class="info-label">Station</span>
                            <span class="info-value">${sessionScope.user.stationName != null ? sessionScope.user.stationName : 'Central Station'}</span>
                        </div>
                        <div class="info-item">
                            <span class="info-label">Department</span>
                            <span class="info-value">Criminal Investigation</span>
                        </div>
                        <div class="info-item">
                            <span class="info-label">Approval Status</span>
                            <span class="info-value">
                                <span class="status-badge status-active">Approved</span>
                            </span>
                        </div>
                    </div>
                </div>

                <!-- Contact Information -->
                <div class="profile-section">
                    <h2 class="section-title">
                        <i class="bi bi-geo-alt"></i>
                        Contact & Location
                    </h2>
                    <div class="info-grid">
                        <div class="info-item">
                            <span class="info-label">Station Address</span>
                            <span class="info-value">${sessionScope.user.stationAddress != null ? sessionScope.user.stationAddress : 'Central Police Station'}</span>
                        </div>
                        <div class="info-item">
                            <span class="info-label">Emergency Contact</span>
                            <span class="info-value">+1 (555) 123-4567</span>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>

    <!-- Scripts -->
    <script src="${pageContext.request.contextPath}/js/layout.js"></script>
    <script src="${pageContext.request.contextPath}/js/dashboard.js"></script>
</body>
</html>
