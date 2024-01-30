<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="database.DatabaseConnection"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>

<%
        int delCount;
        ResultSet rs = null;
        String uid = request.getParameter("uid");
        String dishId = request.getParameter("did");
        PreparedStatement ptst = null;
        Connection conn = DatabaseConnection.getconnection();
        try{
        	if(dishId == null || dishId.isEmpty()){
        		ptst = conn.prepareStatement("Delete from usercart where userid = '"+uid+"'");
        		delCount = ptst.executeUpdate();
        		if(delCount>0){
        		response.sendRedirect("userCart.jsp?CartCleared");
        		} else{
        			response.sendRedirect("userCart.jsp?Failed");
        		}
        	} else{
        		ptst = conn.prepareStatement("Delete from usercart where userid = '"+uid+"' and dishid = '"+dishId+"'");
        		delCount = ptst.executeUpdate();
        		if(delCount > 0){
        		response.sendRedirect("userCart.jsp?DishRemoved");
        		} else{
        			response.sendRedirect("userCart.jsp?Failed");
        		}
        	}
        } catch(Exception e){
        	out.println("Unable to Clear Cart..."+e.getMessage());
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


