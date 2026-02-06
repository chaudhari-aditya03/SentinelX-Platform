<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>404 - Page Not Found | Nexus</title>

    <!-- Design System CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/base.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/components.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/theme.css">
    
    <!-- External Dependencies -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'Inter', sans-serif;
            padding: var(--space-4);
            overflow: hidden;
            position: relative;
        }

        /* Animated Background */
        .background-animation {
            position: absolute;
            width: 100%;
            height: 100%;
            overflow: hidden;
            z-index: 0;
        }

        .circle {
            position: absolute;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.1);
            animation: float 20s infinite;
        }

        .circle:nth-child(1) {
            width: 80px;
            height: 80px;
            left: 10%;
            top: 20%;
            animation-delay: 0s;
        }

        .circle:nth-child(2) {
            width: 120px;
            height: 120px;
            right: 10%;
            top: 30%;
            animation-delay: 2s;
        }

        .circle:nth-child(3) {
            width: 60px;
            height: 60px;
            left: 50%;
            bottom: 20%;
            animation-delay: 4s;
        }

        .circle:nth-child(4) {
            width: 100px;
            height: 100px;
            right: 30%;
            bottom: 10%;
            animation-delay: 6s;
        }

        @keyframes float {
            0%, 100% {
                transform: translateY(0) translateX(0) scale(1);
            }
            25% {
                transform: translateY(-50px) translateX(30px) scale(1.1);
            }
            50% {
                transform: translateY(-100px) translateX(-30px) scale(0.9);
            }
            75% {
                transform: translateY(-50px) translateX(30px) scale(1.1);
            }
        }

        .error-container {
            max-width: 700px;
            width: 100%;
            background: var(--nexus-white);
            border-radius: var(--radius-3xl);
            box-shadow: 0 25px 70px rgba(0, 0, 0, 0.4);
            padding: var(--space-12);
            text-align: center;
            animation: fadeInUp 0.8s ease-out;
            position: relative;
            z-index: 1;
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(40px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .error-illustration {
            margin-bottom: var(--space-8);
            position: relative;
        }

        .error-code {
            font-size: 150px;
            font-weight: var(--font-extrabold);
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            line-height: 1;
            margin-bottom: var(--space-2);
            animation: glitch 3s infinite;
        }

        @keyframes glitch {
            0%, 90%, 100% {
                transform: translate(0);
            }
            92% {
                transform: translate(-2px, 2px);
            }
            94% {
                transform: translate(2px, -2px);
            }
            96% {
                transform: translate(-2px, -2px);
            }
            98% {
                transform: translate(2px, 2px);
            }
        }

        .error-title {
            font-size: var(--font-3xl);
            font-weight: var(--font-bold);
            color: var(--nexus-text-primary);
            margin-bottom: var(--space-4);
        }

        .error-message {
            font-size: var(--font-lg);
            color: var(--nexus-text-secondary);
            margin-bottom: var(--space-8);
            line-height: 1.7;
        }

        .search-box {
            max-width: 500px;
            margin: 0 auto var(--space-8);
        }

        .search-input {
            width: 100%;
            padding: var(--space-4) var(--space-6);
            border: 2px solid var(--nexus-gray-300);
            border-radius: var(--radius-full);
            font-size: var(--font-base);
            transition: all var(--transition-base);
        }

        .search-input:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 4px rgba(102, 126, 234, 0.1);
        }

        .quick-links {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
            gap: var(--space-4);
            margin-bottom: var(--space-8);
        }

        .quick-link {
            padding: var(--space-4);
            background: var(--nexus-gray-50);
            border-radius: var(--radius-lg);
            text-decoration: none;
            color: var(--nexus-text-primary);
            transition: all var(--transition-base);
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: var(--space-2);
        }

        .quick-link:hover {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(102, 126, 234, 0.3);
        }

        .quick-link i {
            font-size: var(--font-2xl);
        }

        .btn {
            padding: var(--space-4) var(--space-8);
            border-radius: var(--radius-full);
            font-weight: var(--font-semibold);
            text-decoration: none;
            transition: all var(--transition-base);
            display: inline-flex;
            align-items: center;
            gap: var(--space-2);
            font-size: var(--font-base);
        }

        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
        }

        .btn-primary:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 30px rgba(102, 126, 234, 0.4);
        }
    </style>
</head>
<body>
    <div class="background-animation">
        <div class="circle"></div>
        <div class="circle"></div>
        <div class="circle"></div>
        <div class="circle"></div>
    </div>

    <div class="error-container">
        <div class="error-illustration">
            <div class="error-code">404</div>
        </div>

        <h1 class="error-title">Page Not Found</h1>

        <p class="error-message">
            Oops! The page you're looking for seems to have wandered off. 
            Don't worry, let's help you find your way back.
        </p>

        <div class="search-box">
            <input 
                type="text" 
                class="search-input" 
                placeholder="Search for what you need..."
                id="searchInput">
        </div>

        <div class="quick-links">
            <a href="${pageContext.request.contextPath}/" class="quick-link">
                <i class="bi bi-house-door"></i>
                <span>Home</span>
            </a>
            <a href="${pageContext.request.contextPath}/views/auth/login.jsp" class="quick-link">
                <i class="bi bi-box-arrow-in-right"></i>
                <span>Login</span>
            </a>
            <a href="${pageContext.request.contextPath}/views/about.jsp" class="quick-link">
                <i class="bi bi-info-circle"></i>
                <span>About</span>
            </a>
            <a href="${pageContext.request.contextPath}/views/contactus.jsp" class="quick-link">
                <i class="bi bi-envelope"></i>
                <span>Contact</span>
            </a>
        </div>

        <a href="javascript:history.back()" class="btn btn-primary">
            <i class="bi bi-arrow-left"></i>
            Go Back to Previous Page
        </a>
    </div>

    <script>
        // Simple search functionality
        document.getElementById('searchInput').addEventListener('keypress', function(e) {
            if (e.key === 'Enter') {
                const query = this.value.toLowerCase();
                if (query.includes('login')) {
                    window.location.href = '${pageContext.request.contextPath}/views/auth/login.jsp';
                } else if (query.includes('home')) {
                    window.location.href = '${pageContext.request.contextPath}/';
                } else if (query.includes('about')) {
                    window.location.href = '${pageContext.request.contextPath}/views/about.jsp';
                } else if (query.includes('contact')) {
                    window.location.href = '${pageContext.request.contextPath}/views/contactus.jsp';
                } else {
                    window.location.href = '${pageContext.request.contextPath}/';
                }
            }
        });
    </script>
</body>
</html>
