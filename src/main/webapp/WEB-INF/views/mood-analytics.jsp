<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head><meta charset="UTF-8"/><meta name="viewport" content="width=device-width, initial-scale=1.0"/><title>MindHub — Mood Analytics</title><jsp:include page="common/header.jsp"/></head>
<body>
<c:set var="activePage" value="mood-analytics" scope="request"/><jsp:include page="common/sidebar.jsp"/>
<div class="main-content">
    <div class="topbar"><h1 style="font-family:var(--font-headline);font-size:1.5rem;font-weight:800;">Mood Analytics</h1></div>
    <div class="page-content" style="display:flex;flex-direction:column;gap:2rem;">
        <section style="display:grid;grid-template-columns:1fr 1fr 1fr;gap:1rem;">
            <div class="card" style="text-align:center;"><div style="font-size:2.5rem;font-weight:900;color:var(--primary);"><fmt:formatNumber value="${avgMood}" maxFractionDigits="1"/></div><div style="font-size:0.75rem;color:var(--on-surface-variant);text-transform:uppercase;">Avg Mood Score</div></div>
            <div class="card" style="text-align:center;"><div style="font-size:2.5rem;font-weight:900;color:var(--secondary);">${allEntries != null ? allEntries.size() : 0}</div><div style="font-size:0.75rem;color:var(--on-surface-variant);text-transform:uppercase;">Total Entries</div></div>
            <div class="card" style="text-align:center;"><div style="font-size:2.5rem;font-weight:900;color:var(--tertiary);">${weeklyMood != null ? weeklyMood.size() : 0}</div><div style="font-size:0.75rem;color:var(--on-surface-variant);text-transform:uppercase;">This Week</div></div>
        </section>
        <!-- Weekly Chart -->
        <div class="card">
            <h3 style="font-family:var(--font-headline);margin-bottom:1.5rem;">Weekly Mood Chart</h3>
            <div style="display:flex;align-items:flex-end;justify-content:space-between;gap:0.5rem;height:12rem;padding:0 0.5rem;">
                <c:forEach var="mood" items="${weeklyMood}">
                    <div style="width:100%;display:flex;flex-direction:column;align-items:center;gap:0.5rem;">
                        <div style="width:100%;background:rgba(180,221,213,0.3);border-radius:0.5rem 0.5rem 0 0;height:${mood.count * 20}%;min-height:4px;"></div>
                        <span style="font-size:0.625rem;color:var(--on-surface-variant);">${mood.label}</span>
                    </div>
                </c:forEach>
            </div>
        </div>
        <!-- All Entries -->
        <div class="card">
            <h3 style="font-family:var(--font-headline);margin-bottom:1rem;">All Mood Entries</h3>
            <div class="table-container">
                <table><thead><tr><th>Date</th><th>Mood</th><th>Score</th><th>Journal</th></tr></thead>
                <tbody>
                <c:forEach var="e" items="${allEntries}">
                    <tr><td>${e.entryDate}</td><td>${e.moodEmoji} ${e.moodLabel}</td><td>${e.moodScore}/5</td><td style="max-width:300px;overflow:hidden;text-overflow:ellipsis;">${e.journalText != null ? e.journalText : '-'}</td></tr>
                </c:forEach>
                </tbody></table>
            </div>
        </div>
    </div>
</div>
<jsp:include page="common/footer.jsp"/>
</body>
</html>

