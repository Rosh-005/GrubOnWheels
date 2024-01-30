package controller;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import database.DatabaseConnection;
import model.Dish;
import model.User;

public class DBControl {

	Connection conn;
	Statement stmt;
	ResultSet rs;
	
	public ArrayList<Dish> addAllDishes(String id) throws SQLException{
		ArrayList<Dish> dishList = new ArrayList<Dish>();
		conn = DatabaseConnection.getconnection();
		stmt = conn.createStatement();
		try {
			rs = stmt.executeQuery("Select * from restaurant_menu where restid = '"+id+"'");
			while(rs.next()) {
				String dishID = rs.getString("id");
				String dishName = rs.getString("dishname");
				double dishPrice = Double.parseDouble(rs.getString("price"));  
				dishList.add(new Dish(dishID, dishName, dishPrice));
			}
		} catch (SQLException e) {
			// TODO: handle exception
			e.printStackTrace();
		} finally {
			try {
			if(rs!=null) {
			rs.close();
			}
			stmt.close();
			conn.close();
			}catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}
		}
		return dishList;
	}
	
	public ArrayList<Dish> chooseDish(String id) throws SQLException{
		ArrayList<Dish> cartArray = new ArrayList<Dish>();
		Connection conn = DatabaseConnection.getconnection();
		Statement stmt = conn.createStatement();
		try {
			ResultSet rs = stmt.executeQuery("Select * from restaurant_menu where id = '"+id+"'");
			while(rs.next()) {
				String dishID = rs.getString("id");
				String dishName = rs.getString("dishname");
				double dishPrice = Double.parseDouble(rs.getString("price"));
				cartArray.add(new Dish(dishID, dishName, dishPrice));
			}
		} catch (SQLException e) {
			// TODO: handle exception
			e.printStackTrace();
		} finally {
			try {
				if(rs!=null) {
				rs.close();
				}
				stmt.close();
				conn.close();
				}catch (Exception e) {
					// TODO: handle exception
					e.printStackTrace();
				}
		}
		return cartArray;
	}
	
	public ArrayList<User> selectAllUsers() throws SQLException{
		ArrayList<User> userArray = new ArrayList<User>();
		Connection conn = DatabaseConnection.getconnection();
		Statement stmt = conn.createStatement();
		try {
			ResultSet rs = stmt.executeQuery("Select * from users");
			while(rs.next()) {
				String userID = rs.getString("id");
				String userName = rs.getString("name");
				userArray.add(new User(userID, userName));
			}
		} catch (SQLException e) {
			// TODO: handle exception
			e.printStackTrace();
		} finally {
			try {
				if(rs!=null) {
				rs.close();
				}
				stmt.close();
				conn.close();
				}catch (Exception e) {
					// TODO: handle exception
					e.printStackTrace();
				}
		}
		return userArray;
	}
	
	public void insertIntoOrders(String date, String paymentMethod, String customerID) throws SQLException {
        Connection conn = DatabaseConnection.getconnection();
        Statement stmt = conn.createStatement();

        try {
            //Assume a valid connection object conn
            conn.setAutoCommit(false);

            //transaction insert order to database
            String sql = "insert into orders(OrderDate,PaymentMethod,CustomerID) "
                    + "values ('" + date + "','" + paymentMethod + "','" + customerID + "')";
            stmt.executeUpdate(sql);
            // If there is no error.
            conn.commit();

        } catch (SQLException ex) {
            System.out.println("SQL Error insertOrder");
            //if have any error
            conn.rollback();
        } finally {
            stmt.close();
            conn.close();
        }

    }
	
	public void insertIntoOrderLine(String orderID, String pID, int quantity, double price) throws SQLException {
        Connection conn = DatabaseConnection.getconnection();
        Statement stmt = conn.createStatement();
        //Assume a valid connection object conn

        try {
        	conn.setAutoCommit(false);

            //transaction insert order line to database
            String sql = "insert into oderline (orderID, pID, quantity, price)values ('" + orderID + "','" + pID + "','" + quantity + "','" + price + "')";
            stmt.executeUpdate(sql);
            // If there is no error.
            conn.commit();
        } catch (SQLException ex) {
            System.out.println("SQL Error insertOrderLine");
            //if have any error
            conn.rollback();
        } finally {
        	stmt.close();
            conn.close();
        }
    }
}
