<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="database.DatabaseConnection"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>

<%
String orderId = request.getParameter("oid");
Connection conn = DatabaseConnection.getconnection();
ResultSet rs = null;
PreparedStatement ptst = null;
int updateCount = 0;
try{
	if(orderId != null && !orderId.isEmpty()){
		ptst = conn.prepareStatement("Update useroders set orderstatus = 'Cancelled', dastatus = 'Cancelled' "
				+ "where oid = '"+orderId+"'");
		updateCount = ptst.executeUpdate();
		if(updateCount > 0){
			response.sendRedirect("orderHistory.jsp?Cancelled");
		} else{
			response.sendRedirect("orderHistory.jsp?CancelFailed");
		}
	} else{
		response.sendRedirect("orderHistory.jsp?CancelFailed");
	}
} catch(Exception e){
	e.printStackTrace();
	return;
} finally {
    try {
    	if(rs != null){
        rs.close();
    	}
        ptst.close();
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
}

%>