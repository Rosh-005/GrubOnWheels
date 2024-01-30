<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
	<body>
		<% session = request.getSession(false);
		if(session != null){
			session.invalidate(); 
		}%> 
		<jsp:forward page="userLogin.jsp"/>
	</body>
</html>
