package actions;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import database.DatabaseConnection;

@WebServlet("/UpdateDeliveryLocation")
public class UpdateDeliveryLocation extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	protected synchronized void processRequest(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, SQLException{
		res.setContentType("text/html;charset=UTF-8");
		try {
			HttpSession session = req.getSession();
			String delID = session.getAttribute("delid").toString();
			double latitude = Double.parseDouble(req.getParameter("lat"));
			double longitude = Double.parseDouble(req.getParameter("lng"));
			DateFormat df = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
			Date date = new Date();
			String time = df.format(date);
			Connection conn = DatabaseConnection.getconnection();
			
			try {
				Statement stmt1 = conn.createStatement();
				Statement stmt2 = conn.createStatement();
				List<String> orderIDs = new ArrayList<String>();
				ResultSet rs = stmt1.executeQuery("Select distinct oid from useroders where daid = '"+delID+"' and dastatus = 'Picked Up'");
				while(rs.next()) {
					String oid = rs.getString("oid");
					orderIDs.add(oid);
				}
				if(orderIDs != null && !orderIDs.isEmpty()) {
					StringBuilder orderIDBuilder = new StringBuilder();
		            for (String orderID : orderIDs) {
		                if (orderIDBuilder.length() > 0) {
		                    orderIDBuilder.append(",");
		                }
		                orderIDBuilder.append("'").append(orderID).append("'");
		            }
		            String orderIDString = orderIDBuilder.toString();
				PreparedStatement ptst = null;
				String query = "Select * from agent_location where orderid in ("+orderIDString+")";
				System.out.println(query);
				ResultSet rs1 = stmt2.executeQuery(query);
				if(rs1.next()) {
					ptst = conn.prepareStatement("Update agent_location set latitude = '"+latitude+"', longitude = '"+longitude+"', `time` = '"+time+"' where orderid in ("+orderIDString+")");
					int locationUpdate = ptst.executeUpdate();
					if(locationUpdate > 0) {
						System.out.println("Delivery Agent Location updated");
					} else {
						System.out.println("Error in Location update");
					}
				}
				} else {
					System.out.println("Nothing to update");
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
		try {
			processRequest(req, resp);
		} catch (ServletException | IOException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		try {
			processRequest(req, resp);
		} catch (ServletException | IOException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	

}
