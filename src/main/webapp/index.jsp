<%@ page session="false" %>
<%
    // Redirect root to login page
    response.sendRedirect(request.getContextPath() + "/login");
%>
