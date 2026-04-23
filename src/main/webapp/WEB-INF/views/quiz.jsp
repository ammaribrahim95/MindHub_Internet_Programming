<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head><meta charset="UTF-8"/><meta name="viewport" content="width=device-width, initial-scale=1.0"/><title>MindHub — ${assessment.title}</title><jsp:include page="common/header.jsp"/></head>
<body>
<c:set var="activePage" value="assessments" scope="request"/><jsp:include page="common/sidebar.jsp"/>
<div class="main-content">
    <div class="topbar"><h1 style="font-family:var(--font-headline);font-size:1.5rem;font-weight:800;">${assessment.title}</h1></div>
    <div class="page-content" style="max-width:700px;">
        <div class="card" style="margin-bottom:1.5rem;">
            <p style="color:var(--on-surface-variant);">${assessment.description}</p>
            <span class="badge badge-secondary" style="margin-top:0.5rem;">${assessment.category}</span>
        </div>
        <form action="${pageContext.request.contextPath}/assessment/${assessment.id}/submit" method="post">
            <c:forEach var="q" items="${questions}" varStatus="status">
                <div class="card fade-in" style="margin-bottom:1rem;animation-delay:${status.index * 0.1}s;">
                    <p style="font-weight:600;margin-bottom:1rem;"><span style="color:var(--secondary);margin-right:0.5rem;">Q${status.index + 1}.</span>${q.questionText}</p>
                    <div style="display:flex;flex-direction:column;gap:0.5rem;">
                        <label style="display:flex;align-items:center;gap:0.75rem;padding:0.75rem;background:var(--bg-container);border-radius:var(--radius-md);cursor:pointer;transition:background 0.2s;">
                            <input type="radio" name="answer" value="A" required style="accent-color:var(--primary);"/> ${q.optionA}
                        </label>
                        <label style="display:flex;align-items:center;gap:0.75rem;padding:0.75rem;background:var(--bg-container);border-radius:var(--radius-md);cursor:pointer;">
                            <input type="radio" name="answer" value="B"/> ${q.optionB}
                        </label>
                        <c:if test="${q.optionC != null}">
                            <label style="display:flex;align-items:center;gap:0.75rem;padding:0.75rem;background:var(--bg-container);border-radius:var(--radius-md);cursor:pointer;">
                                <input type="radio" name="answer" value="C"/> ${q.optionC}
                            </label>
                        </c:if>
                        <c:if test="${q.optionD != null}">
                            <label style="display:flex;align-items:center;gap:0.75rem;padding:0.75rem;background:var(--bg-container);border-radius:var(--radius-md);cursor:pointer;">
                                <input type="radio" name="answer" value="D"/> ${q.optionD}
                            </label>
                        </c:if>
                    </div>
                </div>
            </c:forEach>
            <button class="btn btn-primary" type="submit" style="width:100%;padding:1rem;font-size:1rem;margin-top:1rem;">Submit Assessment</button>
        </form>
    </div>
</div>
<jsp:include page="common/footer.jsp"/>
</body>
</html>

