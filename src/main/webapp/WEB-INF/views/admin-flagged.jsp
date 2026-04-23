<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head><meta charset="UTF-8"/><meta name="viewport" content="width=device-width, initial-scale=1.0"/><title>MindHub Admin — Moderation</title><jsp:include page="common/header.jsp"/></head>
<body>
<c:set var="activePage" value="admin" scope="request"/><jsp:include page="common/sidebar.jsp"/>
<div class="main-content">
    <div class="topbar">
        <div style="display:flex;align-items:center;gap:1rem;">
            <a href="${pageContext.request.contextPath}/admin" class="btn btn-outline" style="padding:0.4rem;border-radius:50%;"><span class="material-symbols-outlined">arrow_back</span></a>
            <h1 style="font-family:var(--font-headline);font-size:1.5rem;font-weight:800;color:var(--error);">Flagged Posts Moderation</h1>
        </div>
    </div>
    <div class="page-content">
        <c:if test="${not empty success}"><div class="alert alert-success">${success}</div></c:if>

        <p style="color:var(--on-surface-variant);margin-bottom:1.5rem;">Posts reported multiple times by users appear here for administrative review.</p>

        <div style="display:flex;flex-direction:column;gap:1rem;">
            <c:forEach var="p" items="${flaggedPosts}">
                <div class="card" style="border-left:4px solid var(--error);">
                    <div style="display:flex;justify-content:space-between;align-items:flex-start;">
                        <div>
                            <span class="badge badge-danger" style="margin-bottom:0.5rem;"><span class="material-symbols-outlined" style="font-size:0.8rem;margin-right:2px;">flag</span> ${p.reportCount} Reports</span>
                            <h3 style="font-size:1.2rem;">${p.title}</h3>
                            <div style="font-size:0.8rem;color:var(--on-surface-variant);margin-bottom:1rem;">Posted by ${p.displayName} on ${p.createdAt} in ${p.category}</div>
                            <div style="background:var(--bg-container);padding:1rem;border-radius:var(--radius-md);font-size:0.9rem;white-space:pre-wrap;">${p.content}</div>
                        </div>
                        <div style="display:flex;flex-direction:column;gap:0.5rem;margin-left:2rem;">
                            <form action="${pageContext.request.contextPath}/admin/forum/remove/${p.id}" method="post" onsubmit="return confirmDelete(this, 'post');">
                                <button type="submit" class="btn btn-danger" style="width:100%;"><span class="material-symbols-outlined">delete_forever</span> Remove Post</button>
                            </form>
                            <!-- You could add a 'Dismiss/Unflag' button here if implemented in controller -->
                        </div>
                    </div>
                </div>
            </c:forEach>
            <c:if test="${empty flaggedPosts}">
                <div class="card" style="text-align:center;padding:3rem;color:var(--on-surface-variant);">No flagged posts to review. Community looks safe!</div>
            </c:if>
        </div>
    </div>
</div>
<jsp:include page="common/footer.jsp"/>
</body>
</html>

