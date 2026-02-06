<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>All Complaints | Civilian - Nexus Hub</title>

    <!-- Design System CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/base.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/layout.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/components.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/dashboard.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/theme.css">

    <style>
        .complaints-table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            border-radius: var(--radius-2xl);
            overflow: hidden;
            box-shadow: var(--shadow-md);
        }

        .complaints-table thead {
            background: var(--nexus-dark);
            color: white;
        }

        .complaints-table th {
            padding: var(--space-4);
            text-align: left;
            font-weight: var(--fw-600);
            font-size: var(--text-sm);
        }

        .complaints-table td {
            padding: var(--space-4);
            border-bottom: 1px solid #e5e7eb;
            font-size: var(--text-sm);
        }

        .complaints-table tbody tr:hover {
            background-color: #f9fafb;
        }

        .status-badge {
            display: inline-flex;
            padding: var(--space-2) var(--space-3);
            border-radius: var(--radius-full);
            font-size: var(--text-xs);
            font-weight: var(--fw-600);
        }

        .status-resolved {
            background-color: #d1fae5;
            color: #065f46;
        }

        .status-investigating {
            background-color: #fef3c7;
            color: #92400e;
        }

        .status-review {
            background-color: #dbeafe;
            color: #0c4a6e;
        }

        .status-pending {
            background-color: #f3f4f6;
            color: #374151;
        }

        .urgency-badge {
            display: inline-flex;
            padding: var(--space-2) var(--space-3);
            border-radius: var(--radius-full);
            font-size: var(--text-xs);
            font-weight: var(--fw-600);
            background-color: #fee2e2;
            color: #991b1b;
        }

        .no-data {
            text-align: center;
            padding: var(--space-12) var(--space-4);
            color: #6b7280;
            font-size: var(--text-base);
        }
    </style>
</head>

<body style="background-color: var(--nexus-light);">

<div class="container-fluid p-4 sm:p-6 lg:p-8" style="padding: var(--space-8);">

    <h2 style="font-size: 1.875rem; font-weight: var(--fw-900); margin-bottom: var(--space-6); display: flex; align-items: center;">
        <i class="bi bi-list-check me-3" style="font-size: 2rem; color: var(--nexus-fresh);"></i>
        All Complaints Filed by You
    </h2>

    <div style="background: white; border-radius: var(--radius-2xl); overflow: hidden; box-shadow: var(--shadow-md);">
        <div style="padding: var(--space-6); overflow-x: auto;">
            <table class="complaints-table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Type</th>
                        <th>Date of Incident</th>
                        <th>Location</th>
                        <th>Latitude</th>
                        <th>Longitude</th>
                        <th>Description</th>
                        <th>Suspect Details</th>
                        <th>Victim Details</th>
                        <th>Urgency</th>
                        <th>Date Filed</th>
                        <th>Status</th>
                    </tr>
                </thead>

                <tbody>
                    <c:forEach var="c" items="${complaints}">
                        <tr>
                            <td><strong>${c.complaintId}</strong></td>
                            <td>${c.complaintType}</td>
                            <td>${c.dateOfIncident}</td>
                            <td>${c.locationOfIncident}</td>
                            <td>${c.latitude}</td>
                            <td>${c.longitude}</td>
                            <td title="${c.description}" style="max-width: 200px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">${c.description}</td>
                            <td title="${c.suspectDetails}" style="max-width: 150px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">${c.suspectDetails}</td>
                            <td title="${c.victimDetails}" style="max-width: 150px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">${c.victimDetails}</td>
                            <td><span class="urgency-badge">${c.urgencyLevel}</span></td>
                            <td>${c.dateFiled}</td>
                            <td>
                                <c:choose>
                                    <c:when test='${c.currentStatus == "RESOLVED"}'>
                                        <span class="status-badge status-resolved">✓ RESOLVED</span>
                                    </c:when>
                                    <c:when test='${c.currentStatus == "UNDER_INVESTIGATION"}'>
                                        <span class="status-badge status-investigating">⟳ INVESTIGATING</span>
                                    </c:when>
                                    <c:when test='${c.currentStatus == "UNDER_REVIEW"}'>
                                        <span class="status-badge status-review">◎ REVIEW</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="status-badge status-pending">⊘ PENDING</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </c:forEach>

                    <c:if test="${empty complaints}">
                        <tr>
                            <td colspan="12" class="no-data">
                                <i class="bi bi-inbox" style="font-size: 3rem; margin-bottom: var(--space-4); display: block; color: #d1d5db;"></i>
                                No Complaints Found
                            </td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>

        <div style="padding: var(--space-6); border-top: 1px solid #e5e7eb;">
            <a href="${pageContext.request.contextPath}/civilian/dashboard" class="btn btn-primary">
                <i class="bi bi-arrow-left me-2"></i>Back to Dashboard
            </a>
        </div>
    </div>
</div>

<script src="${pageContext.request.contextPath}/js/app.js"></script>
</body>
</html>