package servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.twilio.Twilio;
import com.twilio.exception.ApiException;
import com.twilio.rest.lookups.v2.PhoneNumber;

import database.DatabaseConnection;

@WebServlet("/PhoneNumberServlet")
public class PhoneNumberServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private static final String ACCOUNT_SID = "ACc6a4321030e90f2e58078b2f87553de4";
    private static final String AUTH_TOKEN = "e8f3b39e0b5d875d5e0383ae2b74d9a0";

	@Override
	protected synchronized void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		resp.setContentType("text/plain");
		HttpSession session = req.getSession();
		String action = req.getParameter("action");
		String phoneno = req.getParameter("phone");		
		String response = "";
		String userid = "";
		if(action.equalsIgnoreCase("userprofile")) {
		userid = session.getAttribute("userid").toString();
		}
		
		if(action.equalsIgnoreCase("user") || action.equalsIgnoreCase("userprofile")) {
			try {
				Twilio.init(ACCOUNT_SID, AUTH_TOKEN);
				phoneno = "+44" + phoneno;
				PhoneNumber phone = PhoneNumber.fetcher(phoneno).fetch();
				
                // Check if the phone number is valid
                if (phone.getValid() == true) {
                    response = "valid";
                } else {
                    response = "invalid";
                    resp.getWriter().write(response);
                }
            } catch (ApiException e) {
                // Twilio Lookup failed, so considering it as an invalid number
                response = "invalid";
                resp.getWriter().write(response);
            }
		}
		if(!action.equalsIgnoreCase("user") || !action.equalsIgnoreCase("userprofile") || response.equalsIgnoreCase("valid")) {
		boolean phoneNumberExists = checkPhoneNumber(phoneno, action, userid);
        
        resp.setContentType("text/plain");
        
        resp.getWriter().write(String.valueOf(phoneNumberExists));
		}
	}
	
	private boolean checkPhoneNumber(String phoneno, String action, String id) {
		boolean isPhoneNoExist = false;
		String tableName = "";
		if(action.equalsIgnoreCase("restaurant") || action.equalsIgnoreCase("frest")) {
			tableName = "restaurants";
		} else if (action.equalsIgnoreCase("delivery") || action.equalsIgnoreCase("fdelivery")) {
			tableName = "delivery_agent";
		} else if(action.equalsIgnoreCase("user") || action.equalsIgnoreCase("fuser")) {
			tableName = "users";
		}
		try {
			Connection con = DatabaseConnection.getconnection();
			Statement stmt = con.createStatement();
			if(!action.equalsIgnoreCase("userprofile")) {
			ResultSet rs = stmt.executeQuery("select * from "+tableName+" where phone = '"+phoneno+"'");
			if(rs.next()) {
				isPhoneNoExist = true;
			}
			else {
				isPhoneNoExist = false;
			}
			} else {
				ResultSet rs = stmt.executeQuery("Select * from users where phone = '"+phoneno+"' and id != '"+id+"'");
				if(rs.next()) {
					isPhoneNoExist = true;
				}else {
					isPhoneNoExist = false;
				}
			}
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return isPhoneNoExist;	
		}
	}

	

