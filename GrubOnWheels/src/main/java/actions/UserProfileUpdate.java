package actions;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.mindrot.jbcrypt.BCrypt;

import database.DatabaseConnection;

@WebServlet("/UserProfileUpdate")
public class UserProfileUpdate extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected synchronized void updateProfile(HttpServletRequest req, HttpServletResponse res) throws ServletException,IOException{
		res.setContentType("text/html;charset=UTF-8");
		try {
			HttpSession session = req.getSession();
			String emailID = req.getParameter("emailid");
			String phone = "+44" + req.getParameter("phone");
			String address = req.getParameter("address");
			String hashedPassword = req.getParameter("pass");
			String currentPassword = "";
			String newPassword = "";
			if(req.getParameter("currentPass")!= null && req.getParameter("newPass") != null) {
				currentPassword = req.getParameter("currentPass");
				newPassword = req.getParameter("newPass");
			}
			String userid = session.getAttribute("userid").toString();
			Connection conn = DatabaseConnection.getconnection();
			Statement st = conn.createStatement();
			
			try {
				if(currentPassword.isEmpty() || BCrypt.checkpw(currentPassword, hashedPassword)) {
					String updateQuery = "update users set mailid = ?, phone = ?, address = ? ";
					String newPasswordHash = "";
					if(!newPassword.isEmpty()) {
						newPasswordHash = BCrypt.hashpw(newPassword, BCrypt.gensalt());
						updateQuery += ", pass = ? ";
					}
					updateQuery += "where id = ?";
					
					PreparedStatement ptst = conn.prepareStatement(updateQuery);
					ptst.setString(1, emailID);
					ptst.setString(2, phone);
					ptst.setString(3, address);
					int index = 4;
					
					if(!newPassword.isEmpty()) {
						ptst.setString(index++, newPasswordHash);
					}
					ptst.setString(index, userid);
					int updateUserDetails = ptst.executeUpdate();
					if(updateUserDetails > 0) {
						res.sendRedirect("userProfile.jsp?ProfileUpdated");
					}
					else {
						res.sendRedirect("userProfile.jsp?Failed");
						
					}
				} else {
					res.sendRedirect("userProfile.jsp?CurrentPass");
				}
			}catch(Exception e) {
				e.printStackTrace();
			}
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		updateProfile(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		updateProfile(req, resp);
	}
	
	
}
