package actions;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashSet;
import java.util.Set;
import java.util.UUID;

import database.DatabaseConnection;

public class GenerateOrderID {
	
	
	public String generateOrderNumber() {
		final String PREFIX = "GOW";
        String orderID;
        do {
        	orderID = PREFIX + generateRandomPortion(6);
        } while (!isUniqueOrderNumber(orderID));

        return orderID;
    }
	
	 private static String generateRandomPortion(int length) {
	        StringBuilder randomPortion = new StringBuilder();
	        for (int i = 0; i < length; i++) {
	            randomPortion.append(UUID.randomUUID().toString().replaceAll("-", "").charAt(i));
	        }
	        return randomPortion.toString();
	    }
	 public static void main(String[] args) {
			
		 //System.out.println(generatedOrderIDs);
	    }
	    private static boolean isUniqueOrderNumber(String orderNumber) {
	    	Set<String> generatedOrderIDs = new HashSet<>();
	    	try {
	    		Connection conn = DatabaseConnection.getconnection();
	    		Statement stmt = conn.createStatement();
	    		ResultSet rs = stmt.executeQuery("Select distinct oid from useroders");
	    		while(rs.next()) {
	    			generatedOrderIDs.add(rs.getString("oid"));
	    		}
	    	} catch (SQLException e) {
				// TODO: handle exception
	    		e.printStackTrace();
			}
	        return !generatedOrderIDs.contains(orderNumber);
	    }
}
