package actions;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import database.DatabaseConnection;

@WebServlet("/RestaurantActivateReject")
public class RestaurantActivateReject extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	protected synchronized void activateOrRejectRestaurant(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException{

		res.setContentType("text/html;charset=UTF-8");
		try {
			String restid = req.getParameter("id");
			String action = req.getParameter("restAction");
			Connection conn = DatabaseConnection.getconnection();
			Statement stmt = conn.createStatement();
			try {
				if(action.equalsIgnoreCase("Activate")) {
					int activateRestaurant = stmt.executeUpdate("Update restaurants set statuss = 'Active' where id = '"+restid+"'");
					if(activateRestaurant > 0) {
						res.sendRedirect("restaurantsActivation.jsp?Granted");
					} else {
						res.sendRedirect("restaurantsActivation.jsp?Failed");
					}
				} else if(action.equalsIgnoreCase("Reject")) {
					int rejectRestaurant = stmt.executeUpdate("Update restaurants set statuss = 'Rejected' where id = '"+restid+"'");
					if(rejectRestaurant > 0) {
						res.sendRedirect("restaurantsActivation.jsp?Rejected");
					} else {
						res.sendRedirect("restaurantsActivation.jsp?Failed");
					}
				}
			} catch (SQLException e) {
				// TODO: handle exception
				e.printStackTrace();
			} finally {
				stmt.close();
				conn.close();
			}		
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		activateOrRejectRestaurant(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		activateOrRejectRestaurant(req, resp);
	}
	
	
}
