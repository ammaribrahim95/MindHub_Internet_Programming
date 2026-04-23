<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head><meta charset="UTF-8"/><meta name="viewport" content="width=device-width, initial-scale=1.0"/><title>MindHub — Results</title><jsp:include page="common/header.jsp"/></head>
<body>
<c:set var="activePage" value="assessments" scope="request"/><jsp:include page="common/sidebar.jsp"/>
<div class="main-content">
    <div class="topbar"><h1 style="font-family:var(--font-headline);font-size:1.5rem;font-weight:800;">Assessment Results</h1></div>
    <div class="page-content">
        <c:if test="${not empty success}"><div class="alert alert-success">${success}</div></c:if>
        <div class="card">
            <div class="table-container">
                <table><thead><tr><th>Assessment</th><th>Score</th><th>Percentage</th><th>Date</th></tr></thead>
                <tbody>
                <c:forEach var="r" items="${results}">
                    <tr><td>${r.assessmentTitle}</td><td>${r.score}/${r.totalPoints}</td><td><span class="badge ${r.percentage >= 70 ? 'badge-primary' : r.percentage >= 40 ? 'badge-tertiary' : 'badge-danger'}">${r.percentage}%</span></td><td>${r.completedAt}</td></tr>
                </c:forEach>
                </tbody></table>
            </div>
            <c:if test="${empty results}"><p style="text-align:center;color:var(--on-surface-variant);padding:2rem;">No results yet. <a href="${pageContext.request.contextPath}/assessments">Take an assessment!</a></p></c:if>
        </div>
    </div>
</div>
<jsp:include page="common/footer.jsp"/>
</body>
</html>

