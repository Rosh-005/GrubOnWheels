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
import model.Restaurant;

@WebServlet("/RestaurantLogin")
public class RestaurantLogin extends HttpServlet{

	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected synchronized void loginRestaurant(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException{
		res.setContentType("text/html;charset=UTF-8");
		try {
			HttpSession session = req.getSession();
			String username = req.getParameter("username");
			String password = req.getParameter("password");
			Connection conn = DatabaseConnection.getconnection();
			Statement stmt = conn.createStatement();
			Statement stmt1 = conn.createStatement();
			try {
				ResultSet rs = stmt.executeQuery("SELECT * FROM restaurants where username = '"+ username +"'");
				if(rs.next()) {
					ResultSet rs1 = stmt1.executeQuery("SELECT * FROM restaurants where username = '"+ username +"' and statuss = 'Active'");
					if(rs1.next()) {
						Restaurant restaurant = new Restaurant();
						restaurant.setRestaurantID(rs.getString("id"));
						restaurant.setRestaurantName(rs.getString("restname"));
						String hashedPassword = rs1.getString("pass"); 
						session.setAttribute("restaurant", restaurant);
						session.setAttribute("restname", rs.getString("restname"));
						session.setAttribute("restid", rs.getString("id"));
						if(BCrypt.checkpw(password, hashedPassword)) {
							res.sendRedirect("restaurantHome.jsp");
						} else {
							res.sendRedirect("restaurantLogin.jsp?no");
						}
					} else {
						res.sendRedirect("restaurantLogin.jsp?Inactive");
					}
				}
				else {
					res.sendRedirect("restaurantLogin.jsp?no");
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
		loginRestaurant(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		loginRestaurant(req, resp);
	}
	
}
