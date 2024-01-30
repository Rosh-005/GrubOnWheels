package actions;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import controller.DBControl;
import database.DatabaseConnection;
import model.Dish;
import model.UserCart;

@WebServlet("/AddCart")
public class AddCart extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected synchronized void addToCart(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException, SQLException {
		res.setContentType("text/html;charset=UTF-8");

		HttpSession session = req.getSession();
		String userid = session.getAttribute("userid").toString();
		String dishId = req.getParameter("id");
		String restaurantID = req.getParameter("restid");
		String dishPrice = req.getParameter("price");
		String city = req.getParameter("city");
		int quantity = Integer.parseInt(req.getParameter("quantity"));
		String restaurantName = "";
		String restaurantAddress = "";
		ArrayList<Dish> dishArray = new ArrayList<Dish>();
		ArrayList<UserCart> cartArray = new ArrayList<UserCart>();

		Connection conn = DatabaseConnection.getconnection();
		Statement stmt = null;
		PreparedStatement ptst = null;

		DBControl dbControl = new DBControl();
		session.setAttribute("resid", restaurantID);
		session.setAttribute("city", city);
		session.setAttribute("price", dishPrice);

		dishArray = dbControl.chooseDish(dishId);
		try {
			stmt = conn.createStatement();
			Statement statement = conn.createStatement();
			ResultSet rs1 = statement.executeQuery("Select restname, address from restaurants where id = '"+restaurantID+"'");
			if(rs1.next()) {
				restaurantName = rs1.getString("restname");
				restaurantAddress = rs1.getString("address");
			}
			ResultSet rs = stmt.executeQuery("Select * from usercart where userid = '" + userid + "'");
			if (rs.next() == false) {
				// Adding New Dish to Cart
				PreparedStatement ptst2 = conn.prepareStatement(
						"Insert into usercart (dishname, quantity, price, userid, dishid, restid, restname, restaddress, city) values (?,?,?,?,?,?,?,?,?)");
				ptst2.setString(1, dishArray.get(0).getDishName());
				ptst2.setInt(2, quantity);
				String dPrice1 = Double.toString(dishArray.get(0).getDishPrice());
				ptst2.setString(3, dPrice1);
				ptst2.setString(4, userid);
				ptst2.setString(5, dishArray.get(0).getDishId());
				ptst2.setString(6, restaurantID);
				ptst2.setString(7, restaurantName);
				ptst2.setString(8, restaurantAddress);
				ptst2.setString(9, city);
				int insertCount1 = ptst2.executeUpdate();
				if (insertCount1 > 0) {
					System.out.println("First Cart value inserted");
				}
			}
			rs.beforeFirst();
			while (rs.next()) {
				String dishIdDb = rs.getString("dishid");
				String dishName = rs.getString("dishname");
				int dbQuantity = Integer.parseInt(rs.getString("quantity"));
				double dbPrice = Double.parseDouble(rs.getString("price"));
				String restID = rs.getString("restid");
				String restName = rs.getString("restname");
				String cartCity = rs.getString("city");
				cartArray.add(new UserCart(dishIdDb, dishName, dbPrice, dbQuantity, restID, restName, cartCity));
			}
			if(!(cartArray.isEmpty())) {

				boolean sameDishCheck = false;
				for (int i = 0; i < cartArray.size(); i++) {
					
					if (cartArray.get(i).getDishID().equalsIgnoreCase(dishId)) {
						// Increasing the quantity for same dish
						int updatedQuantity = cartArray.get(i).getQuantity() + quantity;
						PreparedStatement ptst1 = conn.prepareStatement(
								"Update usercart set quantity = '" + updatedQuantity + "' where userid = '" + userid
										+ "' and dishid = '" + cartArray.get(i).getDishID() + "'");
						ptst1.executeUpdate();
						sameDishCheck = true;
						System.out.println("Dish Quantity Updated!");
						cartArray.get(i).setQuantity(cartArray.get(i).getQuantity() + quantity);
						break;
					}
				}
					if(sameDishCheck == false) {
						// Adding new dish to existing cart
						ptst = conn.prepareStatement(
								"Insert into usercart (dishname, quantity, price, userid, dishid, restid, restname, restaddress, city) values (?,?,?,?,?,?,?,?,?)");
						ptst.setString(1, dishArray.get(0).getDishName());
						ptst.setInt(2, quantity);
						String dPrice = Double.toString(dishArray.get(0).getDishPrice());
						ptst.setString(3, dPrice);
						ptst.setString(4, userid);
						ptst.setString(5, dishArray.get(0).getDishId());
						ptst.setString(6, restaurantID);
						ptst.setString(7, restaurantName);
						ptst.setString(8, restaurantAddress);
						ptst.setString(9, city);
						int insertCount = ptst.executeUpdate();						
						if (insertCount > 0) {
							
							System.out.println("New Dish Added!");
						}
					}
			}
			session.setAttribute("cart", cartArray);
			res.sendRedirect("restaurantMenu.jsp?id=" + restaurantID + "&city=" + city + "&name=" + restaurantName);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		try {
			addToCart(req, resp);
		} catch (ServletException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		try {
			addToCart(req, resp);
		} catch (ServletException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}