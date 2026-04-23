<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/><meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>MindHub — Dashboard</title>
    <jsp:include page="common/header.jsp"/>
</head>
<body>
<c:set var="activePage" value="dashboard" scope="request"/>
<jsp:include page="common/sidebar.jsp"/>

<div class="main-content">
    <!-- Top Bar -->
    <div class="topbar">
        <div>
            <h1 style="font-family:var(--font-headline);font-size:1.5rem;font-weight:800;">Welcome back, ${sessionScope.loggedInUser.fullName}</h1>
            <p style="color:var(--on-surface-variant);font-size:0.875rem;">How are you feeling today?</p>
        </div>
        <div style="display:flex;align-items:center;gap:1rem;">
            <a href="${pageContext.request.contextPath}/mood" class="btn btn-outline" style="font-size:0.8rem;">
                <span class="material-symbols-outlined" style="font-size:1.1rem;">add</span> Check In
            </a>
        </div>
    </div>

    <div class="page-content" style="display:flex;flex-direction:column;gap:2rem;">

        <!-- Alerts -->
        <c:if test="${param.error == 'unauthorized'}">
            <div class="alert alert-error">You don't have permission to access that page.</div>
        </c:if>

        <!-- Quick Stats Cards -->
        <section style="display:grid;grid-template-columns:repeat(auto-fit,minmax(200px,1fr));gap:1rem;">
            <div class="card" style="text-align:center;">
                <span class="material-symbols-outlined" style="font-size:2rem;color:var(--primary);margin-bottom:0.5rem;">local_fire_department</span>
                <div style="font-size:2rem;font-weight:900;color:var(--on-surface);">${progress != null ? progress.streakDays : 0}</div>
                <div style="font-size:0.75rem;color:var(--on-surface-variant);text-transform:uppercase;letter-spacing:0.1em;">Day Streak</div>
            </div>
            <div class="card" style="text-align:center;">
                <span class="material-symbols-outlined" style="font-size:2rem;color:var(--tertiary);margin-bottom:0.5rem;">stars</span>
                <div style="font-size:2rem;font-weight:900;color:var(--on-surface);">${progress != null ? progress.totalPoints : 0}</div>
                <div style="font-size:0.75rem;color:var(--on-surface-variant);text-transform:uppercase;letter-spacing:0.1em;">Points</div>
            </div>
            <div class="card" style="text-align:center;">
                <span class="material-symbols-outlined" style="font-size:2rem;color:var(--secondary);margin-bottom:0.5rem;">trending_up</span>
                <div style="font-size:2rem;font-weight:900;color:var(--on-surface);">Level ${progress != null ? progress.level : 1}</div>
                <div style="font-size:0.75rem;color:var(--on-surface-variant);text-transform:uppercase;letter-spacing:0.1em;">Wellness Level</div>
            </div>
            <div class="card" style="text-align:center;">
                <span class="material-symbols-outlined" style="font-size:2rem;color:var(--primary);margin-bottom:0.5rem;">emoji_events</span>
                <div style="font-size:2rem;font-weight:900;color:var(--on-surface);">${badges != null ? badges.size() : 0}</div>
                <div style="font-size:0.75rem;color:var(--on-surface-variant);text-transform:uppercase;letter-spacing:0.1em;">Badges</div>
            </div>
        </section>

        <!-- Mood + Recommendations Grid -->
        <section style="display:grid;grid-template-columns:2fr 1fr;gap:1.5rem;">
            <!-- Weekly Mood Chart -->
            <div class="card" style="position:relative;overflow:hidden;">
                <h3 style="font-family:var(--font-headline);font-size:1.25rem;margin-bottom:1.5rem;">Mood Journey</h3>
                <div style="display:flex;align-items:flex-end;justify-content:space-between;gap:0.5rem;height:12rem;padding:0 0.5rem;">
                    <c:forEach var="mood" items="${weeklyMood}">
                        <div style="width:100%;display:flex;flex-direction:column;align-items:center;gap:0.5rem;">
                            <div style="width:100%;background:rgba(180,221,213,0.2);border-radius:0.5rem 0.5rem 0 0;height:${mood.count * 20}%;transition:all 0.3s;"></div>
                            <span style="font-size:0.625rem;color:var(--on-surface-variant);">${mood.label}</span>
                        </div>
                    </c:forEach>
                </div>
                <c:if test="${empty weeklyMood}">
                    <p style="text-align:center;color:var(--on-surface-variant);padding:3rem;">No mood data yet. <a href="${pageContext.request.contextPath}/mood">Check in now!</a></p>
                </c:if>
            </div>

            <!-- Today's Mood Status -->
            <div class="card">
                <c:choose>
                    <c:when test="${todayMood != null}">
                        <div style="text-align:center;">
                            <div style="font-size:3rem;margin-bottom:0.5rem;">${todayMood.moodEmoji}</div>
                            <h4 style="font-size:1.125rem;font-weight:700;margin-bottom:0.25rem;">Today: ${todayMood.moodLabel}</h4>
                            <p style="font-size:0.75rem;color:var(--on-surface-variant);">You've checked in today!</p>
                            <div class="badge badge-primary" style="margin-top:1rem;">+10 pts earned</div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div style="text-align:center;">
                            <span class="material-symbols-outlined" style="font-size:3rem;color:var(--on-surface-variant);opacity:0.5;">sentiment_neutral</span>
                            <h4 style="margin-top:0.5rem;font-size:1rem;">Haven't checked in yet</h4>
                            <a href="${pageContext.request.contextPath}/mood" class="btn btn-primary" style="margin-top:1rem;font-size:0.8rem;">Check In Now</a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </section>

        <!-- Quick Links -->
        <section style="display:grid;grid-template-columns:repeat(auto-fit,minmax(240px,1fr));gap:1rem;">
            <a href="${pageContext.request.contextPath}/assessments" class="card" style="display:flex;align-items:center;gap:1rem;text-decoration:none;">
                <div style="width:3rem;height:3rem;border-radius:0.75rem;background:rgba(147,207,235,0.1);display:flex;align-items:center;justify-content:center;">
                    <span class="material-symbols-outlined" style="color:var(--secondary);">quiz</span>
                </div>
                <div><h4 style="font-size:0.95rem;">Self-Assessment</h4><p style="font-size:0.75rem;color:var(--on-surface-variant);">Take a wellness quiz</p></div>
            </a>
            <a href="${pageContext.request.contextPath}/content" class="card" style="display:flex;align-items:center;gap:1rem;text-decoration:none;">
                <div style="width:3rem;height:3rem;border-radius:0.75rem;background:rgba(255,205,118,0.1);display:flex;align-items:center;justify-content:center;">
                    <span class="material-symbols-outlined" style="color:var(--tertiary);">play_circle</span>
                </div>
                <div><h4 style="font-size:0.95rem;">Content Library</h4><p style="font-size:0.75rem;color:var(--on-surface-variant);">Videos & articles</p></div>
            </a>
            <a href="${pageContext.request.contextPath}/forum" class="card" style="display:flex;align-items:center;gap:1rem;text-decoration:none;">
                <div style="width:3rem;height:3rem;border-radius:0.75rem;background:rgba(180,221,213,0.1);display:flex;align-items:center;justify-content:center;">
                    <span class="material-symbols-outlined" style="color:var(--primary);">forum</span>
                </div>
                <div><h4 style="font-size:0.95rem;">Peer Forum</h4><p style="font-size:0.75rem;color:var(--on-surface-variant);">Connect anonymously</p></div>
            </a>
            <a href="${pageContext.request.contextPath}/support" class="card" style="display:flex;align-items:center;gap:1rem;text-decoration:none;">
                <div style="width:3rem;height:3rem;border-radius:0.75rem;background:rgba(147,207,235,0.1);display:flex;align-items:center;justify-content:center;">
                    <span class="material-symbols-outlined" style="color:var(--secondary);">support_agent</span>
                </div>
                <div><h4 style="font-size:0.95rem;">Book Support</h4><p style="font-size:0.75rem;color:var(--on-surface-variant);">Talk to a professional</p></div>
            </a>
        </section>

    </div>
</div>
<jsp:include page="common/footer.jsp"/>
</body>
</html>

