package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import actions.SendNotification;
import database.DatabaseConnection;
import model.ChatMessage;

@WebServlet("/ChatServlet")
public class ChatServlet extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected synchronized void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("application/json");
		try {
			String action = req.getParameter("action");
			Connection conn = DatabaseConnection.getconnection();
			
			if(action.equalsIgnoreCase("send")) {
				String userID = req.getParameter("user");
				String restaurantID = req.getParameter("restaurant");
				String userRestID = userID + "_" + restaurantID;
				String message = req.getParameter("message");	
				Timestamp timestamp = new Timestamp(System.currentTimeMillis());
				String sendAction = req.getParameter("sendaction");
				String sender = "";
				String receiver = "";
				String senderName = "";
				if(sendAction.equalsIgnoreCase("user")) {
					sender = userID;
					receiver = restaurantID;
					senderName = req.getParameter("senderName");
				} else if (sendAction.equalsIgnoreCase("restaurant")) {
					sender = restaurantID;
					receiver = userID;
					senderName = req.getParameter("restaurantName");
				}
				
				try {
					PreparedStatement ptst = conn.prepareStatement("Insert into chat_messages (user_rest_id, message, `time`, sender, receiver) values (?,?,?,?,?)");
					ptst.setString(1, userRestID);
					ptst.setString(2, message);
					ptst.setTimestamp(3, timestamp);
					ptst.setString(4, sender);
					ptst.setString(5, receiver);
					int insertCount = ptst.executeUpdate();
					if(insertCount > 0) {
						Statement stmt = conn.createStatement();
						if(sendAction.equalsIgnoreCase("restaurant")) {
							ResultSet rs = stmt.executeQuery("Select name, phone from users where id = '"+receiver+"'");
							rs.next();
							String name = rs.getString("name");
							String phone = rs.getString("phone");
							SendNotification sendNotification = new SendNotification();
							String messageSid = sendNotification.sendNotification(name, phone, senderName);
							if(messageSid != null) {
								System.out.println("Message Sent! "+messageSid);
							} else {
								System.out.println("Error in Sending Message....");
							}
						} else if (sendAction.equalsIgnoreCase("user")) {
							ResultSet rs = stmt.executeQuery("Select restname, phone from restaurants where id = '"+receiver+"'");
							rs.next();
							String name = rs.getString("restname");
							String phone ="+44" + rs.getString("phone");
							SendNotification sendNotification = new SendNotification();
							String messageSid = sendNotification.sendNotification(name, phone, senderName);
							if(messageSid != null) {
								System.out.println("Message Sent! "+messageSid);
							} else {
								System.out.println("Error in Sending Message....");
							
						}
						}
						resp.setStatus(HttpServletResponse.SC_OK);
					} else {
						resp.getWriter().write("Insertion failed...");
					}
					
				} catch (SQLException e) {
					// TODO: handle exception
					e.printStackTrace();
				}
			} else if(action.equalsIgnoreCase("receive")) {
				String userID = req.getParameter("user");
				String restaurantID = req.getParameter("restaurant");
				String userRestID = userID + "_" + restaurantID;
				List<ChatMessage> chatHistory = fetchChatHistory(userRestID, conn, action);
				System.out.println(chatHistory);
				
				Gson gson = new Gson();
				String jsonChatHistory = gson.toJson(chatHistory);
				
				PrintWriter out = resp.getWriter();
		        out.write(jsonChatHistory);
		        out.flush();
			} else if(action.equalsIgnoreCase("restaurantFetch")) {
				String restID = req.getParameter("restaurant");
				List<ChatMessage> chatHistory = fetchChatHistory(restID, conn, action);
				/* List<ChatMessage> chatHistorySenderNames = new ArrayList<ChatMessage>(); */
				Set<String> uniqueSenderIDs = new HashSet<>();
				
				for (ChatMessage chatMessage : chatHistory) {
					if(!chatMessage.getSender().equals(restID)) {
						uniqueSenderIDs.add(chatMessage.getSender());
					} else {
						continue;
					}
			    }
				
				Map<String, String> senderNamesMap = fetchUserNames(uniqueSenderIDs, conn);
				
				Gson gson = new Gson();
				String jsonChatHistorySenderNames = gson.toJson(senderNamesMap);
				
				PrintWriter out = resp.getWriter();
		        out.write(jsonChatHistorySenderNames);
		        out.flush();			
			}
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	private List<ChatMessage> fetchChatHistory(String id, Connection conn, String action){
		List<ChatMessage> chatHistory = new ArrayList<ChatMessage>();
		if(action.equalsIgnoreCase("receive")) {
		try {
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery("Select * from chat_messages where user_rest_id = '"+id+"' order by id");
			while(rs.next()) {
				String message = rs.getString("message");
				String sender = rs.getString("sender");
				String receiver = rs.getString("receiver");
				chatHistory.add(new ChatMessage(sender, message, receiver));
			}
		}catch (SQLException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		} else if(action.equalsIgnoreCase("restaurantFetch")) {	
			String restID = "%" + id;
			try {
				Statement stmt1 = conn.createStatement();
				ResultSet rs = stmt1.executeQuery("Select * from chat_messages where user_rest_id like '"+restID+"' order by id desc");
				while(rs.next()) {
					String message = rs.getString("message");
					String sender = rs.getString("sender");			
					String receiver = rs.getString("receiver");
					chatHistory.add(new ChatMessage(sender, message, receiver));
				}
			} catch (SQLException e) {
				// TODO: handle exception
				e.printStackTrace();
			}
		}
		return chatHistory;
	}
	
	private Map<String, String> fetchUserNames(Set<String> senderIDs, Connection conn){
		Map<String, String> senderNamesMap = new HashMap<>();
		List<String> sender = new ArrayList<String>();
		for(String sID : senderIDs) {
			sender.add("'"+sID+"'");
		}
		String IDOfSender = String.join(",", sender);
		try {
			if(IDOfSender != null && !IDOfSender.isEmpty()) {
			PreparedStatement ptst = conn.prepareStatement("Select id, name from users where id in ("+IDOfSender+")");
			ResultSet rs = ptst.executeQuery();
			while(rs.next()) {
				String senderID = rs.getString("id");
				String senderName = rs.getString("name");
				senderNamesMap.put(senderID, senderName);
			}
			} else {
				System.out.println("Sender IDs empty");
			}
		}catch (SQLException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return senderNamesMap;
	}

}
