<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head><meta charset="UTF-8"/><meta name="viewport" content="width=device-width, initial-scale=1.0"/><title>MindHub — Peer Forum</title><jsp:include page="common/header.jsp"/></head>
<body>
<c:set var="activePage" value="forum" scope="request"/><jsp:include page="common/sidebar.jsp"/>
<div class="main-content">
    <div class="topbar">
        <h1 style="font-family:var(--font-headline);font-size:1.5rem;font-weight:800;">Peer Support Forum</h1>
    </div>
    <div class="page-content" style="display:flex;flex-direction:column;gap:2rem;">
        <c:if test="${not empty success}"><div class="alert alert-success">${success}</div></c:if>
        
        <!-- Post creation and filter -->
        <div style="display:grid;grid-template-columns:2fr 1fr;gap:1.5rem;">
            <!-- Create Post -->
            <div class="card">
                <h3 style="margin-bottom:1rem;font-family:var(--font-headline);">Start a Discussion</h3>
                <form action="${pageContext.request.contextPath}/forum/post" method="post" style="display:flex;flex-direction:column;gap:1rem;">
                    <input type="text" name="title" class="form-input" placeholder="Discussion title..." required/>
                    <textarea name="content" class="form-input" placeholder="Share your thoughts or ask a question..." required></textarea>
                    <div style="display:flex;justify-content:space-between;align-items:center;">
                        <div style="display:flex;gap:1rem;align-items:center;">
                            <select name="category" class="form-input" style="width:auto;padding:0.4rem;">
                                <option value="General">General</option>
                                <option value="Anxiety">Anxiety</option>
                                <option value="Stress">Academic Stress</option>
                                <option value="Sleep">Sleep</option>
                                <option value="Relationships">Relationships</option>
                            </select>
                            <label style="display:flex;align-items:center;gap:0.5rem;cursor:pointer;font-size:0.875rem;">
                                <input type="checkbox" name="anonymous" value="true" checked style="accent-color:var(--primary);"/>
                                Post Anonymously
                            </label>
                        </div>
                        <button type="submit" class="btn btn-primary">Post</button>
                    </div>
                </form>
            </div>
            <!-- Filter -->
            <div class="card">
                <h3 style="margin-bottom:1rem;font-family:var(--font-headline);">Categories</h3>
                <div style="display:flex;flex-direction:column;gap:0.5rem;">
                    <a href="${pageContext.request.contextPath}/forum" class="btn ${empty selectedCategory ? 'btn-primary' : 'btn-outline'}" style="justify-content:flex-start;">All Topics</a>
                    <a href="${pageContext.request.contextPath}/forum?category=Anxiety" class="btn ${selectedCategory == 'Anxiety' ? 'btn-primary' : 'btn-outline'}" style="justify-content:flex-start;">Anxiety</a>
                    <a href="${pageContext.request.contextPath}/forum?category=Stress" class="btn ${selectedCategory == 'Stress' ? 'btn-primary' : 'btn-outline'}" style="justify-content:flex-start;">Academic Stress</a>
                    <a href="${pageContext.request.contextPath}/forum?category=Sleep" class="btn ${selectedCategory == 'Sleep' ? 'btn-primary' : 'btn-outline'}" style="justify-content:flex-start;">Sleep</a>
                </div>
            </div>
        </div>

        <!-- Post List -->
        <div style="display:flex;flex-direction:column;gap:1rem;">
            <c:forEach var="p" items="${posts}">
                <div class="card" style="display:flex;flex-direction:column;gap:1rem;transition:all 0.2s;">
                    <div style="display:flex;justify-content:space-between;align-items:flex-start;">
                        <div>
                            <div style="display:flex;align-items:center;gap:0.5rem;margin-bottom:0.5rem;">
                                <span class="badge badge-secondary">${p.category}</span>
                                <span style="font-size:0.75rem;color:var(--on-surface-variant);">
                                    Posted by <strong style="color:var(--on-surface);">${p.displayName}</strong> • ${p.createdAt}
                                </span>
                            </div>
                            <h3 style="font-size:1.25rem;"><a href="${pageContext.request.contextPath}/forum/thread/${p.id}" style="color:inherit;text-decoration:none;">${p.title}</a></h3>
                        </div>
                        <form action="${pageContext.request.contextPath}/forum/report/${p.id}" method="post" onsubmit="return confirm('Report this post?');">
                            <button type="submit" class="btn" style="background:transparent;color:var(--on-surface-variant);padding:0.2rem;" title="Report"><span class="material-symbols-outlined" style="font-size:1.2rem;">flag</span></button>
                        </form>
                    </div>
                    <p style="color:var(--on-surface-variant);font-size:0.9rem;display:-webkit-box;-webkit-line-clamp:3;-webkit-box-orient:vertical;overflow:hidden;">${p.content}</p>
                    <div style="display:flex;justify-content:space-between;align-items:center;border-top:1px solid rgba(65,72,70,0.2);padding-top:0.75rem;margin-top:0.5rem;">
                        <span style="font-size:0.875rem;color:var(--on-surface-variant);display:flex;align-items:center;gap:0.25rem;">
                            <span class="material-symbols-outlined" style="font-size:1.1rem;">forum</span> ${p.replyCount} Replies
                        </span>
                        <a href="${pageContext.request.contextPath}/forum/thread/${p.id}" class="btn btn-outline" style="padding:0.4rem 1rem;font-size:0.8rem;">View Thread</a>
                    </div>
                </div>
            </c:forEach>
            <c:if test="${empty posts}">
                <div class="card" style="text-align:center;padding:3rem;color:var(--on-surface-variant);">No posts found. Start the discussion!</div>
            </c:if>
        </div>
    </div>
</div>
<jsp:include page="common/footer.jsp"/>
</body>
</html>

