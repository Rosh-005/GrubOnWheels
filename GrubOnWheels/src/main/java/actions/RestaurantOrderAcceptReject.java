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
import javax.servlet.http.HttpSession;

import database.DatabaseConnection;

@WebServlet("/RestaurantOrderAcceptReject")
public class RestaurantOrderAcceptReject extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected synchronized void acceptOrRejectOrder(HttpServletRequest req, HttpServletResponse res) throws ServletException,IOException{
		res.setContentType("text/html;charset=UTF-8");
		try {
			HttpSession session = req.getSession();
			String resid = session.getAttribute("restid").toString();
			String action = req.getParameter("restaction");
			String id = req.getParameter("id");
			String orderId = req.getParameter("oid");
			
			Connection conn = DatabaseConnection.getconnection();
			Statement stmt = conn.createStatement();
			
			try {			
			
			if(action.equals("Confirm")) {
				int acceptOrder = stmt.executeUpdate("Update useroders set orderstatus='Confirmed', dastatus='Waiting' where oid='"+orderId+"' and resid = '"+resid+"'");
				if(acceptOrder>0) {
					System.out.println("Order Accepted!!!");
					res.sendRedirect("restaurantOrders.jsp?Confirmed");
				} else {
					res.sendRedirect("restaurantOrders.jsp?Failed");
				}
			} else if (action.equals("Reject")) {
				int rejectOrder = stmt.executeUpdate("Update useroders set orderstatus='Rejected' where oid='"+orderId+"' and resid = '"+resid+"'");
				if(rejectOrder>0) {
					System.out.println("Order Rejected!!!");
					res.sendRedirect("restaurantOrders.jsp?Rejected");
				} else {
					res.sendRedirect("restaurantOrders.jsp?Failed");
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
		acceptOrRejectOrder(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		acceptOrRejectOrder(req, resp);
	}
	
}
