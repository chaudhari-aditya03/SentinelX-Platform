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
    <meta name="description" content="Help & Support Center - Nexus Crime Data & Analytics Hub">
    <title>Help & Support | Nexus</title>

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
        .help-section {
            background: white;
            padding: var(--space-8);
            border-radius: var(--radius-2xl);
            box-shadow: var(--shadow-md);
            margin-bottom: var(--space-6);
        }

        .section-header {
            display: flex;
            align-items: center;
            gap: var(--space-3);
            margin-bottom: var(--space-6);
            padding-bottom: var(--space-4);
            border-bottom: 3px solid var(--nexus-accent);
        }

        .section-icon {
            width: 50px;
            height: 50px;
            background: linear-gradient(135deg, var(--nexus-accent) 0%, var(--nexus-primary) 100%);
            color: white;
            border-radius: var(--radius-lg);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: var(--font-2xl);
        }

        .section-title {
            font-size: var(--font-2xl);
            font-weight: var(--font-bold);
            color: var(--nexus-primary);
        }

        .faq-item {
            padding: var(--space-5);
            border: 2px solid var(--nexus-gray-200);
            border-radius: var(--radius-lg);
            margin-bottom: var(--space-4);
            transition: all var(--transition-base);
            cursor: pointer;
        }

        .faq-item:hover {
            border-color: var(--nexus-accent);
            box-shadow: var(--shadow-sm);
        }

        .faq-question {
            font-weight: var(--font-semibold);
            color: var(--nexus-text-primary);
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: var(--space-3);
        }

        .faq-answer {
            max-height: 0;
            overflow: hidden;
            transition: max-height 0.3s ease-out;
            color: var(--nexus-text-secondary);
            line-height: 1.6;
        }

        .faq-item.active .faq-answer {
            max-height: 500px;
            margin-top: var(--space-4);
            padding-top: var(--space-4);
            border-top: 1px solid var(--nexus-gray-200);
        }

        .faq-item.active .faq-icon {
            transform: rotate(180deg);
        }

        .faq-icon {
            transition: transform 0.3s ease;
            color: var(--nexus-accent);
        }

        .quick-links-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: var(--space-5);
            margin-top: var(--space-6);
        }

        .quick-link-card {
            padding: var(--space-6);
            background: linear-gradient(135deg, var(--nexus-gray-50) 0%, white 100%);
            border: 2px solid var(--nexus-gray-200);
            border-radius: var(--radius-xl);
            text-align: center;
            transition: all var(--transition-base);
            text-decoration: none;
            color: var(--nexus-text-primary);
        }

        .quick-link-card:hover {
            transform: translateY(-5px);
            border-color: var(--nexus-accent);
            box-shadow: 0 10px 25px rgba(0, 163, 255, 0.15);
        }

        .quick-link-icon {
            width: 60px;
            height: 60px;
            background: linear-gradient(135deg, var(--nexus-accent) 0%, var(--nexus-primary) 100%);
            color: white;
            border-radius: var(--radius-lg);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: var(--font-3xl);
            margin: 0 auto var(--space-4);
        }

        .quick-link-title {
            font-weight: var(--font-bold);
            margin-bottom: var(--space-2);
            font-size: var(--font-lg);
        }

        .quick-link-desc {
            font-size: var(--font-sm);
            color: var(--nexus-text-secondary);
        }

        .contact-info {
            background: linear-gradient(135deg, var(--nexus-accent) 0%, var(--nexus-primary) 100%);
            color: white;
            padding: var(--space-8);
            border-radius: var(--radius-2xl);
            text-align: center;
        }

        .contact-methods {
            display: flex;
            justify-content: center;
            gap: var(--space-8);
            margin-top: var(--space-6);
            flex-wrap: wrap;
        }

        .contact-method {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: var(--space-2);
        }

        .contact-method i {
            font-size: var(--font-3xl);
        }

        .contact-method-label {
            font-size: var(--font-sm);
            opacity: 0.9;
        }

        .contact-method-value {
            font-weight: var(--font-bold);
            font-size: var(--font-lg);
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
                <a href="${pageContext.request.contextPath}/civilian/dashboard" class="sidebar-nav-item">
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
                <a href="${pageContext.request.contextPath}/views/civilian/help.jsp" class="sidebar-nav-item active">
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
                        <div class="sidebar-user-name">${sessionScope.user_name}</div>
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
                    <h1 class="page-title">Help & Support Center</h1>
                </div>
            </header>

            <!-- Help Content -->
            <div class="content-wrapper">
                <!-- Quick Links Section -->
                <div class="help-section">
                    <div class="section-header">
                        <div class="section-icon">
                            <i class="bi bi-lightning"></i>
                        </div>
                        <h2 class="section-title">Quick Actions</h2>
                    </div>
                    <div class="quick-links-grid">
                        <a href="#" class="quick-link-card">
                            <div class="quick-link-icon">
                                <i class="bi bi-file-earmark-plus"></i>
                            </div>
                            <div class="quick-link-title">File New Complaint</div>
                            <div class="quick-link-desc">Report a crime or incident</div>
                        </a>
                        <a href="${pageContext.request.contextPath}/views/civilian/viewComplaints.jsp" class="quick-link-card">
                            <div class="quick-link-icon">
                                <i class="bi bi-clock-history"></i>
                            </div>
                            <div class="quick-link-title">Track Complaints</div>
                            <div class="quick-link-desc">View your complaint status</div>
                        </a>
                        <a href="${pageContext.request.contextPath}/views/civilian/profile.jsp" class="quick-link-card">
                            <div class="quick-link-icon">
                                <i class="bi bi-person-gear"></i>
                            </div>
                            <div class="quick-link-title">Update Profile</div>
                            <div class="quick-link-desc">Edit your personal information</div>
                        </a>
                        <a href="${pageContext.request.contextPath}/views/contactus.jsp" class="quick-link-card">
                            <div class="quick-link-icon">
                                <i class="bi bi-envelope"></i>
                            </div>
                            <div class="quick-link-title">Contact Us</div>
                            <div class="quick-link-desc">Get in touch with support</div>
                        </a>
                    </div>
                </div>

                <!-- FAQs Section -->
                <div class="help-section">
                    <div class="section-header">
                        <div class="section-icon">
                            <i class="bi bi-question-circle"></i>
                        </div>
                        <h2 class="section-title">Frequently Asked Questions</h2>
                    </div>
                    
                    <div class="faq-item">
                        <div class="faq-question">
                            <span>How do I file a complaint?</span>
                            <i class="bi bi-chevron-down faq-icon"></i>
                        </div>
                        <div class="faq-answer">
                            Click on "File Complaint" from the sidebar menu. Fill in all required details including the type of crime, location, date, and description. You can also upload supporting documents or evidence. Once submitted, you'll receive a complaint ID for tracking.
                        </div>
                    </div>

                    <div class="faq-item">
                        <div class="faq-question">
                            <span>How can I track my complaint status?</span>
                            <i class="bi bi-chevron-down faq-icon"></i>
                        </div>
                        <div class="faq-answer">
                            Navigate to "My Complaints" from the sidebar. You'll see all your filed complaints with their current status. Click on any complaint to view detailed information including assigned officers and investigation updates.
                        </div>
                    </div>

                    <div class="faq-item">
                        <div class="faq-question">
                            <span>How long does it take to process a complaint?</span>
                            <i class="bi bi-chevron-down faq-icon"></i>
                        </div>
                        <div class="faq-answer">
                            Initial review typically takes 24-48 hours. However, processing time varies based on the urgency and complexity of the case. High-priority cases are expedited. You'll receive notifications at each stage of the investigation.
                        </div>
                    </div>

                    <div class="faq-item">
                        <div class="faq-question">
                            <span>Can I update my complaint after submission?</span>
                            <i class="bi bi-chevron-down faq-icon"></i>
                        </div>
                        <div class="faq-answer">
                            Yes, you can add additional information or evidence to your complaint by contacting the assigned officer or using the "Update Complaint" feature in the complaint details page.
                        </div>
                    </div>

                    <div class="faq-item">
                        <div class="faq-question">
                            <span>Is my information kept confidential?</span>
                            <i class="bi bi-chevron-down faq-icon"></i>
                        </div>
                        <div class="faq-answer">
                            Absolutely. All information is encrypted and stored securely. Your personal details are only accessible to authorized personnel handling your case. We follow strict data protection regulations.
                        </div>
                    </div>

                    <div class="faq-item">
                        <div class="faq-question">
                            <span>What should I do in case of an emergency?</span>
                            <i class="bi bi-chevron-down faq-icon"></i>
                        </div>
                        <div class="faq-answer">
                            For immediate emergencies, always call 911 first. This platform is for reporting non-emergency incidents and tracking complaints. In life-threatening situations, direct contact with emergency services is essential.
                        </div>
                    </div>
                </div>

                <!-- Contact Information Section -->
                <div class="contact-info">
                    <h2 style="font-size: var(--font-3xl); font-weight: var(--font-bold); margin-bottom: var(--space-2);">
                        Still Need Help?
                    </h2>
                    <p style="font-size: var(--font-lg); opacity: 0.9; margin-bottom: var(--space-6);">
                        Our support team is here to assist you 24/7
                    </p>
                    <div class="contact-methods">
                        <div class="contact-method">
                            <i class="bi bi-telephone"></i>
                            <div class="contact-method-label">Emergency</div>
                            <div class="contact-method-value">911</div>
                        </div>
                        <div class="contact-method">
                            <i class="bi bi-headset"></i>
                            <div class="contact-method-label">Support</div>
                            <div class="contact-method-value">1-800-NEXUS</div>
                        </div>
                        <div class="contact-method">
                            <i class="bi bi-envelope"></i>
                            <div class="contact-method-label">Email</div>
                            <div class="contact-method-value">support@nexus.gov</div>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>

    <!-- Scripts -->
    <script src="${pageContext.request.contextPath}/js/layout.js"></script>
    <script>
        // FAQ Accordion functionality
        document.querySelectorAll('.faq-item').forEach(item => {
            item.addEventListener('click', () => {
                const isActive = item.classList.contains('active');
                
                // Close all FAQ items
                document.querySelectorAll('.faq-item').forEach(faq => {
                    faq.classList.remove('active');
                });
                
                // Open clicked item if it wasn't active
                if (!isActive) {
                    item.classList.add('active');
                }
            });
        });
    </script>
</body>
</html>
