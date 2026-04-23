<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/><meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>MindHub — Register</title>
    <jsp:include page="common/header.jsp"/>
    <style>.glass-panel{background:rgba(45,52,76,0.4);backdrop-filter:blur(20px);-webkit-backdrop-filter:blur(20px);}</style>
</head>
<body style="display:flex;flex-direction:column;min-height:100vh;">
<header style="position:fixed;top:0;left:0;width:100%;z-index:50;display:flex;justify-content:space-between;align-items:center;padding:1rem 1.5rem;background:rgba(11,18,41,0.6);backdrop-filter:blur(16px);">
    <div style="font-size:1.25rem;font-weight:700;color:var(--on-surface);font-family:var(--font-headline);">MindHub</div>
</header>
<main style="flex-grow:1;display:flex;align-items:center;justify-content:center;padding:6rem 1rem;position:relative;overflow:hidden;">
    <div style="position:absolute;top:25%;left:-5rem;width:24rem;height:24rem;background:rgba(180,221,213,0.1);border-radius:50%;filter:blur(120px);"></div>
    <div style="width:100%;max-width:480px;z-index:10;">
        <div class="glass-panel" style="border:1px solid rgba(65,72,70,0.15);border-radius:0.75rem;padding:2rem 3rem;box-shadow:0 25px 50px rgba(0,0,0,0.25);">
            <div style="margin-bottom:2rem;text-align:center;">
                <div style="display:inline-flex;align-items:center;justify-content:center;width:4rem;height:4rem;border-radius:50%;background:var(--bg-container-high);margin-bottom:1.5rem;">
                    <span class="material-symbols-outlined" style="font-size:2rem;color:var(--secondary);">person_add</span>
                </div>
                <h1 style="font-family:var(--font-headline);font-size:1.875rem;font-weight:800;margin-bottom:0.5rem;">Join MindHub</h1>
                <p style="color:var(--on-surface-variant);">Begin your wellness journey today.</p>
            </div>
            <c:if test="${not empty error}"><div class="alert alert-error">${error}</div></c:if>
            <form action="${pageContext.request.contextPath}/register" method="post" style="display:flex;flex-direction:column;gap:1.25rem;">
                <div>
                    <label class="form-label" for="fullName">Full Name</label>
                    <input class="form-input" id="fullName" name="fullName" type="text" placeholder="Ammar Ibrahim" required/>
                </div>
                <div>
                    <label class="form-label" for="email">University Email</label>
                    <input class="form-input" id="email" name="email" type="email" placeholder="name@student.utm.my" required/>
                </div>
                <div>
                    <label class="form-label" for="password">Password</label>
                    <input class="form-input" id="password" name="password" type="password" placeholder="••••••••" required/>
                </div>
                <div>
                    <label class="form-label" for="confirmPassword">Confirm Password</label>
                    <input class="form-input" id="confirmPassword" name="confirmPassword" type="password" placeholder="••••••••" required/>
                </div>
                <button class="btn btn-primary" type="submit" style="width:100%;padding:1rem;font-size:1rem;">Create Account</button>
            </form>
            <div style="margin-top:1.5rem;text-align:center;">
                <p style="color:var(--on-surface-variant);font-size:0.875rem;">
                    Already have an account? <a href="${pageContext.request.contextPath}/login" style="color:var(--secondary);font-weight:600;">Sign In</a>
                </p>
            </div>
        </div>
    </div>
</main>
<jsp:include page="common/footer.jsp"/>
</body>
</html>

