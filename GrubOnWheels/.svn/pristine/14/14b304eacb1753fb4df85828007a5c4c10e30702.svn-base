<%@page import="database.DatabaseConnection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Blob"%>
<%@page import="java.sql.Connection"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page trimDirectiveWhitespaces="true"%>

<%
    Blob restaurantImage = null;
    byte[] imageData = null;
    Statement stmt = null;
    ResultSet rs = null;
    String id = request.getParameter("imgid");
    Connection con= DatabaseConnection.getconnection();
    try {
    	System.out.println("Entering this page...");
        stmt = con.createStatement();
        rs = stmt.executeQuery("select respic from restaurants where id = '" + id + "'");
        if (rs.next()) {
        	restaurantImage = rs.getBlob(1);
        	imageData = restaurantImage.getBytes(1, (int) restaurantImage.length());
        } else {
            out.println("Display Blob Example");
            out.println("image not found for given image");
            return;
        }
        response.setContentType("image/png");
        OutputStream o = response.getOutputStream();
        o.write(imageData);
        o.flush();
        o.close();
    } catch (Exception e) {
        out.println("Unable To Display image");
        out.println("Image Display Error=" + e.getMessage());
        return;
    } finally {
        try {
        	if(rs != null){
            rs.close();
        	}
            stmt.close();
            con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>

