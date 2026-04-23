<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head><meta charset="UTF-8"/><meta name="viewport" content="width=device-width, initial-scale=1.0"/><title>MindHub — ${content.title}</title><jsp:include page="common/header.jsp"/></head>
<body>
<c:set var="activePage" value="content" scope="request"/><jsp:include page="common/sidebar.jsp"/>
<div class="main-content">
    <div class="topbar">
        <div style="display:flex;align-items:center;gap:1rem;">
            <a href="${pageContext.request.contextPath}/content" class="btn btn-outline" style="padding:0.4rem;border-radius:50%;"><span class="material-symbols-outlined">arrow_back</span></a>
            <h1 style="font-family:var(--font-headline);font-size:1.5rem;font-weight:800;">Content Details</h1>
        </div>
        <c:if test="${sessionScope.loggedInUser.role == 'ADMIN'}">
            <form action="${pageContext.request.contextPath}/admin/content/delete/${content.id}" method="post" onsubmit="return confirmDelete(this, 'content');">
                <button type="submit" class="btn btn-danger" style="padding:0.5rem 1rem;"><span class="material-symbols-outlined" style="font-size:1.2rem;">delete</span> Delete</button>
            </form>
        </c:if>
    </div>
    <div class="page-content" style="max-width:800px;">
        <div class="card" style="overflow:hidden;padding:0;">
            <div style="height:250px;background:var(--bg-container);display:flex;align-items:center;justify-content:center;">
                <c:choose>
                    <c:when test="${content.contentType == 'VIDEO'}"><span class="material-symbols-outlined" style="font-size:5rem;color:var(--primary);">play_circle</span></c:when>
                    <c:when test="${content.contentType == 'ARTICLE'}"><span class="material-symbols-outlined" style="font-size:5rem;color:var(--secondary);">article</span></c:when>
                    <c:otherwise><span class="material-symbols-outlined" style="font-size:5rem;color:var(--tertiary);">self_improvement</span></c:otherwise>
                </c:choose>
            </div>
            <div style="padding:2rem;">
                <div style="display:flex;gap:0.5rem;margin-bottom:1rem;">
                    <span class="badge badge-secondary">${content.category}</span>
                    <span class="badge badge-primary">${content.contentType}</span>
                </div>
                <h2 style="font-size:2rem;margin-bottom:1rem;">${content.title}</h2>
                <div style="display:flex;align-items:center;gap:1.5rem;color:var(--on-surface-variant);font-size:0.875rem;margin-bottom:2rem;border-bottom:1px solid rgba(65,72,70,0.2);padding-bottom:1rem;">
                    <span style="display:flex;align-items:center;gap:0.25rem;"><span class="material-symbols-outlined" style="font-size:1.1rem;">schedule</span> ${content.duration}</span>
                    <span style="display:flex;align-items:center;gap:0.25rem;"><span class="material-symbols-outlined" style="font-size:1.1rem;">calendar_today</span> ${content.createdAt}</span>
                </div>
                <div style="line-height:1.8;font-size:1rem;color:var(--on-surface);white-space:pre-wrap;">${content.description}</div>
                
                <c:if test="${not empty content.url}">
                    <div style="margin-top:2rem;text-align:center;">
                        <a href="${content.url}" target="_blank" class="btn btn-primary" style="padding:1rem 2rem;font-size:1rem;">
                            <c:choose>
                                <c:when test="${content.contentType == 'VIDEO'}"><span class="material-symbols-outlined">play_arrow</span> Watch Video</c:when>
                                <c:otherwise><span class="material-symbols-outlined">open_in_new</span> Open Resource</c:otherwise>
                            </c:choose>
                        </a>
                    </div>
                </c:if>
            </div>
        </div>
    </div>
</div>
<jsp:include page="common/footer.jsp"/>
</body>
</html>

