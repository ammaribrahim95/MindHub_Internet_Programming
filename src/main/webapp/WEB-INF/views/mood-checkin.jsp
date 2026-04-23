<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/><meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>MindHub — Mood Check-in</title>
    <jsp:include page="common/header.jsp"/>
</head>
<body>
<c:set var="activePage" value="mood" scope="request"/>
<jsp:include page="common/sidebar.jsp"/>
<div class="main-content">
    <div class="topbar"><h1 style="font-family:var(--font-headline);font-size:1.5rem;font-weight:800;">Daily Mood Check-in</h1></div>
    <div class="page-content" style="display:flex;flex-direction:column;gap:2rem;">
        <c:if test="${not empty success}"><div class="alert alert-success">${success}</div></c:if>
        <c:if test="${not empty error}"><div class="alert alert-error">${error}</div></c:if>

        <c:choose>
            <c:when test="${todayMood != null}">
                <div class="card" style="text-align:center;padding:3rem;">
                    <div style="font-size:4rem;margin-bottom:1rem;">${todayMood.moodEmoji}</div>
                    <h2 style="font-size:1.5rem;margin-bottom:0.5rem;">Today's Mood: ${todayMood.moodLabel}</h2>
                    <p style="color:var(--on-surface-variant);">You've already checked in today. Come back tomorrow!</p>
                    <c:if test="${not empty todayMood.journalText}">
                        <div style="margin-top:1.5rem;padding:1rem;background:var(--bg-container);border-radius:var(--radius-lg);text-align:left;">
                            <p style="font-size:0.75rem;color:var(--on-surface-variant);margin-bottom:0.5rem;">Journal Entry:</p>
                            <p>${todayMood.journalText}</p>
                        </div>
                    </c:if>
                </div>
            </c:when>
            <c:otherwise>
                <div class="card" style="text-align:center;padding:2rem;">
                    <h2 style="font-size:1.5rem;margin-bottom:0.5rem;">How are you feeling right now?</h2>
                    <p style="color:var(--on-surface-variant);margin-bottom:2rem;">Select your mood to check in for today.</p>
                    <form action="${pageContext.request.contextPath}/mood/checkin" method="post">
                        <div style="display:flex;justify-content:center;gap:1rem;margin-bottom:2rem;flex-wrap:wrap;" id="moodSelector">
                            <label class="mood-btn"><input type="radio" name="moodScore" value="1" style="display:none;" required/>😢<span style="font-size:0.7rem;color:var(--on-surface-variant);">Very Low</span></label>
                            <label class="mood-btn"><input type="radio" name="moodScore" value="2" style="display:none;"/>😟<span style="font-size:0.7rem;color:var(--on-surface-variant);">Low</span></label>
                            <label class="mood-btn"><input type="radio" name="moodScore" value="3" style="display:none;"/>😐<span style="font-size:0.7rem;color:var(--on-surface-variant);">Neutral</span></label>
                            <label class="mood-btn"><input type="radio" name="moodScore" value="4" style="display:none;"/>😊<span style="font-size:0.7rem;color:var(--on-surface-variant);">Good</span></label>
                            <label class="mood-btn"><input type="radio" name="moodScore" value="5" style="display:none;"/>😄<span style="font-size:0.7rem;color:var(--on-surface-variant);">Great</span></label>
                        </div>
                        <div style="max-width:500px;margin:0 auto 1.5rem;text-align:left;">
                            <label class="form-label">Journal (optional)</label>
                            <textarea class="form-input" name="journalText" placeholder="Write about your day..."></textarea>
                        </div>
                        <button class="btn btn-primary" type="submit" style="padding:0.75rem 3rem;">Log My Mood</button>
                    </form>
                </div>
            </c:otherwise>
        </c:choose>

        <!-- Recent Moods -->
        <div class="card">
            <h3 style="font-family:var(--font-headline);margin-bottom:1rem;">Recent Entries</h3>
            <c:choose>
                <c:when test="${not empty recentMoods}">
                    <div style="display:flex;flex-direction:column;gap:0.5rem;">
                        <c:forEach var="m" items="${recentMoods}">
                            <div style="display:flex;align-items:center;gap:1rem;padding:0.75rem;background:var(--bg-container);border-radius:var(--radius-md);">
                                <span style="font-size:1.5rem;">${m.moodEmoji}</span>
                                <div style="flex:1;">
                                    <span style="font-weight:600;">${m.moodLabel}</span>
                                    <span style="font-size:0.75rem;color:var(--on-surface-variant);margin-left:0.5rem;">${m.entryDate}</span>
                                </div>
                                <span class="badge badge-primary">Score: ${m.moodScore}/5</span>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise><p style="color:var(--on-surface-variant);">No mood entries yet.</p></c:otherwise>
            </c:choose>
        </div>
    </div>
</div>
<script>
    // Mood button selection
    document.querySelectorAll('.mood-btn').forEach(function(btn) {
        btn.addEventListener('click', function() {
            document.querySelectorAll('.mood-btn').forEach(function(b) { b.classList.remove('selected'); });
            btn.classList.add('selected');
        });
    });
</script>
<jsp:include page="common/footer.jsp"/>
</body>
</html>

