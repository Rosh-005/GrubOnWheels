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

@WebServlet("/DeliveryConfirmDeliver")
public class DeliveryConfirmDeliver extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected synchronized void confirmOrDeliverOrder(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException{
		res.setContentType("text/html;charset=UTF-8");
		try {
			HttpSession session = req.getSession();
			String delId = session.getAttribute("delid").toString();
			String orderId = req.getParameter("oid");
			String id = req.getParameter("id");
			String delStatus = req.getParameter("delstatus");
			DateFormat df = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
			Date date = new Date();
			String time = df.format(date);
			String latitude = req.getParameter("latitude");
			String longitude = req.getParameter("longitude");
			double lat = 0.0;
			double lng = 0.0;
			if(latitude != null && longitude != null && !latitude.isEmpty() && !longitude.isEmpty()) {
			lat = Double.parseDouble(latitude);
			lng = Double.parseDouble(longitude);
			}
			Connection conn = DatabaseConnection.getconnection();
			try {
				Statement stmt = conn.createStatement();
				if(delStatus.equalsIgnoreCase("Confirm")) {
					int confirmDelivery = stmt.executeUpdate("Update useroders set dastatus = 'Accepted', daid = '"+delId+"', orderstatus = 'Preparing' "
							+ " where oid = '"+orderId+"' and dastatus = 'Waiting'");
					PreparedStatement ptst1 = conn.prepareStatement("Insert into agent_location (delid, orderid, latitude, longitude, `time`) "
							+ "values (?,?,?,?,?)");
					ptst1.setString(1, delId);
					ptst1.setString(2, orderId);
					ptst1.setDouble(3, lat);
					ptst1.setDouble(4, lng);
					ptst1.setString(5, time);
					int locationInsert = 0;
					if(confirmDelivery > 0) {
						System.out.println("Delivery Accepted!");
						locationInsert = ptst1.executeUpdate();
						res.sendRedirect("deliveryOrders.jsp?Accepted");
					} else {
						res.sendRedirect("deliveryOrders.jsp?Failed");
					} if(locationInsert > 0) {
						System.out.println("Delivery Location Inserted");
					} else {
						System.out.println("Error in Delivery Location Insert");
					}
				} else if(delStatus.equalsIgnoreCase("Picked Up?")) {
					int pickedUp = stmt.executeUpdate("Update useroders set dastatus = 'Picked Up', daid = '"+delId+"', orderstatus = 'Delivery Picked Up'"
							+ " where oid = '"+orderId+"' and dastatus = 'Accepted'");
					if(pickedUp > 0) {
						System.out.println("Order " +orderId+ " Picked up from restaurant");
						res.sendRedirect("deliveryOrders.jsp?PickedUp");
					} else {
						res.sendRedirect("deliveryOrders.jsp?Failed");
					}
				}
				else if(delStatus.equalsIgnoreCase("Delivered?")) {
					int delivered = stmt.executeUpdate("Update useroders set dastatus = 'Delivered', daid = '"+delId+"', orderstatus = 'Delivered',"
							+ "dtime = '"+time+"' where oid = '"+orderId+"' and dastatus = 'Picked Up'");
					if(delivered > 0) {
						System.out.println("Delivered!!");
						res.sendRedirect("deliveryOrders.jsp?Delivered");
					} else {
						res.sendRedirect("deliveryOrders.jsp?Failed");
					}
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
		confirmOrDeliverOrder(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		confirmOrDeliverOrder(req, resp);
	}
	
	
}
