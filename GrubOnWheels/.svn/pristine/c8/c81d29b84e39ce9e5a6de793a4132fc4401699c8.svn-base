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
    Blob menuImg = null;
    Connection con = null;
    byte[] imageData = null;
    Statement stmt = null;
    ResultSet rs = null;
    String id = request.getParameter("mid");
    try {
        con= DatabaseConnection.getconnection();
        stmt = con.createStatement();
        rs = stmt.executeQuery("select dishphoto from restaurant_menu where id = '" + id + "'");
        if (rs.next()) {
        	menuImg = rs.getBlob(1);
        	imageData = menuImg.getBytes(1, (int) menuImg.length());
        } else {
            out.println("Display Blob Example");
            out.println("image not found for given image");
            return;
        }
        response.setContentType("image/gif");
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
            rs.close();
            stmt.close();
            con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>

