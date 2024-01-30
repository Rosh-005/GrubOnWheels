package servlet;

import java.io.IOException;
import java.net.URLEncoder;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.stripe.Stripe;
import com.stripe.model.Charge;
import com.stripe.exception.CardException;
import com.stripe.exception.StripeException;
import com.stripe.param.ChargeCreateParams;

import actions.GenerateOrderID;
import controller.DBControl;
import database.DatabaseConnection;
import model.UserCart;

@WebServlet("/PaymentServlet")
public class PaymentServlet extends HttpServlet{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected synchronized void processPayment(HttpServletRequest req, HttpServletResponse res) throws ServletException,IOException, SQLException{
		
		String stripeToken = req.getParameter("stripeToken");
        double amount = Double.parseDouble(req.getParameter("amount"));
        String errorMessage = null;
        String redirect = "";

        // Set your Stripe test secret key
        Stripe.apiKey = "sk_test_51NfmIXAgP2g1yK8lqfapOvO5RviMG1pjF6fhXpaPPMhlGOOUWyfwkvlQ2ppdKvaabvevjoqgtzChBWxdkeEdtKFv00wT7Tjk6x";

        boolean paymentSuccessful = false;

        try {
            // Create a charge
            Charge charge = Charge.create(
                new ChargeCreateParams.Builder()
                    .setAmount((long) (amount * 100))
                    .setCurrency("gbp")
                    .setSource(stripeToken)
                    .build()
            );

            // Payment successful
            paymentSuccessful = charge.getPaid();
        } catch (CardException e) {
			// TODO: handle exception
        	errorMessage = e.getStripeError().getMessage();
		}
        
        catch (StripeException e) {
            e.printStackTrace();
        }

        // Respond to the client
        res.setContentType("text/html");
        if (paymentSuccessful) {
        	redirect = insertIntoDB(req, res);
        	res.sendRedirect(redirect);
        } else {
        	res.getWriter().println("Payment failed. Please try again.");
        	res.sendRedirect("paymentForm.jsp?Failed&errorMessage=" + URLEncoder.encode(errorMessage, "UTF-8"));
        }
	}
	
	protected synchronized String insertIntoDB(HttpServletRequest req, HttpServletResponse res) throws SQLException,IOException {
		HttpSession session = req.getSession();
		String userID = session.getAttribute("userid").toString();
		String userName = session.getAttribute("username").toString();
		String userPhone = session.getAttribute("userphone").toString();
		String userAddress = session.getAttribute("userAddress").toString();
		String payMethod = "Card";
		double orderTotal = Double.parseDouble(session.getAttribute("orderTotal").toString());
		DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
        String date = dateFormat.format(new Date());
        ArrayList<UserCart> userCart = new ArrayList<UserCart>();
        userCart = (ArrayList<UserCart>) session.getAttribute("userCart");
        DBControl dbControl = new DBControl();
        String message = "";
        
        if(userCart != null) {
        	dbControl.insertIntoOrders(date, payMethod, userID);
        	
        	try {
        		GenerateOrderID generateOrderID = new GenerateOrderID();
        		String orderID = generateOrderID.generateOrderNumber();
        		for(int i=0; i < userCart.size(); i++) {
        			String dishID = userCart.get(i).getDishID();
        			String dishName = userCart.get(i).getDishName();
        			int quantity = userCart.get(i).getQuantity();
        			double price = userCart.get(i).getDishPrice();
        			String restID = userCart.get(i).getRestaurantID();
        			String restName = userCart.get(i).getRestaurantName();
        			String city = userCart.get(i).getCity();
        			double total = quantity * price;
        			Connection conn = DatabaseConnection.getconnection();
        			Statement stmt = conn.createStatement();
        			dbControl.insertIntoOrderLine(orderID, dishID, quantity, price);
        			int insertUserOrders = stmt.executeUpdate("Insert into useroders (uid, uname, uphone, pid, pname, quantity, "
        					+ "time, orderstatus, resid, total, orderTotal, oid, price, address, city, dastatus) values ('"+userID+"', '"+userName+"', "
        					+ "'"+userPhone+"', '"+dishID+"', '"+dishName+"', '"+quantity+"', '"+date+"', 'waiting', '"+restID+"', '"+total+"', "
        					+ "'"+orderTotal+"', '"+orderID+"', '"+price+"', '"+userAddress+"', '"+city+"', 'Waiting')");
        			if(insertUserOrders > 0) {
        				System.out.println("User Orders Inserted...");
        				PreparedStatement ptst = conn.prepareStatement("Delete from usercart where userid = '"+userID+"'");
        				ptst.executeUpdate();
        				message = "orderHistory.jsp?orderPlaced";
        			} else {
						message = "paymentForm.jsp?DBInsertFailed";
					}
        		}
        		
        	} catch (SQLException e) {
				// TODO: handle exception
        		e.printStackTrace();
			}
        } else {
			res.sendRedirect("userHome.jsp?CartEmpty");
		}
		return message;
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		try {
			processPayment(req, resp);
		} catch (ServletException | IOException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		try {
			processPayment(req, resp);
		} catch (ServletException | IOException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	

}
