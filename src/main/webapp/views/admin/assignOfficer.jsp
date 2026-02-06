<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>


<%-- Read attributes exactly as servlet sets them --%>
<c:set var="c" value="${complaint}" />
<c:set var="station" value="${nearestStation}" />
<c:set var="officers" value="${officers}" />

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Assign Officer | Admin - Nexus Hub</title>

    <!-- Design System CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/base.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/layout.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/components.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/dashboard.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/theme.css">
</head>

<body class="bg-light">

<div class="container mt-4">

    <div class="card shadow">
        <div class="card-header bg-primary text-white">
            <h4>Assign Officer — Complaint ${c.complaintId}</h4>
        </div>

        <div class="card-body">

            <!-- COMPLAINT DETAILS -->
            <h5><strong>Complaint Type:</strong> ${c.complaintType}</h5>
            <p><strong>Location:</strong> ${c.locationOfIncident}</p>

            <!-- NEAREST POLICE STATION -->
            <h6 class="mt-3">
                <strong>Nearest Police Station:</strong>

                <c:choose>
                    <c:when test="${station != null}">
                        ${station.stationName}
                    </c:when>
                    <c:otherwise>
                        <span class="text-danger">No Matching Station Found</span>
                    </c:otherwise>
                </c:choose>
            </h6>
            <hr>

            <!-- ASSIGN FORM -->
            <form method="post" action="${pageContext.request.contextPath}/admin/assign-officer-action">

                <input type="hidden" name="complaintId" value="${c.complaintId}"/>

                <label class="form-label fw-bold">Select Officer</label>

                <select class="form-select" name="officerId" required
                        <c:if test="${empty officers}">disabled</c:if>>

                    <c:forEach var="p" items="${officers}">
                        <option value="${p.regId}">
                                ${p.fullName} — ${p.rankDetails}
                        </option>
                    </c:forEach>

                    <c:if test="${empty officers}">
                        <option>No Officers Available</option>
                    </c:if>
                </select>

                <button type="submit" class="btn btn-primary mt-3"
                        <c:if test="${empty officers}">disabled</c:if>>
                    Assign Officer
                </button>

                <a href="${pageContext.request.contextPath}/admin/complaint-monitor"
                   class="btn btn-secondary mt-3">Cancel</a>
            </form>

        </div>
    </div>

</div>

</body>
</html>
