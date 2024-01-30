package actions;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import database.DatabaseConnection;

@WebServlet("/AddMenu")
@MultipartConfig(maxFileSize = 1024*1024*10)
public class AddMenu extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected synchronized void addMenuForRestaurant(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException{
		res.setContentType("text/html;charset=UTF-8");
		try {
			HttpSession session = req.getSession(true);
			String restname = session.getAttribute("restname").toString();
			String restid = session.getAttribute("restid").toString();
			String dishName = req.getParameter("dishname");
			String dishType = req.getParameter("dishtype");
			String category = req.getParameter("Category");
			String region = req.getParameter("region");
			String price = req.getParameter("price");
			InputStream is = null;
			Part filPart = req.getPart("dishphoto");
			if(filPart != null) {
				System.out.println("File Upload Success" +filPart.getName());
                is = filPart.getInputStream();
			}
			DateFormat df = new SimpleDateFormat("dd/MM/yyyy hh:mm:ss");
			Date date = new Date();
			String time = df.format(date);
			Connection conn = DatabaseConnection.getconnection();
			
			try {
				PreparedStatement ptst = conn.prepareStatement("Insert into gow.restaurant_menu (restid, restname, "
						+ "dishname, `type`, category, regional, price, dishphoto, `time`) values (?,?,?,?,?,?,?,?,?)");
				ptst.setString(1, restid);
				ptst.setString(2, restname);
				ptst.setString(3, dishName);
				ptst.setString(4, dishType);
				ptst.setString(5, category);
				ptst.setString(6, region);
				ptst.setString(7, price);
				if(is != null) {
					ptst.setBlob(8, is);
				}
				ptst.setString(9, time);
				int insertCount = ptst.executeUpdate();
				if(insertCount>0) {
					res.sendRedirect("addMenu.jsp?success");
				}
				else {
					res.sendRedirect("addMenu.jsp?failed");
				}
			} catch (SQLException e) {
				// TODO: handle exception
				e.printStackTrace();
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		addMenuForRestaurant(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		addMenuForRestaurant(req, resp);
	}
	
}
