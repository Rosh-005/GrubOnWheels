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

import org.mindrot.jbcrypt.BCrypt;

import database.DatabaseConnection;

@WebServlet("/DeliveryLogin") 
public class DeliveryLogin extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected synchronized void loginDeliveryAgent(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException{
		res.setContentType("text/html;charset=UTF-8");
		try {
			HttpSession session = req.getSession();
			String phone = req.getParameter("phone");
			String password = req.getParameter("password");
			Connection conn = DatabaseConnection.getconnection();
			Statement stmt = conn.createStatement();
			Statement stmt1 = conn.createStatement();
			try {
				ResultSet rs = stmt.executeQuery("SELECT * FROM delivery_agent where phone = '"+ phone +"'");
				
					if(rs.next()) {
						ResultSet rs1 = stmt1.executeQuery("SELECT * FROM delivery_agent where phone = '"+ phone +"' and status = 'Active'");
						if(rs1.next()) {
							String hashedPassword = rs1.getString("pass"); 
							session.setAttribute("fname", rs.getString("fname"));
							session.setAttribute("delcity", rs.getString("city"));
							session.setAttribute("delid", rs.getString("id"));
							if(BCrypt.checkpw(password, hashedPassword)) {
								res.sendRedirect("deliveryHome.jsp?");
							} else {
								res.sendRedirect("deliveryLogin.jsp?no");
							}
						} else {
							res.sendRedirect("deliveryLogin.jsp?Inactive");
						}
					} else {
						res.sendRedirect("deliveryLogin.jsp?no");
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
		loginDeliveryAgent(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		loginDeliveryAgent(req, resp);
	}

}
