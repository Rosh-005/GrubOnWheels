package model;

public class UserCart {

	private String dishID;
	private String dishName;
	private double dishPrice;
	private int quantity;
	private String restaurantID;
	private String restaurantName;
	private String city;

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
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

	

	public UserCart(String dishID, String dishName, double dishPrice, int quantity, String restaurantID,
			String restaurantName, String city) {
		super();
		this.dishID = dishID;
		this.dishName = dishName;
		this.dishPrice = dishPrice;
		this.quantity = quantity;
		this.restaurantID = restaurantID;
		this.restaurantName = restaurantName;
		this.city = city;
	}

	public String getDishID() {
		return dishID;
	}

	public void setDishID(String dishID) {
		this.dishID = dishID;
	}

	public String getDishName() {
		return dishName;
	}

	public void setDishName(String dishName) {
		this.dishName = dishName;
	}

	public double getDishPrice() {
		return dishPrice;
	}

	public void setDishPrice(double dishPrice) {
		this.dishPrice = dishPrice;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

}
