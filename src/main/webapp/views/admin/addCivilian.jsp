<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Add a new civilian record - Nexus Admin Panel">
    <title>Add Civilian | Admin - Nexus</title>

    <!-- Design System CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/base.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/layout.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/components.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/theme.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/enhancements.css">
    
    <!-- External Dependencies -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <style>
        body {
            background-color: var(--nexus-bg-primary);
            padding: var(--space-6);
        }

        .page-header {
            margin-bottom: var(--space-8);
            display: flex;
            align-items: center;
            gap: var(--space-4);
        }

        .page-header-icon {
            font-size: var(--font-4xl);
            color: var(--nexus-accent);
        }

        .page-header-content h1 {
            margin: 0;
            font-size: var(--font-3xl);
            color: var(--nexus-text-primary);
        }

        .page-header-content p {
            margin: 0;
            color: var(--nexus-text-secondary);
            font-size: var(--font-sm);
        }

        .form-container {
            max-width: 600px;
            margin: 0 auto;
            background: var(--nexus-white);
            border-radius: var(--radius-lg);
            box-shadow: var(--shadow-md);
            overflow: hidden;
        }

        .form-header {
            background: linear-gradient(135deg, var(--nexus-primary), var(--nexus-accent));
            padding: var(--space-6);
            color: var(--nexus-white);
            border-bottom: 3px solid var(--nexus-accent);
        }

        .form-content {
            padding: var(--space-8);
        }

        .form-section {
            margin-bottom: var(--space-8);
        }

        .form-section-title {
            font-size: var(--font-lg);
            font-weight: var(--font-semibold);
            color: var(--nexus-text-primary);
            margin-bottom: var(--space-4);
            padding-bottom: var(--space-3);
            border-bottom: 2px solid var(--nexus-gray-200);
            display: flex;
            align-items: center;
            gap: var(--space-2);
        }

        .form-section-title i {
            color: var(--nexus-accent);
        }

        .form-row {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: var(--space-4);
        }

        .form-row.full {
            grid-template-columns: 1fr;
        }

        @media (max-width: 768px) {
            .form-row {
                grid-template-columns: 1fr;
            }

            .form-content {
                padding: var(--space-6);
            }
        }

        .form-actions {
            display: flex;
            gap: var(--space-3);
            margin-top: var(--space-8);
            padding-top: var(--space-6);
            border-top: 1px solid var(--nexus-gray-200);
        }

        .form-actions .btn {
            flex: 1;
        }

        .breadcrumb-nav {
            margin-bottom: var(--space-6);
            font-size: var(--font-sm);
        }

        .breadcrumb-nav a {
            color: var(--nexus-accent);
            text-decoration: none;
            transition: color var(--transition-fast);
        }

        .breadcrumb-nav a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

<div class="container" style="max-width: 700px;">
    <!-- Breadcrumb -->
    <nav class="breadcrumb-nav">
        <a href="${pageContext.request.contextPath}/views/admin/dashboard.jsp">
            <i class="bi bi-house-door"></i> Dashboard
        </a>
        <span style="margin: 0 var(--space-2);">/</span>
        <a href="${pageContext.request.contextPath}/views/admin/userManagement.jsp">User Management</a>
        <span style="margin: 0 var(--space-2);">/</span>
        <span style="color: var(--nexus-text-secondary);">Add Civilian</span>
    </nav>

    <!-- Page Header -->
    <div class="page-header">
        <i class="bi bi-person-plus-fill page-header-icon"></i>
        <div class="page-header-content">
            <h1>Register New Civilian</h1>
            <p>Add a new civilian member to the Nexus system</p>
        </div>
    </div>

    <!-- Form Card -->
    <div class="form-container">
        <div class="form-header">
            <h2 style="margin: 0; font-size: var(--font-2xl); display: flex; align-items: center; gap: var(--space-3);">
                <i class="bi bi-person-circle"></i>
                Civilian Registration
            </h2>
            <p style="margin: var(--space-2) 0 0 0; color: rgba(255,255,255,0.9); font-size: var(--font-sm);">
                Fill in the required information to register a new civilian account
            </p>
        </div>

        <div class="form-content">
            <form action="${pageContext.request.contextPath}/admin/add-civilian" method="post" id="addCivilianForm">
                <!-- Basic Information Section -->
                <div class="form-section">
                    <div class="form-section-title">
                        <i class="bi bi-info-circle"></i> Basic Information
                    </div>
                    <div class="form-group">
                        <label for="fullName" class="form-label form-label-required">Full Name</label>
                        <input type="text" name="fullName" id="fullName" class="form-control" placeholder="Enter complete full name" required>
                        <small class="form-text">As shown in official documents</small>
                    </div>
                </div>

                <!-- Contact Information Section -->
                <div class="form-section">
                    <div class="form-section-title">
                        <i class="bi bi-telephone"></i> Contact Information
                    </div>
                    <div class="form-row">
                        <div class="form-group">
                            <label for="email" class="form-label form-label-required">Email Address</label>
                            <input type="email" name="email" id="email" class="form-control" placeholder="user@example.com" required>
                        </div>
                        <div class="form-group">
                            <label for="phone" class="form-label form-label-required">Phone Number</label>
                            <input type="tel" name="phone" id="phone" class="form-control" placeholder="+1 (555) 000-0000" required>
                        </div>
                    </div>
                </div>

                <!-- Identification Section -->
                <div class="form-section">
                    <div class="form-section-title">
                        <i class="bi bi-card-text"></i> Identification
                    </div>
                    <div class="form-row">
                        <div class="form-group">
                            <label for="nationalId" class="form-label form-label-required">National ID Number</label>
                            <input type="text" name="nationalId" id="nationalId" class="form-control" placeholder="XX-XXXXXXXXX-X" required>
                        </div>
                        <div class="form-group">
                            <label for="dob" class="form-label form-label-required">Date of Birth</label>
                            <input type="date" name="dob" id="dob" class="form-control" required>
                        </div>
                    </div>
                </div>

                <!-- Account Security Section -->
                <div class="form-section">
                    <div class="form-section-title">
                        <i class="bi bi-lock"></i> Account Security
                    </div>
                    <div class="form-group">
                        <label for="password" class="form-label form-label-required">Temporary Password</label>
                        <input type="password" name="password" id="password" class="form-control" placeholder="Enter a temporary password" required>
                        <small class="form-text">User will be prompted to change this password on first login</small>
                    </div>
                </div>

                <!-- Form Actions -->
                <div class="form-actions">
                    <button type="submit" class="btn btn-primary btn-lg">
                        <i class="bi bi-check-circle"></i> Add Civilian
                    </button>
                    <a href="${pageContext.request.contextPath}/views/admin/userManagement.jsp" class="btn btn-outline">
                        <i class="bi bi-x-circle"></i> Cancel
                    </a>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- External Scripts -->
<script src="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap"></script>
<script src="${pageContext.request.contextPath}/js/app.js"></script>

<script>
    // Form validation
    document.getElementById('addCivilianForm').addEventListener('submit', function(e) {
        const email = document.getElementById('email').value;
        const phone = document.getElementById('phone').value;
        
        // Basic email validation
        if (!email.match(/^[^\s@]+@[^\s@]+\.[^\s@]+$/)) {
            alert('Please enter a valid email address');
            e.preventDefault();
            return;
        }
        
        // Phone validation (basic)
        if (phone.replace(/\D/g, '').length < 10) {
            alert('Please enter a valid phone number');
            e.preventDefault();
            return;
        }
    });
</script>
</body>
</html>
