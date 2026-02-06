<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Reset your Nexus account password - Secure password recovery">
    <title>Forgot Password | Nexus</title>

    <!-- Design System CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/base.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/layout.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/components.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/theme.css">
    
    <!-- External Dependencies -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <style>
        body {
            background: linear-gradient(-45deg, var(--nexus-primary), #1A5276, var(--nexus-accent), #004d7a);
            background-size: 400% 400%;
            animation: gradientBG 15s ease infinite;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: var(--space-4);
        }
        
        @keyframes gradientBG {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }
        
        .auth-card {
            max-width: 480px;
            width: 100%;
            animation: fadeInDown 0.6s ease-out;
        }
        
        @keyframes fadeInDown {
            from {
                opacity: 0;
                transform: translateY(-30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
    </style>
</head>
<body>

    <div class="auth-card">
        <div class="card">
            <div class="card-body" style="padding: var(--space-10);">
                <!-- Logo and Title -->
                <div class="text-center" style="margin-bottom: var(--space-8);">
                    <div class="sidebar-logo-icon" style="margin: 0 auto var(--space-4); width: 80px; height: 80px; font-size: var(--font-4xl);">
                        <i class="bi bi-key-fill"></i>
                    </div>
                    <h1 style="font-size: var(--font-4xl); font-weight: var(--font-extrabold); margin-bottom: var(--space-2);">Forgot Password</h1>
                    <p style="color: var(--nexus-text-secondary); font-weight: var(--font-medium);">Enter your email address and we'll send you a link to reset your password</p>
                </div>

                <form id="forgotPasswordForm" action="<%= request.getContextPath() %>/forgot-password" method="post">
                    <div class="form-group">
                        <label for="email" class="form-label">Email Address</label>
                        <input type="email" name="email" id="email" class="form-control" placeholder="user@nexus.gov" required>
                        <small style="color: var(--nexus-text-secondary); font-size: var(--font-xs); display: block; margin-top: var(--space-2);">
                            We'll send password reset instructions to this email
                        </small>
                    </div>

                    <button type="submit" class="btn btn-primary btn-lg" style="width: 100%;">
                        <i class="bi bi-envelope-fill" style="margin-right: var(--space-2);"></i>
                        Send Reset Link
                    </button>
                </form>

                <div class="text-center" style="margin-top: var(--space-8); padding-top: var(--space-6); border-top: 1px solid var(--nexus-gray-200);">
                    <p style="color: var(--nexus-text-secondary); font-size: var(--font-sm); margin-bottom: var(--space-3);">
                        Remembered your password?
                        <a href="<%= request.getContextPath() %>/views/auth/login.jsp" class="text-link" style="font-weight: var(--font-bold);">
                            Back to Login
                        </a>
                    </p>
                    <a href="<%= request.getContextPath() %>/index.jsp" class="text-link" style="font-size: var(--font-sm);">
                        <i class="bi bi-arrow-left" style="margin-right: var(--space-2);"></i>
                        Back to Homepage
                    </a>
                </div>
            </div>
        </div>
    </div>

    <!-- JavaScript -->
    <script src="${pageContext.request.contextPath}/js/app.js"></script>
    <script>
        document.getElementById('forgotPasswordForm').addEventListener('submit', function(e) {
            // Uncomment below to prevent submission for demo purposes
            // e.preventDefault();
            
            const email = document.getElementById('email').value;
            console.log('Password reset requested for:', email);
            
            // In production, the servlet will handle this
            // and redirect to a confirmation page
        });
    </script>
</body>
</html>
