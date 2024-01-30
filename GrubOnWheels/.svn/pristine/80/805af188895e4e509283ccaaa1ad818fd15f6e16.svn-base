package actions;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import database.DatabaseConnection;

@WebServlet("/GetDeliveryLocation")
public class GetDeliveryLocation extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected synchronized void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		try {
			String orderID = req.getParameter("orderID");
			Double latitude = 0.0;
			Double longitude = 0.0;
			Connection conn = DatabaseConnection.getconnection();
			Statement stmt = conn.createStatement();
			
			ResultSet rs = stmt.executeQuery("Select * from agent_location where orderid = '"+orderID+"'");
			if(rs.next()) {
				latitude = rs.getDouble("latitude");
				longitude = rs.getDouble("longitude");
			}
			System.out.println("Location Fetched!");
			// Create a JSON object with agent's location
	        JSONObject agentLocation = new JSONObject();
	        agentLocation.put("latitude", latitude);
	        agentLocation.put("longitude", longitude);

	        // Set response content type to JSON
	        resp.setContentType("application/json");
	        resp.setCharacterEncoding("UTF-8");

	        // Write the JSON response to the client
	        PrintWriter out = resp.getWriter();
	        out.print(agentLocation.toString());
	        out.flush();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		
	}
	
	

}
