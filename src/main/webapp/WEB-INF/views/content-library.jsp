<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head><meta charset="UTF-8"/><meta name="viewport" content="width=device-width, initial-scale=1.0"/><title>MindHub — Content Library</title><jsp:include page="common/header.jsp"/></head>
<body>
<c:set var="activePage" value="content" scope="request"/><jsp:include page="common/sidebar.jsp"/>
<div class="main-content">
    <div class="topbar">
        <h1 style="font-family:var(--font-headline);font-size:1.5rem;font-weight:800;">Content Library</h1>
        <c:if test="${sessionScope.loggedInUser.role == 'ADMIN'}">
            <a href="${pageContext.request.contextPath}/admin/content/add" class="btn btn-primary" style="padding:0.5rem 1rem;"><span class="material-symbols-outlined" style="font-size:1.2rem;">add</span> Add Content</a>
        </c:if>
    </div>
    <div class="page-content" style="display:flex;flex-direction:column;gap:2rem;">
        <c:if test="${not empty success}"><div class="alert alert-success">${success}</div></c:if>

        <!-- Search and Filter -->
        <div class="card" style="padding:1rem 1.5rem;">
            <form action="${pageContext.request.contextPath}/content" method="get" style="display:flex;gap:1rem;align-items:center;flex-wrap:wrap;">
                <div style="flex:1;min-width:200px;">
                    <input type="text" name="keyword" value="${keyword}" class="form-input" placeholder="Search topics..." style="padding:0.5rem;border-radius:var(--radius-sm);"/>
                </div>
                <div style="width:200px;">
                    <select name="category" class="form-input" style="padding:0.5rem;">
                        <option value="">All Categories</option>
                        <c:forEach var="c" items="${categories}">
                            <option value="${c}" ${c == selectedCategory ? 'selected' : ''}>${c}</option>
                        </c:forEach>
                    </select>
                </div>
                <button type="submit" class="btn btn-secondary">Search</button>
                <c:if test="${not empty keyword or not empty selectedCategory}">
                    <a href="${pageContext.request.contextPath}/content" class="btn btn-outline">Clear</a>
                </c:if>
            </form>
        </div>

        <!-- Content Grid -->
        <div style="display:grid;grid-template-columns:repeat(auto-fill,minmax(280px,1fr));gap:1.5rem;">
            <c:forEach var="c" items="${contentList}">
                <div class="card" style="display:flex;flex-direction:column;padding:0;overflow:hidden;">
                    <div style="height:140px;background:linear-gradient(45deg,var(--bg-container-high),var(--primary-container));display:flex;align-items:center;justify-content:center;position:relative;">
                        <c:choose>
                            <c:when test="${c.contentType == 'VIDEO'}"><span class="material-symbols-outlined" style="font-size:4rem;color:rgba(255,255,255,0.8);">play_circle</span></c:when>
                            <c:when test="${c.contentType == 'ARTICLE'}"><span class="material-symbols-outlined" style="font-size:4rem;color:rgba(255,255,255,0.8);">article</span></c:when>
                            <c:otherwise><span class="material-symbols-outlined" style="font-size:4rem;color:rgba(255,255,255,0.8);">self_improvement</span></c:otherwise>
                        </c:choose>
                        <span class="badge badge-secondary" style="position:absolute;top:1rem;right:1rem;">${c.category}</span>
                    </div>
                    <div style="padding:1.5rem;display:flex;flex-direction:column;flex:1;">
                        <h3 style="font-size:1.1rem;margin-bottom:0.5rem;">${c.title}</h3>
                        <p style="font-size:0.875rem;color:var(--on-surface-variant);flex:1;margin-bottom:1rem;display:-webkit-box;-webkit-line-clamp:2;-webkit-box-orient:vertical;overflow:hidden;">${c.description}</p>
                        <div style="display:flex;justify-content:space-between;align-items:center;">
                            <span style="font-size:0.75rem;color:var(--on-surface-variant);font-weight:600;"><span class="material-symbols-outlined" style="font-size:0.9rem;vertical-align:middle;margin-right:2px;">schedule</span> ${c.duration}</span>
                            <a href="${pageContext.request.contextPath}/content/${c.id}" class="btn btn-outline" style="padding:0.4rem 0.8rem;font-size:0.75rem;">View</a>
                        </div>
                    </div>
                </div>
            </c:forEach>
            <c:if test="${empty contentList}">
                <div style="grid-column:1/-1;text-align:center;padding:3rem;color:var(--on-surface-variant);">No content found matching your criteria.</div>
            </c:if>
        </div>
    </div>
</div>
<jsp:include page="common/footer.jsp"/>
</body>
</html>

