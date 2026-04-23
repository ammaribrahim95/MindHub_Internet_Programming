<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head><meta charset="UTF-8"/><meta name="viewport" content="width=device-width, initial-scale=1.0"/><title>MindHub — My Appointments</title><jsp:include page="common/header.jsp"/></head>
<body>
<c:set var="activePage" value="support" scope="request"/><jsp:include page="common/sidebar.jsp"/>
<div class="main-content">
    <div class="topbar">
        <h1 style="font-family:var(--font-headline);font-size:1.5rem;font-weight:800;">My Appointments</h1>
        <a href="${pageContext.request.contextPath}/support" class="btn btn-primary"><span class="material-symbols-outlined">add</span> Book New</a>
    </div>
    <div class="page-content">
        <c:if test="${not empty success}"><div class="alert alert-success">${success}</div></c:if>

        <div class="card">
            <div class="table-container">
                <table>
                    <thead><tr><th>Professional</th><th>Date & Time</th><th>Status</th><th>Actions</th></tr></thead>
                    <tbody>
                        <c:forEach var="a" items="${appointments}">
                            <tr>
                                <td><div style="font-weight:600;">${a.professionalName}</div></td>
                                <td>${a.appointmentDate} <span style="color:var(--on-surface-variant);font-size:0.8rem;margin-left:0.5rem;">${a.timeSlot}</span></td>
                                <td>
                                    <span class="badge ${a.status == 'PENDING' ? 'badge-tertiary' : (a.status == 'CANCELLED' ? 'badge-danger' : 'badge-primary')}">${a.status}</span>
                                </td>
                                <td>
                                    <c:if test="${a.status != 'CANCELLED'}">
                                        <form action="${pageContext.request.contextPath}/support/cancel/${a.id}" method="post" style="display:inline;" onsubmit="return confirm('Are you sure you want to cancel this appointment?');">
                                            <button type="submit" class="btn btn-danger" style="padding:0.4rem 0.8rem;font-size:0.75rem;">Cancel</button>
                                        </form>
                                    </c:if>
                                    <c:if test="${a.status == 'APPROVED'}">
                                        <a href="#" class="btn btn-secondary" style="padding:0.4rem 0.8rem;font-size:0.75rem;"><span class="material-symbols-outlined" style="font-size:1rem;">videocam</span> Join Call</a>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty appointments}">
                            <tr><td colspan="4" style="text-align:center;padding:2rem;color:var(--on-surface-variant);">You have no booked appointments.</td></tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<jsp:include page="common/footer.jsp"/>
</body>
</html>

