<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head><meta charset="UTF-8"/><meta name="viewport" content="width=device-width, initial-scale=1.0"/><title>MindHub Admin — Dashboard</title><jsp:include page="common/header.jsp"/></head>
<body>
<c:set var="activePage" value="admin" scope="request"/><jsp:include page="common/sidebar.jsp"/>
<div class="main-content">
    <div class="topbar"><h1 style="font-family:var(--font-headline);font-size:1.5rem;font-weight:800;color:var(--error);">Admin Dashboard</h1></div>
    <div class="page-content" style="display:flex;flex-direction:column;gap:2rem;">
        
        <div style="display:grid;grid-template-columns:repeat(auto-fit,minmax(200px,1fr));gap:1rem;">
            <div class="card" style="border-top:4px solid var(--primary);"><h4 style="color:var(--on-surface-variant);font-size:0.875rem;">Total Users</h4><div style="font-size:2rem;font-weight:800;">${stats.totalUsers}</div></div>
            <div class="card" style="border-top:4px solid var(--secondary);"><h4 style="color:var(--on-surface-variant);font-size:0.875rem;">Mood Entries</h4><div style="font-size:2rem;font-weight:800;">${stats.totalMoodEntries}</div></div>
            <div class="card" style="border-top:4px solid var(--tertiary);"><h4 style="color:var(--on-surface-variant);font-size:0.875rem;">Forum Posts</h4><div style="font-size:2rem;font-weight:800;">${stats.totalForumPosts}</div></div>
            <div class="card" style="border-top:4px solid var(--error);"><h4 style="color:var(--on-surface-variant);font-size:0.875rem;">Appointments</h4><div style="font-size:2rem;font-weight:800;">${stats.totalAppointments}</div></div>
        </div>

        <div style="display:grid;grid-template-columns:1fr 1fr;gap:1.5rem;">
            <!-- Top Users -->
            <div class="card">
                <h3 style="font-family:var(--font-headline);margin-bottom:1rem;">Top Active Students (Gamification)</h3>
                <div class="table-container">
                    <table>
                        <thead><tr><th>Student</th><th>Total Points</th></tr></thead>
                        <tbody>
                            <c:forEach var="u" items="${topUsers}">
                                <tr><td>${u.label}</td><td><span class="badge badge-tertiary">${u.value} pts</span></td></tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
            
            <!-- Admin Quick Links -->
            <div class="card" style="display:flex;flex-direction:column;gap:1rem;">
                <h3 style="font-family:var(--font-headline);margin-bottom:0.5rem;">Quick Actions</h3>
                <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-outline" style="justify-content:flex-start;"><span class="material-symbols-outlined">group</span> Manage Users</a>
                <a href="${pageContext.request.contextPath}/admin/forum/flagged" class="btn btn-outline" style="justify-content:flex-start;"><span class="material-symbols-outlined" style="color:var(--error);">flag</span> Moderate Flagged Posts</a>
                <a href="${pageContext.request.contextPath}/admin/content/add" class="btn btn-outline" style="justify-content:flex-start;"><span class="material-symbols-outlined">library_add</span> Add New Content</a>
                <a href="${pageContext.request.contextPath}/admin/reports" class="btn btn-outline" style="justify-content:flex-start;"><span class="material-symbols-outlined">analytics</span> View Full Reports</a>
            </div>
        </div>
    </div>
</div>
<jsp:include page="common/footer.jsp"/>
</body>
</html>

