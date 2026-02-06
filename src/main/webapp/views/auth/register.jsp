<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.example.nexus.dao.PoliceRegistrationDAO"%>
<%@ page import="org.example.nexus.model.PoliceStation"%>
<%@ page import="java.util.List"%>

<%
    PoliceRegistrationDAO psdao = new PoliceRegistrationDAO();
    List<PoliceStation> stations = psdao.getAllStations();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Register for Nexus Crime Data & Analytics Hub - Join as Civilian, Police Officer, or Administrator">
    <title>Register – Nexus Crime Data Hub</title>

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
            background: linear-gradient(-45deg, var(--nexus-primary), #1A5276, var(--nexus-accent), #004d7a);
            background-size: 400% 400%;
            animation: gradientBG 15s ease infinite;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: var(--space-6) var(--space-4);
        }
        
        @keyframes gradientBG {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }
        
        .auth-card {
            max-width: 900px;
            width: 100%;
            animation: zoomIn 0.6s ease-out;
        }
        
        @keyframes zoomIn {
            from {
                opacity: 0;
                transform: scale(0.9);
            }
            to {
                opacity: 1;
                transform: scale(1);
            }
        }
        
        .tab-btn {
            flex: 1;
            padding: var(--space-3);
            border: 2px solid var(--nexus-gray-300);
            background: var(--nexus-white);
            color: var(--nexus-text-secondary);
            border-radius: var(--radius-lg);
            font-weight: var(--font-bold);
            cursor: pointer;
            transition: all var(--transition-base);
        }
        
        .tab-btn:hover {
            border-color: var(--nexus-accent);
            color: var(--nexus-accent);
        }
        
        .tab-btn.active {
            background-color: var(--nexus-accent);
            color: var(--nexus-white);
            border-color: var(--nexus-accent);
            box-shadow: var(--shadow-lg);
        }
        
        .form-section {
            display: none;
        }
        
        .form-section.active {
            display: block;
        }
    </style>
