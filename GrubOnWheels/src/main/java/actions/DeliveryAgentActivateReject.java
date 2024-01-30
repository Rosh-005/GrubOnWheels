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

@WebServlet("/DeliveryAgentActivateReject")
public class DeliveryAgentActivateReject extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	

	protected synchronized void activateOrRejectAgent(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException{
		res.setContentType("text/html;charset=UTF-8");
		try {
			String delid = req.getParameter("id");
			String action = req.getParameter("delAction");
			Connection conn = DatabaseConnection.getconnection();
			Statement stmt = conn.createStatement();
			try {
				if(action.equalsIgnoreCase("Activate")) {
					int activateAgent = stmt.executeUpdate("Update delivery_agent set status = 'Active' where id = '"+delid+"'");
					if(activateAgent > 0) {
						res.sendRedirect("deliveryAgentActivation.jsp?Granted");
					} else {
						res.sendRedirect("deliveryAgentActivation.jsp?Failed");
					}
				} else if(action.equalsIgnoreCase("Reject")) {
					int rejectAgent = stmt.executeUpdate("Update delivery_agent set status = 'Rejected' where id = '"+delid+"'");
					if(rejectAgent > 0) {
						res.sendRedirect("deliveryAgentActivation.jsp?Rejected");
					} else {
						res.sendRedirect("deliveryAgentActivation.jsp?Failed");
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
		activateOrRejectAgent(req, resp);
	}


	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		activateOrRejectAgent(req, resp);
	}
	
	
}
