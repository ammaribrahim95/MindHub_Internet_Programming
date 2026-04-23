<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head><meta charset="UTF-8"/><meta name="viewport" content="width=device-width, initial-scale=1.0"/><title>MindHub Admin — Add Content</title><jsp:include page="common/header.jsp"/></head>
<body>
<c:set var="activePage" value="content" scope="request"/><jsp:include page="common/sidebar.jsp"/>
<div class="main-content">
    <div class="topbar">
        <div style="display:flex;align-items:center;gap:1rem;">
            <a href="${pageContext.request.contextPath}/content" class="btn btn-outline" style="padding:0.4rem;border-radius:50%;"><span class="material-symbols-outlined">arrow_back</span></a>
            <h1 style="font-family:var(--font-headline);font-size:1.5rem;font-weight:800;">Add New Content</h1>
        </div>
    </div>
    <div class="page-content" style="max-width:800px;">
        <div class="card">
            <form action="${pageContext.request.contextPath}/admin/content/add" method="post" style="display:flex;flex-direction:column;gap:1.5rem;">
                <div>
                    <label class="form-label">Title</label>
                    <input type="text" name="title" class="form-input" required placeholder="e.g. 5-Minute Morning Meditation"/>
                </div>
                
                <div style="display:grid;grid-template-columns:1fr 1fr;gap:1.5rem;">
                    <div>
                        <label class="form-label">Content Type</label>
                        <select name="contentType" class="form-input" required>
                            <option value="VIDEO">Video</option>
                            <option value="ARTICLE">Article</option>
                            <option value="AUDIO">Audio</option>
                        </select>
                    </div>
                    <div>
                        <label class="form-label">Category</label>
                        <input type="text" name="category" class="form-input" required placeholder="e.g. Mindfulness" list="categoryList"/>
                        <datalist id="categoryList">
                            <c:forEach var="c" items="${categories}">
                                <option value="${c}">
                            </c:forEach>
                        </datalist>
                    </div>
                </div>

                <div style="display:grid;grid-template-columns:2fr 1fr;gap:1.5rem;">
                    <div>
                        <label class="form-label">External URL (optional)</label>
                        <input type="url" name="url" class="form-input" placeholder="https://youtube.com/..."/>
                    </div>
                    <div>
                        <label class="form-label">Duration</label>
                        <input type="text" name="duration" class="form-input" placeholder="e.g. 5 mins"/>
                    </div>
                </div>

                <div>
                    <label class="form-label">Description / Content Body</label>
                    <textarea name="description" class="form-input" required style="min-height:150px;" placeholder="Provide a summary or the full article content here..."></textarea>
                </div>

                <button type="submit" class="btn btn-primary" style="padding:1rem;">Publish Content</button>
            </form>
        </div>
    </div>
</div>
<jsp:include page="common/footer.jsp"/>
</body>
</html>

