<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Error Page</title>
</head>
<body>
    <h1>Internal Server Error</h1>
    <p>Sorry, an internal server error occurred. Please try again later.</p>
    <p><a href="index.jsp">Go back to homepage</a></p>
    
    <% 
        Exception exception = (Exception)request.getAttribute("javax.servlet.error.exception");
        if(exception != null) {
    %>
        <h2>Error Details:</h2>
        <p><%= exception.getMessage() %></p>
        <p>
            <%
                java.io.StringWriter sw = new java.io.StringWriter();
                java.io.PrintWriter pw = new java.io.PrintWriter(sw);
                exception.printStackTrace(pw);
                out.print(sw.toString());
            %>
        </p>
    <%
        }
    %>

</body>
</html>
