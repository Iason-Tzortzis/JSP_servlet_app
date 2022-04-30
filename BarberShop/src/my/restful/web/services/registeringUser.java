package my.restful.web.services;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Cookie;
import javax.ws.rs.core.MediaType;
import java.sql.*;
import java.util.UUID;

import org.json.JSONObject;

@Path("Register")
//registering user
public class registeringUser {

	static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";
	static final String DB_URL = "jdbc:mysql://localhost/usersDatabase?autoReconnect=true&useSSL=false&allowPublicKeyRetrieval=true";
	
	//Database credentials
	static final String USER = "jason";
	static final String PASS = "jason";
	
	
	@GET
	@Path("/new_user/{username}/{password}/{role}")
	@Produces(MediaType.TEXT_PLAIN)
	
	public String add_user(@PathParam("username") String username, @PathParam("password") String password, @PathParam("role") String role) {
		int number = 0;
		String found_user = "";
		try {
			Connection conn = null;
			
			Class.forName("com.mysql.jdbc.Driver");
			
			System.out.println("Connecting to database...");
			conn = DriverManager.getConnection(DB_URL, USER, PASS);
			
			System.out.println("Creating a table...");
			PreparedStatement ps = conn.prepareStatement("CREATE TABLE usersTable (userID INT(50),Username VARCHAR(50),Password VARCHAR(50),Uuid VARCHAR(50),Role VARCHAR(50))");
			ps.executeUpdate();
			System.out.println("Table created Successfully");
		} catch(SQLException | ClassNotFoundException e) {
			e.printStackTrace();	
		}
		try {
			Connection conn = null;
			
			Class.forName("com.mysql.jdbc.Driver");
			
			System.out.println("Connecting to database...");
			conn = DriverManager.getConnection(DB_URL, USER, PASS);
			System.out.println("Selecting data...");
			PreparedStatement ps = conn.prepareStatement("SELECT * FROM userstable WHERE userID=(SELECT max(userID) FROM userstable)");
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				number = rs.getInt("userID");
				System.out.println(number);
			}
			ps.close();
			
			
			
		} catch(SQLException | ClassNotFoundException e) {
			e.printStackTrace();	
		}
		try {
		Connection conn = null;
		
		Class.forName("com.mysql.jdbc.Driver");
		
		System.out.println("Connecting to database...");
		conn = DriverManager.getConnection(DB_URL, USER, PASS);
		
		System.out.println("Selecting data...");
		
		PreparedStatement ps = conn.prepareStatement("SELECT * FROM userstable WHERE Username=? OR Password=?");
		ps.setString(1, username);
		ps.setString(2, password);
		ResultSet rs = ps.executeQuery();
		while(rs.next()) {
			found_user = rs.getString("Username");
		}
		ps.close();
		if(found_user.equals("") != true) {
			return "Fail";
		}
		} catch(SQLException | ClassNotFoundException e) {
			e.printStackTrace();	
		}
		try {
			
			Connection conn = null;
			
			Class.forName("com.mysql.jdbc.Driver");
			
			System.out.println("Connecting to database...");
			conn = DriverManager.getConnection(DB_URL, USER, PASS);
			//Generating UUID
			UUID uuid=UUID.randomUUID();   
			
			//Set variables
			int userID = number + 1;
			String Username = username;
			String Password = password;
			String new_uuid = uuid.toString();
			String Role = role;
			
			
			
			//Executing query
			System.out.println("Inserting data...");
			PreparedStatement ps = conn.prepareStatement("INSERT INTO usersTable (userID, Username, Password, Uuid, Role) VALUES (?,?,?,?,?)");
			ps.setInt(1, userID);
			ps.setString(2, Username);
			ps.setString(3, Password);
			ps.setString(4, new_uuid);
			ps.setString(5, Role);
			ps.executeUpdate();
			System.out.println("Data inserted successfuly");
			ps.close();
		} catch(SQLException | ClassNotFoundException e) {
			e.printStackTrace();	
		}
		return "Done";
	}
	
}
