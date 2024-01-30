<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
	<body>
		<% session.invalidate(); %>
                <jsp:forward page="deliveryLogin.jsp"/>
	</body>
</html>