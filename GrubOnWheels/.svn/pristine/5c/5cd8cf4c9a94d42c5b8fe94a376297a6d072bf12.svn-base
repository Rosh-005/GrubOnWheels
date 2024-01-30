package actions;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import database.DatabaseConnection;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

@WebServlet("/Feedback")
public class Feedback extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	protected synchronized void addFeedback(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException, SQLException{
		res.setContentType("text/html;charset=UTF-8");
		try {
			HttpSession session = req.getSession();
			String userid = session.getAttribute("userid").toString();
			String username = session.getAttribute("username").toString();
			String orderId = req.getParameter("oid");
			String restId = req.getParameter("resid");
			String rating = req.getParameter("notation_note");
			String feedback = req.getParameter("feedback");
			DateFormat dateFormat = new SimpleDateFormat("YYYY/MM/dd HH:mm:ss");
            Date date = new Date();
            String time = dateFormat.format(date);
            System.out.println(time);
            
            Connection conn = DatabaseConnection.getconnection();
            
            try {
            	PreparedStatement ptst = conn.prepareStatement("Insert into del_feedback (uid, name, order_id, "
            			+ "rating, feedback, time, resid) values ('"+userid+"', '"+username+"', '"+orderId+"', "
            			+ "'"+rating+"', '"+feedback+"', '"+time+"', '"+restId+"')");
            	int insertCount = ptst.executeUpdate();
            	if(insertCount > 0) {
            		res.sendRedirect("userHome.jsp?FeedAdded");
            	} else {
					res.sendRedirect("userFeedback.jsp?Failed");
				}
            } catch (SQLException e) {
				// TODO: handle exception
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
		try {
			addFeedback(req, resp);
		} catch (ServletException | IOException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		try {
			addFeedback(req, resp);
		} catch (ServletException | IOException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	

}
