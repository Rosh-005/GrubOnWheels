package gow_register;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import org.mindrot.jbcrypt.BCrypt;

import actions.AddressValidation;
import database.DatabaseConnection;

@WebServlet("/RestaurantRegister")
@MultipartConfig(maxFileSize = 1024*1024*10)
public class RestaurantRegister extends HttpServlet{

	

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected synchronized void registerRestaurant(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException{
		res.setContentType("text/html;charset=UTF-8");
		try {
			PrintWriter out = res.getWriter();
			HttpSession session = req.getSession();
			String restaurantName = req.getParameter("restname");
			InputStream is = null;
			Part filPart = req.getPart("restaurantphoto");
            if (filPart != null) {
                System.out.println(filPart.getName());
                System.out.println(filPart.getSize());
                System.out.println(filPart.getContentType());
                is = filPart.getInputStream();
            }
            String phone = req.getParameter("phone");
            String email = req.getParameter("email");
            String address = req.getParameter("address");
            String city = req.getParameter("city");
            String username = req.getParameter("username");
            String password = req.getParameter("pass");
            String status = "InActive";
            String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());
            
            Connection conn = DatabaseConnection.getconnection();
            PreparedStatement ptst;
            Statement stmt = conn.createStatement();
            int selectCount = 0;
    		int insertCount=0;
            try {
            	ResultSet resultSet = stmt.executeQuery("SELECT * FROM restaurants where username = '"+ username +"'");
            	while(resultSet.next()) {
            		selectCount++;
            	}
            	if(selectCount > 0) {
            		System.out.println("Username Already Exists");
            		res.sendRedirect("restaurantRegister.jsp?username");
            	}
            	else {
            		ptst = conn.prepareStatement("Insert into restaurants (restname, email, address, phone, statuss, username, pass, city, respic) values (?, ?, ?, ?, ?, ?, ?, ?, ?)");
            		ptst.setString(1, restaurantName);
            		ptst.setString(2, email);
            		ptst.setString(3, address);
            		ptst.setString(4, phone);
            		ptst.setString(5, status);
            		ptst.setString(6, username);
            		ptst.setString(7, hashedPassword);
            		ptst.setString(8, city);
            		if(is != null) {
            			ptst.setBlob(9, is);
            		}
            		insertCount = ptst.executeUpdate();
            		if(insertCount > 0) {
            			System.out.println("Restaurant Registered!!!");
            			res.sendRedirect("restaurantLogin.jsp?success");
            		}
            		else {
            			res.sendRedirect("restaurantRegister.jsp?failure");
            		}
            	}
            } catch(SQLException e){
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
		registerRestaurant(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		registerRestaurant(req, resp);
	}
	
}