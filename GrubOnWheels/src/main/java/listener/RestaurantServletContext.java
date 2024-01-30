package listener;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

import database.DatabaseConnection;
import model.Restaurant;

@WebListener
public class RestaurantServletContext implements ServletContextListener{

	@Override
	public void contextDestroyed(ServletContextEvent arg0) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void contextInitialized(ServletContextEvent e) {
		// TODO Auto-generated method stub
		ServletContext servletContext = e.getServletContext();
		Map<String, Restaurant> restaurants = new HashMap<>();
		Connection conn = DatabaseConnection.getconnection();
		Statement stmt;
		try {
			stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery("Select * from restaurants");
			while(rs.next()) {
				String restid = rs.getString("id");
				String restname = rs.getString("restname");
				restaurants.put(restid, new Restaurant(restid, restname));
			}
			
			servletContext.setAttribute("restaurantsMap", restaurants);
		} catch (Exception ex) {
			// TODO: handle exception
			ex.printStackTrace();
		}
	}
	
	

}
