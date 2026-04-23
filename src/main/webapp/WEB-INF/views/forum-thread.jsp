<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head><meta charset="UTF-8"/><meta name="viewport" content="width=device-width, initial-scale=1.0"/><title>MindHub — Thread</title><jsp:include page="common/header.jsp"/></head>
<body>
<c:set var="activePage" value="forum" scope="request"/><jsp:include page="common/sidebar.jsp"/>
<div class="main-content">
    <div class="topbar">
        <div style="display:flex;align-items:center;gap:1rem;">
            <a href="${pageContext.request.contextPath}/forum" class="btn btn-outline" style="padding:0.4rem;border-radius:50%;"><span class="material-symbols-outlined">arrow_back</span></a>
            <h1 style="font-family:var(--font-headline);font-size:1.5rem;font-weight:800;">Discussion Thread</h1>
        </div>
    </div>
    <div class="page-content" style="max-width:800px;display:flex;flex-direction:column;gap:1.5rem;">
        <c:if test="${not empty success}"><div class="alert alert-success">${success}</div></c:if>

        <!-- Original Post -->
        <div class="card" style="border:1px solid var(--primary-container);">
            <div style="display:flex;align-items:center;gap:0.5rem;margin-bottom:1rem;">
                <span class="badge badge-secondary">${post.category}</span>
                <span style="font-size:0.875rem;color:var(--on-surface-variant);">Posted by <strong style="color:var(--primary);">${post.displayName}</strong> • ${post.createdAt}</span>
            </div>
            <h2 style="font-size:1.5rem;margin-bottom:1rem;">${post.title}</h2>
            <div style="font-size:1rem;line-height:1.6;white-space:pre-wrap;color:var(--on-surface);">${post.content}</div>
        </div>

        <h3 style="font-family:var(--font-headline);font-size:1.1rem;margin-top:1rem;color:var(--on-surface-variant);">Replies (${replies.size()})</h3>

        <!-- Replies -->
        <div style="display:flex;flex-direction:column;gap:1rem;">
            <c:forEach var="r" items="${replies}">
                <div class="card" style="background:var(--bg-container);">
                    <div style="font-size:0.8rem;color:var(--on-surface-variant);margin-bottom:0.5rem;">
                        <strong style="color:var(--on-surface);">${r.displayName}</strong> • ${r.createdAt}
                    </div>
                    <div style="font-size:0.95rem;line-height:1.5;white-space:pre-wrap;">${r.content}</div>
                </div>
            </c:forEach>
            <c:if test="${empty replies}">
                <p style="color:var(--on-surface-variant);text-align:center;padding:1rem;">No replies yet. Be the first to answer!</p>
            </c:if>
        </div>

        <!-- Add Reply -->
        <div class="card" style="margin-top:1rem;">
            <form action="${pageContext.request.contextPath}/forum/reply" method="post" style="display:flex;flex-direction:column;gap:1rem;">
                <input type="hidden" name="postId" value="${post.id}"/>
                <textarea name="content" class="form-input" placeholder="Write a supportive reply..." required style="min-height:80px;"></textarea>
                <div style="display:flex;justify-content:space-between;align-items:center;">
                    <label style="display:flex;align-items:center;gap:0.5rem;cursor:pointer;font-size:0.875rem;">
                        <input type="checkbox" name="anonymous" value="true" checked style="accent-color:var(--primary);"/>
                        Reply Anonymously
                    </label>
                    <button type="submit" class="btn btn-secondary">Post Reply</button>
                </div>
            </form>
        </div>
    </div>
</div>
<jsp:include page="common/footer.jsp"/>
</body>
</html>