</head>
<body>

    <div class="auth-card">
        <div class="card">
            <!-- Card Header -->
            <div class="card-header" style="background: linear-gradient(135deg, var(--nexus-primary), var(--nexus-accent)); color: var(--nexus-white); text-align: center; padding: var(--space-6);">
                <h1 style="font-size: var(--font-3xl); font-weight: var(--font-extrabold); margin: 0;">
                    <i class="bi bi-person-plus-fill" style="margin-right: var(--space-3);"></i>
                    Create Your Nexus Account
                </h1>
            </div>

            <div class="card-body" style="padding: var(--space-8);">
                <% String error = request.getParameter("error"); if (error != null) { %>
                <div class="alert alert-danger" style="margin-bottom: var(--space-6);">
                    <i class="bi bi-exclamation-triangle-fill" style="margin-right: var(--space-2);"></i>
                    <%= error %>
                </div>
                <% } %>

                <!-- Tab Navigation -->
                <div class="flex gap-4" style="margin-bottom: var(--space-8);">
                    <button id="tab-civilian" class="tab-btn active" onclick="switchForm('civilianForm')">
                        <i class="bi bi-person-circle"></i> Civilian
                    </button>
                    <button id="tab-police" class="tab-btn" onclick="switchForm('policeForm')">
                        <i class="bi bi-shield-check"></i> Police
                    </button>
                    <button id="tab-admin" class="tab-btn" onclick="switchForm('adminForm')">
                        <i class="bi bi-gear-fill"></i> Admin
                    </button>
                </div>

                <!-- CIVILIAN FORM -->
                <form id="civilianForm" class="form-section active" action="<%= request.getContextPath() %>/civilian_register" method="post">
                    <h5 style="font-size: var(--font-xl); font-weight: var(--font-extrabold); margin-bottom: var(--space-6); padding-bottom: var(--space-3); border-bottom: 2px solid var(--nexus-gray-200);">
                        <i class="bi bi-person-circle" style="color: var(--nexus-accent); margin-right: var(--space-2);"></i>
                        General Public Registration
                    </h5>

                    <div class="form-group">
                        <label for="civ-name" class="form-label">Full Name</label>
                        <input type="text" name="full_name" id="civ-name" class="form-control" placeholder="Jane Doe" required>
                    </div>

                    <div class="grid md:grid-cols-2 gap-4">
                        <div class="form-group">
                            <label for="civ-email" class="form-label">Email Address</label>
                            <input type="email" name="email" id="civ-email" class="form-control" placeholder="jane.doe@email.com" required>
                        </div>
                        <div class="form-group">
                            <label for="civ-phone" class="form-label">Phone Number</label>
                            <input type="tel" name="phone" id="civ-phone" class="form-control" placeholder="+1 (555) 123-4567" required>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="civ-password" class="form-label">Password</label>
                        <input type="password" name="password" id="civ-password" class="form-control" placeholder="••••••••" required>
                    </div>

                    <div class="form-group">
                        <label for="civ-national-id" class="form-label">National ID (Optional)</label>
                        <input type="text" name="national_id" id="civ-national-id" class="form-control" placeholder="ID Number">
                    </div>

                    <div class="grid md:grid-cols-2 gap-4">
                        <div class="form-group">
                            <label for="civ-dob" class="form-label">Date of Birth</label>
                            <input type="date" name="dob" id="civ-dob" class="form-control">
                        </div>
                        <div class="form-group">
                            <label for="civ-gender" class="form-label">Gender</label>
                            <select name="gender" id="civ-gender" class="form-select">
                                <option>Male</option>
                                <option>Female</option>
                                <option>Other</option>
                            </select>
                        </div>
                    </div>

                    <button type="submit" class="btn btn-primary btn-lg" style="width: 100%; margin-top: var(--space-4);">
                        <i class="bi bi-person-check-fill" style="margin-right: var(--space-2);"></i>
                        Register as Civilian
                    </button>
                </form>

                <!-- POLICE FORM -->
                <form id="policeForm" class="form-section" action="<%= request.getContextPath() %>/police_register" method="post">
                    <h5 style="font-size: var(--font-xl); font-weight: var(--font-extrabold); margin-bottom: var(--space-6); padding-bottom: var(--space-3); border-bottom: 2px solid var(--nexus-gray-200);">
                        <i class="bi bi-shield-check" style="color: var(--nexus-success); margin-right: var(--space-2);"></i>
                        Law Enforcement Registration
                    </h5>

                    <div class="form-group">
                        <label for="pol-name" class="form-label">Full Name</label>
                        <input type="text" name="full_name" id="pol-name" class="form-control" placeholder="Officer John Smith" required>
                    </div>

                    <div class="grid md:grid-cols-2 gap-4">
                        <div class="form-group">
                            <label for="pol-email" class="form-label">Email Address</label>
                            <input type="email" name="email" id="pol-email" class="form-control" placeholder="john.smith@police.gov" required>
                        </div>
                        <div class="form-group">
                            <label for="pol-phone" class="form-label">Phone Number</label>
                            <input type="tel" name="phone" id="pol-phone" class="form-control" placeholder="+1 (555) 987-6543" required>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="pol-password" class="form-label">Password</label>
                        <input type="password" name="password" id="pol-password" class="form-control" placeholder="••••••••" required>
                    </div>

                    <div class="grid md:grid-cols-2 gap-4">
                        <div class="form-group">
                            <label for="pol-rank" class="form-label">Rank</label>
                            <input type="text" name="rank" id="pol-rank" class="form-control" placeholder="Sergeant / Detective">
                        </div>
                        <div class="form-group">
                            <label for="pol-station" class="form-label">Police Station</label>
                            <input type="text" id="policeStationSearch" class="form-control" placeholder="Search station..." onkeyup="filterStations()" style="margin-bottom: var(--space-3);">
                            <select name="police_station_id" id="policeStationSelect" class="form-select" required>
                                <option value="">-- Select Station --</option>
                                <% for (PoliceStation ps : stations) { %>
                                <option value="<%= ps.getPoliceStationId() %>">
                                    <%= ps.getPoliceStationId() %> – <%= ps.getStationName() %>
                                </option>
                                <% } %>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="pol-code" class="form-label">Official Joining Code</label>
                        <input type="text" name="joining_code" id="pol-code" class="form-control" placeholder="Unique Official Code" required>
                    </div>

                    <button type="submit" class="btn btn-primary btn-lg" style="width: 100%; margin-top: var(--space-4);">
                        <i class="bi bi-shield-lock-fill" style="margin-right: var(--space-2);"></i>
                        Register as Police
                    </button>
                </form>

                <!-- ADMIN FORM -->
                <form id="adminForm" class="form-section" action="<%= request.getContextPath() %>/admin_register" method="post">
                    <h5 style="font-size: var(--font-xl); font-weight: var(--font-extrabold); margin-bottom: var(--space-6); padding-bottom: var(--space-3); border-bottom: 2px solid var(--nexus-gray-200);">
                        <i class="bi bi-gear-fill" style="color: var(--nexus-primary); margin-right: var(--space-2);"></i>
                        Administrator/Analyst Registration
                    </h5>

                    <div class="form-group">
                        <label for="adm-name" class="form-label">Full Name</label>
                        <input type="text" name="full_name" id="adm-name" class="form-control" placeholder="Admin Name" required>
                    </div>

                    <div class="form-group">
                        <label for="adm-email" class="form-label">Email Address</label>
                        <input type="email" name="email" id="adm-email" class="form-control" placeholder="admin@nexus.gov" required>
                    </div>

                    <div class="form-group">
                        <label for="adm-password" class="form-label">Password</label>
                        <input type="password" name="password" id="adm-password" class="form-control" placeholder="••••••••" required>
                    </div>

                    <div class="form-group">
                        <label for="adm-role" class="form-label">Role</label>
                        <select name="role" id="adm-role" class="form-select">
                            <option value="SUPER_ADMIN">Super Admin</option>
                            <option value="ANALYST">Analyst (Data Access)</option>
                            <option value="AUDITOR">Auditor (Compliance)</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="adm-code" class="form-label">Secret Admin Code</label>
                        <input type="text" name="secret_admin_code" id="adm-code" class="form-control" placeholder="Required for Authorization" required>
                    </div>

                    <button type="submit" class="btn btn-primary btn-lg" style="width: 100%; margin-top: var(--space-4);">
                        <i class="bi bi-key-fill" style="margin-right: var(--space-2);"></i>
                        Register as Admin
                    </button>
                </form>

                <!-- Footer Links -->
                <div class="text-center" style="margin-top: var(--space-8); padding-top: var(--space-6); border-top: 1px solid var(--nexus-gray-200);">
                    <p style="color: var(--nexus-text-secondary); font-size: var(--font-sm);">
                        Already have an account?
                        <a href="login.jsp" class="text-link" style="font-weight: var(--font-bold);">Login</a>
                    </p>
                </div>
            </div>
        </div>
    </div>

    <!-- JavaScript -->
    <script src="${pageContext.request.contextPath}/js/app.js"></script>
    <script>
        function switchForm(formId) {
            // Hide all forms
            document.querySelectorAll('.form-section').forEach(f => f.classList.remove('active'));
            // Show selected form
            document.getElementById(formId).classList.add('active');
            
            // Update tab buttons
            document.querySelectorAll('.tab-btn').forEach(btn => btn.classList.remove('active'));
            document.getElementById('tab-' + formId.replace('Form', '')).classList.add('active');
        }
        
        function filterStations() {
            const input = document.getElementById('policeStationSearch');
            const filter = input.value.toUpperCase();
            const select = document.getElementById('policeStationSelect');
            const options = select.getElementsByTagName('option');
            
            for (let i = 0; i < options.length; i++) {
                const option = options[i];
                const textValue = option.textContent || option.innerText;
                
                if (i === 0) {
                    option.style.display = "";
                    continue;
                }
                
                if (textValue.toUpperCase().indexOf(filter) > -1) {
                    option.style.display = "";
                } else {
                    option.style.display = "none";
                }
            }
            
            if (select.options[select.selectedIndex] && select.options[select.selectedIndex].style.display === 'none') {
                select.selectedIndex = 0;
            }
        }
        
        document.addEventListener('DOMContentLoaded', function() {
            switchForm('civilianForm');
        });
    </script>
</body>
</html>