package model;

import java.util.ArrayList;
import java.util.List;

public class Restaurant {
	
	private String restaurantID;
	private String restaurantName;
	private List<String> interactedUsers = new ArrayList<String>();
	public Restaurant() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Restaurant(String restaurantID, String restaurantName) {
		super();
		this.restaurantID = restaurantID;
		this.restaurantName = restaurantName;
	}
	public String getRestaurantID() {
		return restaurantID;
	}
	public void setRestaurantID(String restaurantID) {
		this.restaurantID = restaurantID;
	}
	public String getRestaurantName() {
		return restaurantName;
	}
	public void setRestaurantName(String restaurantName) {
		this.restaurantName = restaurantName;
	}
	public List<String> getInteractedUsers() {
		return interactedUsers;
	}
	public void setInteractedUsers(List<String> interactedUsers) {
		this.interactedUsers = interactedUsers;
	}
	
	public void addUser(String user) {
		interactedUsers.add(user);
	}

}
