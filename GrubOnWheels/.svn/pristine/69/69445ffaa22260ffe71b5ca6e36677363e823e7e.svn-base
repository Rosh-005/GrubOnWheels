package actions;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.mindrot.jbcrypt.BCrypt;

import database.DatabaseConnection;

@WebServlet("/ResetPassword")
public class ResetPassword extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	protected synchronized void resetPassword(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException{
		res.setContentType("text/html;charset=UTF-8");
		try {
			String phone = req.getParameter("phone");
			String password = req.getParameter("password");
			String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());
			String action = req.getParameter("action");
			String tableName = "";
			String redirectUrl = "";
			
			if(action.equalsIgnoreCase("fuser")) {
				tableName = "users";
				phone = "+44" + phone;
				redirectUrl = "userLogin.jsp?";
			} else if(action.equalsIgnoreCase("frest")){
				tableName = "restaurants";
				redirectUrl = "restaurantLogin.jsp?";
			} else if(action.equalsIgnoreCase("fdelivery")){
				tableName = "delivery_agent";
				redirectUrl = "deliveryLogin.jsp?";
			}
			
			Connection conn = DatabaseConnection.getconnection();
			PreparedStatement ptst = null;
			ptst = conn.prepareStatement("Update "+tableName+" set pass = '"+hashedPassword+"' where phone = '"+phone+"'");
			int updateCount = ptst.executeUpdate();
			if(updateCount > 0) {
				res.sendRedirect(redirectUrl + "passUpdate");
			} else {
				res.sendRedirect("forgotPassword.jsp?Failed");
			}
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		resetPassword(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		resetPassword(req, resp);
	}
	
	

}
