package actions;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import database.DatabaseConnection;

@WebServlet("/UpdateMenu")
public class UpdateMenu extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected synchronized void updateMenuForRestaurant(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		 	
		
			String id = req.getParameter("id");
		    String price = req.getParameter("price");
		    Connection conn = DatabaseConnection.getconnection();
		    

		    try {
		    	Statement stmt = conn.createStatement();
		        int updateMenu = stmt.executeUpdate("update restaurant_menu set price='"+price+"' where id='" + id + "'");
	
		        if (updateMenu != 0) {
		            res.sendRedirect("updateMenu.jsp?Updated");
		        } else {

		            System.out.println("failed");
		            res.sendRedirect("updateMenu.jsp?failed");
		        }
		    } catch (Exception ex) {
		        ex.printStackTrace();
		    }

	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		updateMenuForRestaurant(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		updateMenuForRestaurant(req, resp);
	}
	
}
