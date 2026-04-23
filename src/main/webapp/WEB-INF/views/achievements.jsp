<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/><meta name="viewport" content="width=device-width, initial-scale=1.0"/><title>MindHub — Achievements</title><jsp:include page="common/header.jsp"/>
</head>
<body>
<c:set var="activePage" value="achievements" scope="request"/><jsp:include page="common/sidebar.jsp"/>
<div class="main-content">
    <div class="topbar"><h1 style="font-family:var(--font-headline);font-size:1.5rem;font-weight:800;">Achievements & Rewards</h1></div>
    <div class="page-content" style="display:flex;flex-direction:column;gap:2rem;">
        
        <!-- Progress Summary -->
        <div class="card" style="display:flex;flex-wrap:wrap;align-items:center;justify-content:space-between;gap:2rem;">
            <div>
                <h2 style="font-size:1.5rem;margin-bottom:0.5rem;">Current Level: ${progress.level}</h2>
                <p style="color:var(--on-surface-variant);">You have <span style="color:var(--tertiary);font-weight:700;">${progress.totalPoints} points</span>.</p>
                <div style="width:200px;height:8px;background:var(--bg-surface);border-radius:4px;margin-top:0.5rem;overflow:hidden;">
                    <div style="height:100%;background:linear-gradient(90deg,var(--tertiary),var(--tertiary-container));width:${(progress.totalPoints % 300) / 3}%;"></div>
                </div>
                <p style="font-size:0.75rem;color:var(--on-surface-variant);margin-top:0.25rem;">${300 - (progress.totalPoints % 300)} pts to next level</p>
            </div>
            <div style="display:flex;gap:1.5rem;">
                <div style="text-align:center;">
                    <div style="font-size:2.5rem;font-weight:900;color:var(--primary);">${progress.streakDays}</div>
                    <div style="font-size:0.75rem;color:var(--on-surface-variant);text-transform:uppercase;">Day Streak</div>
                </div>
                <div style="text-align:center;">
                    <div style="font-size:2.5rem;font-weight:900;color:var(--secondary);">${earnedBadges != null ? earnedBadges.size() : 0}</div>
                    <div style="font-size:0.75rem;color:var(--on-surface-variant);text-transform:uppercase;">Badges Earned</div>
                </div>
            </div>
        </div>

        <!-- Badges Grid -->
        <h3 style="font-family:var(--font-headline);font-size:1.25rem;">Your Badges</h3>
        <div style="display:grid;grid-template-columns:repeat(auto-fill,minmax(250px,1fr));gap:1rem;">
            <c:forEach var="b" items="${allBadges}">
                <div class="card" style="text-align:center;display:flex;flex-direction:column;align-items:center;opacity:${b.earned ? '1' : '0.5'};filter:${b.earned ? 'none' : 'grayscale(100%)'};transition:all 0.3s;">
                    <div style="width:4rem;height:4rem;border-radius:50%;background:${b.earned ? 'rgba(255,205,118,0.2)' : 'var(--bg-container)'};display:flex;align-items:center;justify-content:center;margin-bottom:1rem;border:2px solid ${b.earned ? 'var(--tertiary)' : 'var(--outline)'};">
                        <span class="material-symbols-outlined" style="font-size:2rem;color:${b.earned ? 'var(--tertiary)' : 'var(--outline)'};">emoji_events</span>
                    </div>
                    <h4 style="font-weight:700;margin-bottom:0.25rem;">${b.name}</h4>
                    <p style="font-size:0.75rem;color:var(--on-surface-variant);flex:1;">${b.description}</p>
                    <div style="margin-top:1rem;font-size:0.75rem;font-weight:600;color:${b.earned ? 'var(--primary)' : 'var(--on-surface-variant)'};">
                        ${b.earned ? 'Earned on ' : '+'} ${b.earned ? b.earnedAt : b.points += ' pts'}
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</div>
<jsp:include page="common/footer.jsp"/>
</body>
</html>

