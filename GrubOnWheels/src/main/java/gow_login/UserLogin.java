package gow_login;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import database.DatabaseConnection;
import model.User;
import org.mindrot.jbcrypt.BCrypt;

@WebServlet("/UserLogin")
public class UserLogin extends HttpServlet{

	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected synchronized void loginUser(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException{
		res.setContentType("text/html;charset=UTF-8");
		try {
			String phone ="+44" + req.getParameter("phone");
			String password = req.getParameter("pass");
			Connection conn = DatabaseConnection.getconnection();
			Statement stmt = conn.createStatement();
			try {
				ResultSet rs = stmt.executeQuery("SELECT * FROM users where phone = '"+ phone +"'");
				if(rs.next()) {
					User user = new User();
					user.setUserID(rs.getString("id"));
					user.setUserName(rs.getString("name"));
					String hashedPassword = rs.getString("pass"); 
					HttpSession session = req.getSession(true);
					session.setAttribute("user", user);
					session.setAttribute("userid", rs.getString("id"));
					session.setAttribute("username", rs.getString("name"));
					session.setAttribute("userphone", rs.getString("phone"));
					session.setAttribute("useraddress", rs.getString("address"));
					if(BCrypt.checkpw(password, hashedPassword)) {
						res.sendRedirect("userHome.jsp");
					} else {
						res.sendRedirect("userLogin.jsp?no");
					}					
				}
				else {
					res.sendRedirect("userLogin.jsp?no");
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
		loginUser(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		loginUser(req, resp);
	}
	
}
