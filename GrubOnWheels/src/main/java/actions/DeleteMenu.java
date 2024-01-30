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

@WebServlet("/DeleteMenu")
public class DeleteMenu extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected synchronized void deleteRestaurantMenu(HttpServletRequest req, HttpServletResponse res) {
		res.setContentType("text/html;charset=UTF-8");
		try {
			String id = req.getParameter("id");
			Connection conn = DatabaseConnection.getconnection();
			Statement stmt = conn.createStatement();
			try {
				int insertCount = stmt.executeUpdate("Delete from restaurant_menu where id = '"+id+"'");
				if(insertCount>0) {
					res.sendRedirect("updateMenu.jsp?Deleted");
				}
				else {
					res.sendRedirect("updateMenu.jsp?failed");
				}
			} catch (SQLException e) {
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
		deleteRestaurantMenu(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		deleteRestaurantMenu(req, resp);
	}
	
}
