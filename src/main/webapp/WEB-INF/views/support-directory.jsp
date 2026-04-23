<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head><meta charset="UTF-8"/><meta name="viewport" content="width=device-width, initial-scale=1.0"/><title>MindHub — Support Directory</title><jsp:include page="common/header.jsp"/></head>
<body>
<c:set var="activePage" value="support" scope="request"/><jsp:include page="common/sidebar.jsp"/>
<div class="main-content">
    <div class="topbar">
        <h1 style="font-family:var(--font-headline);font-size:1.5rem;font-weight:800;">Virtual Support</h1>
        <a href="${pageContext.request.contextPath}/support/appointments" class="btn btn-outline">My Appointments</a>
    </div>
    <div class="page-content" style="display:flex;flex-direction:column;gap:2rem;">
        <c:if test="${not empty success}"><div class="alert alert-success">${success}</div></c:if>

        <p style="color:var(--on-surface-variant);max-width:800px;">Connect with certified university counselors and mental health professionals. All sessions are strictly confidential and free for active students.</p>

        <div style="display:grid;grid-template-columns:repeat(auto-fill,minmax(300px,1fr));gap:1.5rem;">
            <c:forEach var="p" items="${professionals}">
                <div class="card fade-in" style="display:flex;flex-direction:column;gap:1rem;">
                    <div style="display:flex;gap:1rem;align-items:center;">
                        <img src="${p.photoUrl}" alt="${p.name}" style="width:4.5rem;height:4.5rem;border-radius:50%;object-fit:cover;border:2px solid var(--primary-container);"/>
                        <div>
                            <h3 style="font-size:1.2rem;margin-bottom:0.1rem;">${p.name}</h3>
                            <p style="font-size:0.875rem;color:var(--primary);font-weight:600;">${p.title}</p>
                            <p style="font-size:0.75rem;color:var(--on-surface-variant);">${p.specialization}</p>
                        </div>
                    </div>
                    <p style="font-size:0.875rem;color:var(--on-surface-variant);line-height:1.5;flex:1;">${p.bio}</p>
                    <div style="background:var(--bg-container);padding:0.75rem;border-radius:var(--radius-md);font-size:0.75rem;color:var(--on-surface-variant);display:flex;flex-direction:column;gap:0.25rem;">
                        <span style="display:flex;align-items:center;gap:0.25rem;"><span class="material-symbols-outlined" style="font-size:1rem;">mail</span> ${p.email}</span>
                        <span style="display:flex;align-items:center;gap:0.25rem;"><span class="material-symbols-outlined" style="font-size:1rem;">calendar_month</span> Available: ${p.availableDays}</span>
                    </div>
                    <a href="${pageContext.request.contextPath}/support/book/${p.id}" class="btn btn-primary" style="width:100%;">Book Session</a>
                </div>
            </c:forEach>
        </div>
    </div>
</div>
<jsp:include page="common/footer.jsp"/>
</body>
</html>

