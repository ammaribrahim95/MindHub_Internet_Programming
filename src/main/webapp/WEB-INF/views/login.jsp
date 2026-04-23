<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>MindHub — Secure Login</title>
    <jsp:include page="common/header.jsp"/>
    <style>
        .glass-panel { background:rgba(45,52,76,0.4); backdrop-filter:blur(20px); -webkit-backdrop-filter:blur(20px); }
    </style>
</head>
<body style="display:flex;flex-direction:column;min-height:100vh;">

<!-- Top Bar -->
<header style="position:fixed;top:0;left:0;width:100%;z-index:50;display:flex;justify-content:space-between;align-items:center;padding:1rem 1.5rem;background:rgba(11,18,41,0.6);backdrop-filter:blur(16px);">
    <div style="font-size:1.25rem;font-weight:700;color:var(--on-surface);font-family:var(--font-headline);">MindHub</div>
    <nav style="display:flex;align-items:center;gap:2rem;">
        <a href="#" style="color:var(--on-surface-variant);">Support</a>
        <a href="#" style="color:var(--on-surface-variant);">Privacy</a>
    </nav>
</header>

<main style="flex-grow:1;display:flex;align-items:center;justify-content:center;position:relative;padding:6rem 1rem;overflow:hidden;">
    <!-- Background orbs -->
    <div style="position:absolute;top:25%;left:-5rem;width:24rem;height:24rem;background:rgba(180,221,213,0.1);border-radius:50%;filter:blur(120px);"></div>
    <div style="position:absolute;bottom:25%;right:-5rem;width:20rem;height:20rem;background:rgba(147,207,235,0.1);border-radius:50%;filter:blur(100px);"></div>

    <div style="width:100%;max-width:480px;z-index:10;">
        <div class="glass-panel" style="border:1px solid rgba(65,72,70,0.15);border-radius:0.75rem;padding:2rem 3rem;box-shadow:0 25px 50px rgba(0,0,0,0.25);">

            <!-- Branding -->
            <div style="margin-bottom:2.5rem;text-align:center;">
                <div style="display:inline-flex;align-items:center;justify-content:center;width:4rem;height:4rem;border-radius:50%;background:var(--bg-container-high);margin-bottom:1.5rem;">
                    <span class="material-symbols-outlined" style="font-size:2rem;color:var(--primary);">shield_with_heart</span>
                </div>
                <h1 style="font-family:var(--font-headline);font-size:1.875rem;font-weight:800;margin-bottom:0.75rem;">Secure Access to MindHub</h1>
                <p style="color:var(--on-surface-variant);font-weight:500;">Log in to your private wellness space.</p>
            </div>

            <!-- Alerts -->
            <c:if test="${not empty error}">
                <div class="alert alert-error">${error}</div>
            </c:if>
            <c:if test="${not empty success}">
                <div class="alert alert-success">${success}</div>
            </c:if>

            <!-- Login Form -->
            <form action="${pageContext.request.contextPath}/login" method="post" style="display:flex;flex-direction:column;gap:1.5rem;">
                <div>
                    <label class="form-label" for="email">University Email</label>
                    <input class="form-input" id="email" name="email" type="email" placeholder="name@student.utm.my" required/>
                </div>
                <div>
                    <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:0.5rem;">
                        <label class="form-label" for="password" style="margin-bottom:0;">Password</label>
                        <a href="#" style="font-size:0.75rem;font-weight:600;color:var(--secondary);">Forgot?</a>
                    </div>
                    <input class="form-input" id="password" name="password" type="password" placeholder="••••••••" required/>
                </div>
                <button class="btn btn-primary" type="submit" style="width:100%;padding:1rem;font-size:1rem;">Sign In</button>
            </form>

            <!-- Register Link -->
            <div style="margin-top:2rem;text-align:center;">
                <p style="color:var(--on-surface-variant);font-size:0.875rem;">
                    Don't have an account?
                    <a href="${pageContext.request.contextPath}/register" style="color:var(--secondary);font-weight:600;">Create one</a>
                </p>
            </div>

            <!-- Trust Badge -->
            <div style="margin-top:2rem;display:flex;flex-direction:column;align-items:center;text-align:center;">
                <div class="badge badge-primary" style="margin-bottom:0.75rem;">
                    <span class="material-symbols-outlined" style="font-size:0.875rem;">verified_user</span>
                    Secure & Private
                </div>
                <p style="font-size:0.75rem;color:var(--on-surface-variant);opacity:0.7;max-width:280px;">
                    Your data is encrypted and never shared with faculty or administrators.
                </p>
            </div>
        </div>
    </div>
</main>

<jsp:include page="common/footer.jsp"/>
</body>
</html>

