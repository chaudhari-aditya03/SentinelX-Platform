<!DOCTYPE html>
<html lang="en">
<head>
    <!-- Meta Tags for SEO -->
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Nexus - Advanced Crime Data Management and Analytics Hub. Connecting civilians, law enforcement, and data science for safer communities.">
    <meta name="author" content="Nexus Crime Data & Analytics Hub">

    <title>Nexus - Crime Data & Analytics Hub | Intelligent Policing Platform</title>

    <!-- External Dependencies (Fonts & Icons) -->
    <link rel="stylesheet" href="styles/enhancements.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <style>
        /* --- CSS VARIABLES & THEME --- */
        :root {
            /* Palette */
            --nexus-primary: #0f172a;       /* Deep Slate */
            --nexus-secondary: #1e293b;     /* Lighter Slate */
            --nexus-accent: #3b82f6;        /* Bright Blue */
            --nexus-accent-dark: #1d4ed8;
            --nexus-success: #10b981;       /* Emerald */
            --nexus-warning: #f59e0b;       /* Amber */
            --nexus-white: #ffffff;
            --nexus-text-main: #334155;
            --nexus-text-light: #64748b;
            --nexus-bg-light: #f8fafc;

            /* Spacing & Layout */
            --container-width: 1200px;
            --header-height: 80px;
            --radius-md: 12px;
            --radius-lg: 20px;
            --shadow-card: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
        }

        /* --- RESET & BASE --- */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', sans-serif;
            background-color: var(--nexus-white);
            color: var(--nexus-text-main);
            line-height: 1.6;
            overflow-x: hidden;
        }

        a { text-decoration: none; color: inherit; transition: 0.3s; }
        ul { list-style: none; }
        img { max-width: 100%; }

        /* --- UTILITIES --- */
        .container {
            max-width: var(--container-width);
            margin: 0 auto;
            padding: 0 20px;
        }

        .section { padding: 100px 0; }
        .text-center { text-align: center; }
        .flex { display: flex; }
        .items-center { align-items: center; }
        .justify-between { justify-content: space-between; }
        .gap-3 { gap: 12px; }
        .mb-4 { margin-bottom: 16px; }

        /* Grid System */
        .grid {
            display: grid;
            gap: 2rem;
        }

        @media (min-width: 768px) {
            .grid-3 { grid-template-columns: repeat(3, 1fr); }
            .grid-4 { grid-template-columns: repeat(4, 1fr); }
            .hidden-mobile { display: flex !important; }
            .hidden-desktop { display: none !important; }
        }

        @media (max-width: 767px) {
            .grid-3, .grid-4 { grid-template-columns: 1fr; }
            .hidden-mobile { display: none !important; }
            .hidden-desktop { display: block !important; }
            .navbar-menu {
                position: absolute;
                top: 100%;
                left: 0;
                width: 100%;
                background: var(--nexus-white);
                flex-direction: column;
                padding: 20px;
                box-shadow: 0 10px 20px rgba(0,0,0,0.1);
                display: none;
            }
            .navbar-menu.active { display: flex; }
            .nav-item { margin-bottom: 15px; }
        }

        /* --- BUTTONS --- */
        .btn {
            display: inline-block;
            padding: 10px 24px;
            border-radius: 50px;
            font-weight: 600;
            cursor: pointer;
            border: 2px solid transparent;
        }

        .btn-primary {
            background-color: var(--nexus-accent);
            color: white;
        }
        .btn-primary:hover { background-color: var(--nexus-accent-dark); }

        .btn-ghost {
            color: var(--nexus-primary);
            background: transparent;
        }
        .btn-ghost:hover { background: var(--nexus-bg-light); }

        /* --- NAVIGATION --- */
        .navbar {
            height: var(--header-height);
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            z-index: 1000;
            box-shadow: 0 1px 3px rgba(0,0,0,0.05);
        }

        .navbar-container {
            display: flex;
            align-items: center;
            justify-content: space-between;
            height: 100%;
        }

        .logo {
            font-size: 1.5rem;
            font-weight: 800;
            color: var(--nexus-primary);
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .nav-link {
            font-weight: 500;
            color: var(--nexus-text-main);
            padding: 8px 16px;
        }
        .nav-link:hover, .nav-link.active { color: var(--nexus-accent); }

        .mobile-toggle {
            font-size: 1.5rem;
            background: none;
            border: none;
            cursor: pointer;
            color: var(--nexus-primary);
        }

        /* --- HERO SECTION --- */
        .hero {
            position: relative;
            background: linear-gradient(-45deg, #0f172a, #1e3a8a, #3b82f6, #0ea5e9);
            background-size: 400% 400%;
            animation: gradientBG 15s ease infinite;
            color: var(--nexus-white);
            padding: 180px 0 140px 0;
            border-bottom-left-radius: 60px;
            border-bottom-right-radius: 60px;
            overflow: hidden;
            margin-bottom: 60px;
        }

        @keyframes gradientBG {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        .hero-content {
            position: relative;
            z-index: 2;
        }

        .hero h1 {
            font-size: 4rem;
            font-weight: 800;
            letter-spacing: -1px;
            margin-bottom: 20px;
            line-height: 1.1;
        }

        .hero p {
            font-size: 1.25rem;
            opacity: 0.9;
            max-width: 700px;
            margin: 0 auto 40px;
        }

        /* Hero Animation Circles */
        .circles {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            overflow: hidden;
            z-index: 1;
        }
        .circles li {
            position: absolute;
            display: block;
            list-style: none;
            width: 20px;
            height: 20px;
            background: rgba(255, 255, 255, 0.2);
            animation: floatUp 25s linear infinite;
            bottom: -150px;
            border-radius: 50%; /* Changed to circles for smoother look */
        }
        .circles li:nth-child(1) { left: 25%; width: 80px; height: 80px; animation-delay: 0s; }
        .circles li:nth-child(2) { left: 10%; width: 20px; height: 20px; animation-delay: 2s; animation-duration: 12s; }
        .circles li:nth-child(3) { left: 70%; width: 20px; height: 20px; animation-delay: 4s; }
        .circles li:nth-child(4) { left: 40%; width: 60px; height: 60px; animation-delay: 0s; animation-duration: 18s; }
        .circles li:nth-child(5) { left: 65%; width: 20px; height: 20px; animation-delay: 0s; }
        .circles li:nth-child(6) { left: 75%; width: 110px; height: 110px; animation-delay: 3s; }

        @keyframes floatUp {
            0% { transform: translateY(0) rotate(0deg); opacity: 1; border-radius: 0; }
            100% { transform: translateY(-1000px) rotate(720deg); opacity: 0; border-radius: 50%; }
        }

        /* --- CARDS & FEATURES --- */
        .section-title {
            font-size: 2.5rem;
            font-weight: 700;
            color: var(--nexus-primary);
            margin-bottom: 1rem;
            position: relative;
            display: inline-block;
        }

        .section-title::after {
            content: '';
            display: block;
            width: 60px;
            height: 4px;
            background: var(--nexus-accent);
            margin: 10px auto 0;
            border-radius: 2px;
        }

        .card {
            background: white;
            border-radius: var(--radius-lg);
            padding: 2.5rem;
            box-shadow: var(--shadow-card);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            border: 1px solid var(--nexus-bg-light);
        }

        .card-interactive:hover {
            transform: translateY(-10px);
            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
        }

        .card-icon {
            font-size: 3rem;
            margin-bottom: 1.5rem;
        }
        .icon-primary { color: var(--nexus-accent); }
        .icon-success { color: var(--nexus-success); }
        .icon-warning { color: var(--nexus-warning); }

        .card h3 {
            font-size: 1.5rem;
            margin-bottom: 1rem;
            color: var(--nexus-primary);
        }

        .card p {
            color: var(--nexus-text-light);
            font-size: 0.95rem;
        }

        /* --- STATS SECTION --- */
        .stat-card {
            padding: 2rem;
            background: white;
            border-radius: var(--radius-md);
        }
        .stat-value {
            font-size: 3.5rem;
            font-weight: 800;
            color: var(--nexus-primary);
            line-height: 1;
        }
        .stat-label {
            font-weight: 600;
            color: var(--nexus-accent);
            text-transform: uppercase;
            letter-spacing: 1px;
            font-size: 0.875rem;
            margin-top: 10px;
        }

        /* --- PROCESS STEPS --- */
        .step-circle {
            width: 80px;
            height: 80px;
            background: var(--nexus-accent);
            color: white;
            font-size: 2rem;
            font-weight: bold;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px;
            box-shadow: 0 0 0 8px rgba(59, 130, 246, 0.2);
        }

        /* --- CTA SECTION --- */
        .cta-section {
            background: linear-gradient(135deg, var(--nexus-primary), #1e3a8a);
            color: white;
            padding: 80px 0;
        }

        .btn-white {
            background: white;
            color: var(--nexus-primary);
        }
        .btn-white:hover {
            background: var(--nexus-bg-light);
            box-shadow: 0 0 20px rgba(255,255,255,0.3);
        }

        /* --- FOOTER --- */
        .footer {
            background-color: var(--nexus-primary);
            color: #94a3b8;
            padding: 80px 0 30px;
        }

        .footer h4 {
            color: white;
            margin-bottom: 1.5rem;
            font-size: 1.1rem;
        }

        .footer ul li { margin-bottom: 0.75rem; }
        .footer a { color: #94a3b8; }
        .footer a:hover { color: white; }

        .footer-bottom {
            margin-top: 60px;
            padding-top: 30px;
            border-top: 1px solid rgba(255,255,255,0.1);
            text-align: center;
            font-size: 0.875rem;
        }

        @media (max-width: 768px) {
            .hero h1 { font-size: 2.5rem; }
            .section { padding: 60px 0; }
        }
    </style>
</head>
<body id="top">

<!-- Navigation -->
<nav class="navbar">
    <div class="container navbar-container">
        <!-- Logo -->
        <a href="index.jsp" class="logo">
            <i class="bi bi-shield-check icon-primary"></i>
            <span>NEXUS</span>
        </a>

        <!-- Mobile Toggle -->
        <button class="mobile-toggle hidden-desktop" id="mobileMenuBtn">
            <i class="bi bi-list"></i>
        </button>

        <!-- Desktop Menu -->
        <ul class="flex items-center gap-3 hidden-mobile" id="desktopNav">
            <li><a href="#features" class="nav-link">Features</a></li>
            <li><a href="#impact" class="nav-link">Impact</a></li>
            <li><a href="#process" class="nav-link">How It Works</a></li>
            <li><a href="views/about.jsp" class="nav-link">About</a></li>
            <li><a href="views/contactus.jsp" class="nav-link">Contact</a></li>
            <li><a href="views/auth/login.jsp" class="btn btn-ghost">Sign In</a></li>
            <li><a href="views/auth/register.jsp" class="btn btn-primary">Get Started</a></li>
        </ul>
    </div>

    <!-- Mobile Dropdown -->
    <ul class="navbar-menu" id="mobileNav">
        <li class="nav-item"><a href="#features" class="nav-link">Features</a></li>
        <li class="nav-item"><a href="#impact" class="nav-link">Impact</a></li>
        <li class="nav-item"><a href="#process" class="nav-link">How It Works</a></li>
        <li class="nav-item"><a href="views/about.jsp" class="nav-link">About</a></li>
        <li class="nav-item"><a href="views/contactus.jsp" class="nav-link">Contact</a></li>
        <li class="nav-item"><a href="views/auth/login.jsp" class="btn btn-ghost" style="justify-content: flex-start;">Sign In</a></li>
        <li class="nav-item"><a href="views/auth/register.jsp" class="btn btn-primary" style="text-align: center;">Get Started</a></li>
    </ul>
</nav>

<!-- Hero Section -->
<header class="hero text-center">
    <!-- Animation Background -->
    <ul class="circles" aria-hidden="true">
        <li></li><li></li><li></li><li></li><li></li><li></li><li></li><li></li><li></li><li></li>
    </ul>

    <div class="container hero-content">
        <h1 data-aos="fade-down" data-aos-duration="1000">
            Data-Driven Policing.<br>Safer Communities.
        </h1>
        <h2 data-aos="fade-up" data-aos-delay="200" style="font-size: 1.5rem; font-weight: 400; margin-bottom: 20px; opacity: 0.8;">
            The Global Crime Data & Real-Time Analytics Hub
        </h2>
        <p data-aos="fade-up" data-aos-delay="400">
            Connecting <strong>civilians</strong>, <strong>law enforcement</strong>, and <strong>data science</strong> on a single, secure platform to drive intelligence-led safety.
        </p>
        <div data-aos="zoom-in" data-aos-delay="600" style="display: flex; gap: 15px; justify-content: center; flex-wrap: wrap;">
            <a href="views/auth/register.jsp" class="btn btn-primary" style="background: white; color: var(--nexus-accent); font-size: 1.1rem; padding: 15px 30px;">
                Get Started <i class="bi bi-arrow-right"></i>
            </a>
            <a href="views/auth/login.jsp" class="btn btn-primary" style="background: transparent; border: 2px solid white; color: white; font-size: 1.1rem; padding: 15px 30px;">
                Sign In <i class="bi bi-box-arrow-in-right"></i>
            </a>
        </div>
    </div>
</header>

<main>
    <!-- Features Section -->
    <section id="features" class="section">
        <div class="container">
            <div class="text-center mb-4">
                <h2 class="section-title" data-aos="fade-up">A Unified Ecosystem</h2>
            </div>

            <div class="grid grid-3">
                <!-- Civilian Card -->
                <article class="card card-interactive" data-aos="fade-up" data-aos-delay="100">
                    <div class="text-center">
                        <i class="bi bi-person-fill-lock card-icon icon-primary"></i>
                        <h3>For Civilians</h3>
                        <p>Securely file complaints, upload evidence anonymously, and track case status with live transparency updates.</p>
                    </div>
                </article>

                <!-- Police Card -->
                <article class="card card-interactive" data-aos="fade-up" data-aos-delay="200">
                    <div class="text-center">
                        <i class="bi bi-shield-fill-check card-icon icon-success"></i>
                        <h3>For Police</h3>
                        <p>Access geo-tagged incident logs, manage investigations digitally, and generate instant compliance reports.</p>
                    </div>
                </article>

                <!-- Analyst Card -->
                <article class="card card-interactive" data-aos="fade-up" data-aos-delay="300">
                    <div class="text-center">
                        <i class="bi bi-graph-up-arrow card-icon icon-warning"></i>
                        <h3>For Analysts</h3>
                        <p>Visualize crime hotspots, predict trends using AI models, and optimize patrol resource allocation.</p>
                    </div>
                </article>
            </div>
        <--Key Features Section -->
    <section class="section" style="background-color: var(--nexus-bg-light);">
        <div class="container">
            <div class="text-center mb-4">
                <h2 class="section-title" data-aos="fade-up">Advanced Capabilities</h2>
                <p data-aos="fade-up" data-aos-delay="100" style="color: var(--nexus-text-light); max-width: 700px; margin: 20px auto;">
                    Powered by cutting-edge technology and intelligent analytics
                </p>
            </div>

            <div class="grid grid-3">
                <div class="card" data-aos="fade-right">
                    <i class="bi bi-broadcast card-icon icon-primary"></i>
                    <h4>Real-Time Monitoring</h4>
                    <p>Live incident tracking with automated alerts for emerging patterns and high-priority cases.</p>
                </div>

                <div class="card" data-aos="zoom-in">
                    <i class="bi bi-geo-alt-fill card-icon icon-success"></i>
                    <h4>Smart Routing</h4>
                    <p>Geo-intelligent case assignment to nearest stations with optimal resource allocation.</p>
                </div>

                <div class="card" data-aos="fade-left">
                    <i class="bi bi-shield-lock-fill card-icon icon-warning"></i>
                    <h4>Secure Platform</h4>
                    <p>End-to-end encryption with role-based access control and audit trail track
                    <i class="bi bi-fingerprint card-icon icon-warning"></i>
                    <h4>Digital Forensics</h4>
                    <p>Centralized evidence locker with chain-of-custody tracking and multimedia processing.</p>
                </div>
            </div>
        </div>
    </section>

    <!-- Impact Stats -->
    <section id="impact" class="section">
        <div class="container">
            <div class="text-center mb-4">
                <h2 class="section-title">Nexus Impact</h2>
            </div>
            <div class="grid grid-3 text-center">
                <div class="stat-card" data-aos="fade-up" data-aos-delay="100">
                    <div class="stat-value">99.9%</div>
                    <div class="stat-label">Uptime Reliability</div>
                </div>
                <div class="stat-card" data-aos="fade-up" data-aos-delay="200">
                    <div class="stat-value">40%</div>
                    <div class="stat-label">Faster Response Time</div>
                </div>
                <div class="stat-card" data-aos="fade-up" data-aos-delay="300">
                    <div class="stat-value">2M+</div>
                    <div class="stat-label">Data Points Analyzed</div>
                </div>
            </div>
        </div>
    </section>

    <!-- Process Section -->
    <section id="process" class="section" style="background-color: var(--nexus-bg-light);">
        <div class="container">
            <div class="text-center mb-4">
                <h2 class="section-title">How It Works</h2>
            </div>

            <div class="grid grid-3 text-center">
                <article data-aos="fade-right">
                    <div class="step-circle">1</div>
                    <h3>Secure Filing</h3>
                    <p style="color: var(--nexus-text-light);">Incidents are filed electronically via app or web, instantly creating a secure, immutable record.</p>
                </article>

                <article data-aos="fade-up">
                    <div class="step-circle">2</div>
                    <h3>Intelligent Routing</h3>
                    <p style="color: var(--nexus-text-light);">The system geo-routes the case to the nearest jurisdiction and assigns investigators automatically.</p>
                </article>

                <article data-aos="fade-left">
                    <div class="step-circle">3</div>
                    <h3>Action & Analytics</h3>
                    <p style="color: var(--nexus-text-light);">Police take action while analysts review aggregate data to prevent future occurrences.</p>
                </article>
            </div>
        </div>
    </section>

    <!-- CTA Section -->ake a Difference?</h2>
            <p style="font-size: 1.2rem; margin-bottom: 40px; opacity: 0.9;">Join thousands of citizens and law enforcement officers building safer communities.</p>
            <div style="display: flex; gap: 20px; justify-content: center; flex-wrap: wrap;">
                <a href="views/auth/register.jsp" class="btn btn-white" style="font-size: 1.1rem; padding: 15px 35px;">
                    <i class="bi bi-person-plus"></i> Register Now
                </a>
                <a href="views/about.jsp" class="btn" style="background: transparent; border: 2px solid white; color: white; font-size: 1.1rem; padding: 15px 35px;">
                    <i class="bi bi-info-circle"></i> Learn More
                </a>
            </div>
            <h2 style="font-size: 2.5rem; margin-bottom: 20px;">Ready to Modernize Public Safety?</h2>
            <p style="font-size: 1.2rem; margin-bottom: 40px; opacity: 0.9;">Join the network of smart cities using Nexus today.</p>
            <a href="#register" class="btn btn-white btn-lg">Get Started Now</a>
        </div>
    </section>
</main>

<!-- Footer -->
<footer class="footer">
    <div class="cQuick Links --> line-height: 1.6;">A unified platform connecting citizens and law enforcement for safer, smarter communities through data-driven intelligence and real-time collaboration
            <div>
                <h4>Quick Links</h4>
                <ul>
                    <li><a href="views/auth/login.jsp">Sign In</a></li>
                    <li><a href="views/auth/register.jsp">Register</a></li>
                    <li><a href="views/about.jsp">About Us</a></li>
                    <li><a href="views/contactus.jsp">Contact Us</a></li>
                </ul>
            </div>

            <!-- Resources -->
            <div>
                <h4>Resources</h4>
                <ul>
                    <li><a href="#features">Features</a></li>
                    <li><a href="#impact">Impact</a></li>
                    <li><a href="#process">How It Works</a></li>
                    <li><a href="views/about.jsp">Documentation</a></li>
                </ul>
            </div>

            <!-- Contact & Support -->
            <div>
                <h4>Support</h4>
                <ul>
                    <li><i class="bi bi-telephone-fill"></i> Emergency: 911</li>
                    <li><i class="bi bi-headset"></i> Helpline: 1-800-NEXUS</li>
                    <li><i class="bi bi-envelope-fill"></i> support@nexus.gov</li>
                    <li><i class="bi bi-clock-fill"></i> 24/7 Available
                </ul>
            </div>

            <p style="margin-top: 10px; font-size: 0.8rem;">
                <a href="#" style="margin: 0 10px;">Privacy Policy</a> | 
                <a href="#" style="margin: 0 10px;">Terms of Service</a> | 
                <a href="#" style="margin: 0 10px;">Security</a>
            </p>
            <!-- Contact -->
            <div>
                <h4>Contact</h4>
                <ul>
                    <li><i class="bi bi-telephone"></i> Emergency: 911 / 112</li>
                    <li><i class="bi bi-envelope"></i> help@nexus.gov</li>
                    <li><i class="bi bi-geo-alt"></i> Cyber City, Sector 1</li>
                </ul>
            </div>
        </div>

        <div class="footer-bottom">
            <p>&copy; <span id="year"></span> Nexus Crime Data & Analytics Hub. All rights reserved.</p>
        </div>
    </div>
</footer>

<!-- Scripts -->
<script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
<script>
    // Initialize Animate On Scroll
    AOS.init({
        duration: 800,
        once: true,
        offset: 100
    });

    // Current Year Logic
    document.getElementById('year').textContent = new Date().getFullYear();

    // Mobile Menu Toggle Logic
    const mobileBtn = document.getElementById('mobileMenuBtn');
    const mobileNav = document.getElementById('mobileNav');
    const icon = mobileBtn.querySelector('i');

    mobileBtn.addEventListener('click', () => {
        mobileNav.classList.toggle('active');

        // Toggle Icon
        if (mobileNav.classList.contains('active')) {
            icon.classList.remove('bi-list');
            icon.classList.add('bi-x-lg');
        } else {
            icon.classList.remove('bi-x-lg');
            icon.classList.add('bi-list');
        }
    });

    // Close mobile menu when clicking a link
    document.querySelectorAll('.navbar-menu a').forEach(link => {
        link.addEventListener('click', () => {
            mobileNav.classList.remove('active');
            icon.classList.remove('bi-x-lg');
            icon.classList.add('bi-list');
        });
    });
</script>
</body>
</html>