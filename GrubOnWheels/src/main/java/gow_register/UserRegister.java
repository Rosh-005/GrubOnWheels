package gow_register;

import java.io.IOException;
import java.sql.Connection;
import database.DatabaseConnection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.mindrot.jbcrypt.BCrypt;


@WebServlet("/UserRegister")
public class UserRegister extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected synchronized void registerUser(HttpServletRequest req, HttpServletResponse res) throws ServletException,IOException 
	{
		res.setContentType("text/html;charset=UTF-8");
		try {
		//PrintWriter pw = res.getWriter();
		HttpSession session = req.getSession();
		String name = req.getParameter("name");
		String lname = req.getParameter("lname");
		String email = req.getParameter("email");
		String phone = "+44" + req.getParameter("phone");
		String address1 = req.getParameter("address1");
		String password1 = req.getParameter("password");
		String hashedPassword = BCrypt.hashpw(password1, BCrypt.gensalt());
		
		int selectCount = 0;
		int insertCount=0;
		Connection conn = DatabaseConnection.getconnection();
		PreparedStatement ptst;
		Statement stmt = conn.createStatement();
		try {
			ResultSet resultSet = stmt.executeQuery("SELECT * FROM gow.users where phone = '"+phone+"'");
			while(resultSet.next()) {
				selectCount++;
			}
			if(selectCount>0) {
				System.out.println("Phone Number Already Exist!!! Please Log-in");
				res.sendRedirect("userSignup.jsp?phNoExist");
			}
			else {
				ptst = conn.prepareStatement("insert into users(name, lname, mailid, phone, pass, address) values('" + name + "','" +lname+ "','" + email + "','" + phone + "','" + hashedPassword + "','"+address1+"') ");
				insertCount = ptst.executeUpdate();
				if(insertCount>0) {
					res.sendRedirect("userLogin.jsp?success");
				}
				else {
					String error = "User Not Registered! Please try again";
					req.setAttribute("error1", error);
					RequestDispatcher rd = req.getRequestDispatcher("/userSignup.jsp");
		            rd.forward(req, res); 
				}
			}
		}catch (SQLException e) {
			// TODO: handle exception
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
		registerUser(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		registerUser(req, resp);
	}
}