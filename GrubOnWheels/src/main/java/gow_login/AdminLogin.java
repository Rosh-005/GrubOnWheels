package gow_login;

import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.mindrot.jbcrypt.BCrypt;

import database.DatabaseConnection;

@WebServlet("/AdminLogin")
public class AdminLogin extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected synchronized void loginAdmin(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException{
		res.setContentType("text/html;charset=UTF-8");
		try {
			String username = req.getParameter("name");
			String password = req.getParameter("pass");
			Connection conn = DatabaseConnection.getconnection();
			Statement stmt = conn.createStatement();
			try {
				ResultSet rs = stmt.executeQuery("Select * from admin where username = '"+username+"'");
				if(rs.next()) {
					String storedHashedPassword = rs.getString("pass");
                    if(BCrypt.checkpw(password, storedHashedPassword)) {
                    	res.sendRedirect("adminHome.jsp");
                    } else {
                    	res.sendRedirect("adminLogin.jsp?Failed");
					}
				} else {
					res.sendRedirect("adminLogin.jsp?Failed");
				}
			} catch (SQLException e) {
				// TODO: handle exception
				e.printStackTrace();
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		loginAdmin(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		loginAdmin(req, resp);
	}
}
