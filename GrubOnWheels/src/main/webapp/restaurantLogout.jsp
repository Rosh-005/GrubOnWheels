<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
	<body>
		<% session.invalidate(); %>
                <jsp:forward page="restaurantLogin.jsp"/>
	</body>
</html>