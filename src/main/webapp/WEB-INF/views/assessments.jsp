<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head><meta charset="UTF-8"/><meta name="viewport" content="width=device-width, initial-scale=1.0"/><title>MindHub — Self-Assessments</title><jsp:include page="common/header.jsp"/></head>
<body>
<c:set var="activePage" value="assessments" scope="request"/><jsp:include page="common/sidebar.jsp"/>
<div class="main-content">
    <div class="topbar"><h1 style="font-family:var(--font-headline);font-size:1.5rem;font-weight:800;">Self-Assessment</h1></div>
    <div class="page-content" style="display:flex;flex-direction:column;gap:2rem;">
        <c:if test="${not empty success}"><div class="alert alert-success">${success}</div></c:if>
        <div style="display:flex;justify-content:space-between;align-items:center;">
            <div><p style="color:var(--on-surface-variant);">Choose a wellness assessment to check in with yourself.</p></div>
            <a href="${pageContext.request.contextPath}/assessment/results" class="btn btn-outline">View My Results</a>
        </div>
        <div style="display:grid;grid-template-columns:repeat(auto-fill,minmax(280px,1fr));gap:1.5rem;">
            <c:forEach var="a" items="${assessments}">
                <div class="card" style="display:flex;flex-direction:column;">
                    <div style="display:flex;align-items:center;gap:0.75rem;margin-bottom:1rem;">
                        <div style="width:3rem;height:3rem;border-radius:0.75rem;background:rgba(147,207,235,0.1);display:flex;align-items:center;justify-content:center;">
                            <span class="material-symbols-outlined" style="color:var(--secondary);">psychology</span>
                        </div>
                        <div><span class="badge badge-secondary">${a.category}</span></div>
                    </div>
                    <h3 style="font-size:1.125rem;margin-bottom:0.5rem;">${a.title}</h3>
                    <p style="font-size:0.875rem;color:var(--on-surface-variant);flex:1;">${a.description}</p>
                    <div style="display:flex;justify-content:space-between;align-items:center;margin-top:1rem;">
                        <span style="font-size:0.75rem;color:var(--on-surface-variant);">${a.totalQuestions} questions</span>
                        <a href="${pageContext.request.contextPath}/assessment/${a.id}" class="btn btn-primary" style="font-size:0.8rem;">Take Quiz</a>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</div>
<jsp:include page="common/footer.jsp"/>
</body>
</html>

