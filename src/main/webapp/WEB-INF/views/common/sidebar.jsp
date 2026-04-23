<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!-- MindHub — Sidebar Navigation -->
<aside class="sidebar" id="sidebar">
    <!-- Brand -->
    <div style="padding: 1.5rem 1rem; display:flex; align-items:center; gap:0.75rem;">
        <div style="width:2.5rem;height:2.5rem;border-radius:0.75rem;background:linear-gradient(135deg,var(--primary),var(--secondary));display:flex;align-items:center;justify-content:center;">
            <span class="material-symbols-outlined" style="color:var(--on-primary);">psychology</span>
        </div>
        <div>
            <h2 style="font-size:1.125rem;font-weight:900;color:var(--primary);font-family:var(--font-headline);">MindHub</h2>
            <p style="font-size:0.625rem;text-transform:uppercase;letter-spacing:0.15em;color:var(--on-surface-variant);">Student Wellness</p>
        </div>
    </div>

    <!-- Navigation -->
    <nav style="flex:1; display:flex; flex-direction:column; gap:0.25rem;">
        <a href="${pageContext.request.contextPath}/dashboard" class="nav-link ${activePage == 'dashboard' ? 'active' : ''}">
            <span class="material-symbols-outlined">dashboard</span> Dashboard
        </a>
        <a href="${pageContext.request.contextPath}/mood" class="nav-link ${activePage == 'mood' ? 'active' : ''}">
            <span class="material-symbols-outlined">mood</span> Mood Check-in
        </a>
        <a href="${pageContext.request.contextPath}/mood/analytics" class="nav-link ${activePage == 'mood-analytics' ? 'active' : ''}">
            <span class="material-symbols-outlined">analytics</span> Mood Analytics
        </a>
        <a href="${pageContext.request.contextPath}/assessments" class="nav-link ${activePage == 'assessments' ? 'active' : ''}">
            <span class="material-symbols-outlined">quiz</span> Self-Assessment
        </a>
        <a href="${pageContext.request.contextPath}/content" class="nav-link ${activePage == 'content' ? 'active' : ''}">
            <span class="material-symbols-outlined">library_books</span> Content Library
        </a>
        <a href="${pageContext.request.contextPath}/forum" class="nav-link ${activePage == 'forum' ? 'active' : ''}">
            <span class="material-symbols-outlined">forum</span> Peer Forum
        </a>
        <a href="${pageContext.request.contextPath}/support" class="nav-link ${activePage == 'support' ? 'active' : ''}">
            <span class="material-symbols-outlined">support_agent</span> Virtual Support
        </a>
        <a href="${pageContext.request.contextPath}/achievements" class="nav-link ${activePage == 'achievements' ? 'active' : ''}">
            <span class="material-symbols-outlined">emoji_events</span> Achievements
        </a>

        <c:if test="${sessionScope.loggedInUser.role == 'ADMIN'}">
            <hr style="border:none;border-top:1px solid rgba(65,72,70,0.2);margin:0.5rem 0;"/>
            <a href="${pageContext.request.contextPath}/admin" class="nav-link ${activePage == 'admin' ? 'active' : ''}">
                <span class="material-symbols-outlined">admin_panel_settings</span> Admin
            </a>
            <a href="${pageContext.request.contextPath}/admin/users" class="nav-link ${activePage == 'admin-users' ? 'active' : ''}">
                <span class="material-symbols-outlined">group</span> Users
            </a>
            <a href="${pageContext.request.contextPath}/admin/reports" class="nav-link ${activePage == 'admin-reports' ? 'active' : ''}">
                <span class="material-symbols-outlined">assessment</span> Reports
            </a>
        </c:if>
    </nav>

    <!-- Footer -->
    <div style="padding:0 1rem 1rem;">
        <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline" style="width:100%;font-size:0.8rem;">
            <span class="material-symbols-outlined" style="font-size:1.1rem;">logout</span> Sign Out
        </a>
    </div>
</aside>

