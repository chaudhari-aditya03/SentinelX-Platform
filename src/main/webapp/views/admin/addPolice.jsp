<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Police Officer | Admin - Nexus Hub</title>

    <!-- Design System CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/base.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/layout.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/components.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/theme.css">

    <style>
        .form-wrapper {
            max-width: 600px;
            margin: var(--space-12) auto;
            padding: var(--space-8);
            background: white;
            border-radius: var(--radius-2xl);
            box-shadow: var(--shadow-md);
        }

        .form-group {
            margin-bottom: var(--space-6);
        }

        .form-label {
            display: block;
            margin-bottom: var(--space-2);
            font-weight: var(--fw-600);
            color: var(--nexus-dark);
            font-size: var(--text-sm);
        }

        .form-input {
            width: 100%;
            padding: var(--space-3) var(--space-4);
            border: 1px solid #ddd;
            border-radius: var(--radius-lg);
            font-family: inherit;
            font-size: var(--text-base);
            transition: border-color 0.3s, box-shadow 0.3s;
        }

        .form-input:focus {
            outline: none;
            border-color: var(--nexus-fresh);
            box-shadow: 0 0 0 3px rgba(0, 139, 230, 0.1);
        }

        .form-actions {
            display: flex;
            gap: var(--space-4);
            margin-top: var(--space-8);
        }

        .required-indicator {
            color: #ef4444;
            font-weight: var(--fw-700);
        }
    </style>
</head>
<body>

<div class="page-container">
    <div class="form-wrapper">
        <h1 class="text-2xl font-bold mb-8 text-dark">
            <i class="bi bi-person-badge me-2"></i>Add Police Officer
        </h1>

        <form action="${pageContext.request.contextPath}/admin/add-police" method="post">
            <div class="form-group">
                <label class="form-label">
                    Full Name <span class="required-indicator">*</span>
                </label>
                <input type="text" name="fullName" class="form-input" required placeholder="Enter officer's full name">
            </div>

            <div class="form-group">
                <label class="form-label">
                    Email <span class="required-indicator">*</span>
                </label>
                <input type="email" name="email" class="form-input" required placeholder="Enter email address">
            </div>

            <div class="form-group">
                <label class="form-label">
                    Phone <span class="required-indicator">*</span>
                </label>
                <input type="text" name="phone" class="form-input" required placeholder="Enter phone number">
            </div>

            <div class="form-group">
                <label class="form-label">
                    Rank <span class="required-indicator">*</span>
                </label>
                <input type="text" name="rankDetails" class="form-input" required placeholder="Enter rank (e.g., Constable, Inspector)">
            </div>

            <div class="form-group">
                <label class="form-label">
                    Police Station ID <span class="required-indicator">*</span>
                </label>
                <input type="number" name="policeStationId" class="form-input" required placeholder="Enter station ID">
            </div>

            <div class="form-group">
                <label class="form-label">
                    Temporary Password <span class="required-indicator">*</span>
                </label>
                <input type="password" name="password" class="form-input" required placeholder="Enter temporary password">
            </div>

            <div class="form-actions">
                <button type="submit" class="btn btn-primary">
                    <i class="bi bi-check-circle me-2"></i>Add Officer
                </button>
                <a href="${pageContext.request.contextPath}/admin/user-management" class="btn btn-outline">
                    <i class="bi bi-x-circle me-2"></i>Cancel
                </a>
            </div>
        </form>
    </div>
</div>

<script src="${pageContext.request.contextPath}/js/app.js"></script>
</body>
</html>
