<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head><meta charset="UTF-8"/><meta name="viewport" content="width=device-width, initial-scale=1.0"/><title>MindHub Admin — Users</title><jsp:include page="common/header.jsp"/></head>
<body>
<c:set var="activePage" value="admin-users" scope="request"/><jsp:include page="common/sidebar.jsp"/>
<div class="main-content">
    <div class="topbar"><h1 style="font-family:var(--font-headline);font-size:1.5rem;font-weight:800;color:var(--error);">User Management</h1></div>
    <div class="page-content">
        <c:if test="${not empty success}"><div class="alert alert-success">${success}</div></c:if>
        
        <div class="card">
            <div class="table-container">
                <table>
                    <thead><tr><th>ID</th><th>Name</th><th>Email</th><th>Role</th><th>Joined</th><th>Actions</th></tr></thead>
                    <tbody>
                        <c:forEach var="u" items="${users}">
                            <tr>
                                <td>${u.id}</td>
                                <td><strong>${u.fullName}</strong></td>
                                <td>${u.email}</td>
                                <td><span class="badge ${u.role == 'ADMIN' ? 'badge-danger' : 'badge-primary'}">${u.role}</span></td>
                                <td>${u.createdAt}</td>
                                <td>
                                    <c:if test="${u.id != sessionScope.loggedInUser.id}">
                                        <form action="${pageContext.request.contextPath}/admin/users/delete/${u.id}" method="post" onsubmit="return confirmDelete(this, 'user account');">
                                            <button type="submit" class="btn btn-danger" style="padding:0.3rem 0.6rem;font-size:0.7rem;">Delete</button>
                                        </form>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<jsp:include page="common/footer.jsp"/>
</body>
</html>

