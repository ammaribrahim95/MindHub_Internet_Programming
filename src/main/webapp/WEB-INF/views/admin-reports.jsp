<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head><meta charset="UTF-8"/><meta name="viewport" content="width=device-width, initial-scale=1.0"/><title>MindHub Admin — Reports</title><jsp:include page="common/header.jsp"/></head>
<body>
<c:set var="activePage" value="admin-reports" scope="request"/><jsp:include page="common/sidebar.jsp"/>
<div class="main-content">
    <div class="topbar"><h1 style="font-family:var(--font-headline);font-size:1.5rem;font-weight:800;color:var(--error);">System Reports</h1></div>
    <div class="page-content" style="display:grid;grid-template-columns:1fr 1fr;gap:2rem;">
        
        <!-- Registration Stats -->
        <div class="card">
            <h3 style="margin-bottom:1rem;font-family:var(--font-headline);">User Registrations (Last 12 Months)</h3>
            <div class="table-container">
                <table>
                    <thead><tr><th>Month</th><th>New Users</th></tr></thead>
                    <tbody><c:forEach var="r" items="${registrations}"><tr><td>${r.label}</td><td>${r.value}</td></tr></c:forEach></tbody>
                </table>
            </div>
        </div>

        <!-- Forum Activity -->
        <div class="card">
            <h3 style="margin-bottom:1rem;font-family:var(--font-headline);">Forum Activity by Category</h3>
            <div class="table-container">
                <table>
                    <thead><tr><th>Category</th><th>Posts</th></tr></thead>
                    <tbody><c:forEach var="f" items="${forumActivity}"><tr><td>${f.label}</td><td>${f.value}</td></tr></c:forEach></tbody>
                </table>
            </div>
        </div>

        <!-- Assessment Stats -->
        <div class="card">
            <h3 style="margin-bottom:1rem;font-family:var(--font-headline);">Assessment Completions</h3>
            <div class="table-container">
                <table>
                    <thead><tr><th>Assessment</th><th>Total Completions</th></tr></thead>
                    <tbody><c:forEach var="a" items="${assessmentStats}"><tr><td>${a.label}</td><td>${a.value}</td></tr></c:forEach></tbody>
                </table>
            </div>
        </div>

        <!-- Mood Distribution -->
        <div class="card">
            <h3 style="margin-bottom:1rem;font-family:var(--font-headline);">Mood Score Averages (Recent)</h3>
            <div class="table-container">
                <table>
                    <thead><tr><th>Date</th><th>Average Score</th></tr></thead>
                    <tbody><c:forEach var="m" items="${moodDistribution}"><tr><td>${m.label}</td><td>${m.value}/5</td></tr></c:forEach></tbody>
                </table>
            </div>
        </div>

    </div>
</div>
<jsp:include page="common/footer.jsp"/>
</body>
</html>

