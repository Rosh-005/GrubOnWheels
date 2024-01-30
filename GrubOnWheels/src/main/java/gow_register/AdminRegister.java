package gow_register;

import java.sql.Connection;
import java.sql.PreparedStatement;

import org.mindrot.jbcrypt.BCrypt;

import database.DatabaseConnection;

public class AdminRegister {

	public static void main(String[] args) {

		String firstName = "";
		String lastName = "";
		String username = "";
		String pass = "";
		String hashedPassword = BCrypt.hashpw(pass, BCrypt.gensalt());

		try {
			Connection conn = DatabaseConnection.getconnection();
			PreparedStatement ptst = conn
					.prepareStatement("Insert into admin (fname, lname, username, pass) values (?,?,?,?)");
			ptst.setString(1, firstName);
			ptst.setString(2, lastName);
			ptst.setString(3, username);
			ptst.setString(4, hashedPassword);
			if (!firstName.isEmpty() && !lastName.isEmpty() && !username.isEmpty() && !hashedPassword.isEmpty()
					&& hashedPassword != null) {
				int insert = ptst.executeUpdate();
				if (insert > 0) {
					System.out.println("Admin inserted...");
				} else {
					System.out.println("Insertion failed");
				}
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
	}

}
