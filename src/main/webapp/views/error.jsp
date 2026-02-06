<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Error | Nexus</title>

    <!-- Design System CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/base.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/components.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/theme.css">
    
    <!-- External Dependencies -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <style>
        body {
            background: linear-gradient(135deg, var(--nexus-primary) 0%, #1A5276 50%, var(--nexus-accent) 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'Inter', sans-serif;
            padding: var(--space-4);
        }

        .error-container {
            max-width: 600px;
            width: 100%;
            background: var(--nexus-white);
            border-radius: var(--radius-3xl);
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            padding: var(--space-12);
            text-align: center;
            animation: fadeInUp 0.6s ease-out;
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .error-icon {
            width: 120px;
            height: 120px;
            margin: 0 auto var(--space-6);
            background: linear-gradient(135deg, #fee2e2 0%, #fca5a5 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            animation: pulse 2s infinite;
        }

        .error-icon i {
            font-size: 60px;
            color: #dc2626;
        }

        @keyframes pulse {
            0%, 100% {
                transform: scale(1);
            }
            50% {
                transform: scale(1.05);
            }
        }

        .error-code {
            font-size: var(--font-5xl);
            font-weight: var(--font-extrabold);
            color: var(--nexus-primary);
            margin-bottom: var(--space-2);
        }

        .error-title {
            font-size: var(--font-2xl);
            font-weight: var(--font-bold);
            color: var(--nexus-text-primary);
            margin-bottom: var(--space-4);
        }

        .error-message {
            font-size: var(--font-base);
            color: var(--nexus-text-secondary);
            margin-bottom: var(--space-8);
            line-height: 1.6;
        }

        .error-details {
            background-color: var(--nexus-gray-50);
            border-radius: var(--radius-lg);
            padding: var(--space-4);
            margin-bottom: var(--space-8);
            text-align: left;
            font-size: var(--font-sm);
            color: var(--nexus-text-secondary);
            max-height: 200px;
            overflow-y: auto;
        }

        .error-actions {
            display: flex;
            gap: var(--space-4);
            justify-content: center;
            flex-wrap: wrap;
        }

        .btn {
            padding: var(--space-3) var(--space-6);
            border-radius: var(--radius-lg);
            font-weight: var(--font-semibold);
            text-decoration: none;
            transition: all var(--transition-base);
            display: inline-flex;
            align-items: center;
            gap: var(--space-2);
        }

        .btn-primary {
            background-color: var(--nexus-accent);
            color: var(--nexus-white);
            border: 2px solid var(--nexus-accent);
        }

        .btn-primary:hover {
            background-color: var(--nexus-primary);
            border-color: var(--nexus-primary);
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(59, 130, 246, 0.3);
        }

        .btn-secondary {
            background-color: transparent;
            color: var(--nexus-text-primary);
            border: 2px solid var(--nexus-gray-300);
        }

        .btn-secondary:hover {
            background-color: var(--nexus-gray-100);
            border-color: var(--nexus-gray-400);
        }
    </style>
</head>
<body>
    <div class="error-container">
        <div class="error-icon">
            <i class="bi bi-exclamation-triangle-fill"></i>
        </div>

        <div class="error-code">
            <%= request.getAttribute("javax.servlet.error.status_code") != null 
                ? request.getAttribute("javax.servlet.error.status_code") 
                : "Error" %>
        </div>

        <h1 class="error-title">
            <%= request.getAttribute("errorTitle") != null 
                ? request.getAttribute("errorTitle") 
                : "Oops! Something went wrong" %>
        </h1>

        <p class="error-message">
            <%= request.getAttribute("errorMessage") != null 
                ? request.getAttribute("errorMessage") 
                : "We encountered an unexpected error. Our team has been notified and is working on it." %>
        </p>

        <% if (exception != null || request.getAttribute("javax.servlet.error.exception") != null) { %>
        <div class="error-details">
            <strong>Technical Details:</strong><br>
            <code>
                <%= exception != null ? exception.getMessage() 
                    : request.getAttribute("javax.servlet.error.exception") %>
            </code>
        </div>
        <% } %>

        <div class="error-actions">
            <a href="javascript:history.back()" class="btn btn-secondary">
                <i class="bi bi-arrow-left"></i>
                Go Back
            </a>
            <a href="${pageContext.request.contextPath}/" class="btn btn-primary">
                <i class="bi bi-house-door"></i>
                Home Page
            </a>
            <a href="${pageContext.request.contextPath}/views/auth/login.jsp" class="btn btn-secondary">
                <i class="bi bi-box-arrow-in-right"></i>
                Login
            </a>
        </div>
    </div>

    <script>
        // Log error to console for debugging (if available)
        console.error('Page Error:', {
            status: '<%= request.getAttribute("javax.servlet.error.status_code") %>',
            message: '<%= request.getAttribute("errorMessage") %>',
            url: window.location.href
        });
    </script>
</body>
</html>
