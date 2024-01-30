package gow_register;

import java.io.IOException;
import java.io.InputStream;
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
import javax.servlet.http.Part;

import org.mindrot.jbcrypt.BCrypt;

import database.DatabaseConnection;

@WebServlet("/DeliveryRegister")
@MultipartConfig(maxFileSize = 1024*1024*10)
public class DeliveryRegister extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	protected synchronized void registerDeliveryAgent(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException{
		res.setContentType("text/html;charset=UTF-8");
		try {
			String agentName = req.getParameter("name");
			String agentLastName = req.getParameter("lname");
			String dob = req.getParameter("dob");
			String gender = req.getParameter("gender");
			String email = req.getParameter("mail");
			String phone = req.getParameter("phone");
			String city = req.getParameter("city");
			String password = req.getParameter("pass");
			String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());
			InputStream is = null;
			Part filePart = req.getPart("pic");
			if(filePart != null) {
				System.out.println(filePart.getName());
                System.out.println(filePart.getSize());
                System.out.println(filePart.getContentType());
                is = filePart.getInputStream();
			}
			String status = "InActive";
			Connection conn = DatabaseConnection.getconnection();
            PreparedStatement ptst;
            Statement stmt = conn.createStatement();
            int selectCount = 0;
    		int insertCount=0;
            try {
            	ResultSet resultSet = stmt.executeQuery("SELECT * FROM delivery_agent where phone = '"+ phone +"'");
            	while(resultSet.next()) {
            		selectCount++;
            	}
            	if(selectCount > 0) {
            		System.out.println("Phone Number Already Exists");
            		res.sendRedirect("deliveryRegister.jsp?phone");
            	}
            	else {
            		ptst = conn.prepareStatement("Insert into delivery_agent (fname, lname, dob, phone, `status`, email, pass, city, gender, pic) values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
            		ptst.setString(1, agentName);
            		ptst.setString(2, agentLastName);
            		ptst.setString(3, dob);
            		ptst.setString(4, phone);
            		ptst.setString(5, status);
            		ptst.setString(6, email);
            		ptst.setString(7, hashedPassword);
            		ptst.setString(8, city);
            		ptst.setString(9, gender);
            		if(is != null) {
            			ptst.setBlob(10, is);
            		}
            		else {
            			res.sendRedirect("deliveryRegister.jsp?no");
            		}
            		insertCount = ptst.executeUpdate();
            		if(insertCount > 0) {
            			System.out.println("Delivery Agent Details Registered!!!");
            			res.sendRedirect("deliveryLogin.jsp?success");
            		}
            		else {
            			res.sendRedirect("deliveryRegister.jsp?no");
            		}
            	}
            } catch(SQLException e){
            	e.printStackTrace();
            }
		}
		catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		registerDeliveryAgent(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		registerDeliveryAgent(req, resp);
	}
	

}
