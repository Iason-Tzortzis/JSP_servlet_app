package my.restful.web.services;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import java.sql.*;
import java.util.UUID;

import org.json.JSONObject;

@Path("LoggedInUsers")
//keeping track of logged in users
public class loggedInUsers {
	
	static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";
	static final String DB_URL = "jdbc:mysql://localhost/usersDatabase?autoReconnect=true&useSSL=false&allowPublicKeyRetrieval=true";
	
	//Database credentials
	static final String USER = "jason";
	static final String PASS = "jason";
	
	
	@GET
	@Path("/new_loggedInUser/{user_uuid}")
	@Produces(MediaType.TEXT_PLAIN)
	
	public String add_user(@PathParam("user_uuid") String user_uuid) {
		int number = 0;
		String found_uuid = "";
		int found_userID = 0;
		String found_role = "";
		try {
			Connection conn = null;
			
			Class.forName("com.mysql.jdbc.Driver");
			
			System.out.println("Connecting to database...");
			conn = DriverManager.getConnection(DB_URL, USER, PASS);
			
			System.out.println("Creating a table...");
			PreparedStatement ps = conn.prepareStatement("CREATE TABLE loggedInUsers (NoUsers INT(50),Uuid VARCHAR(50),userID INT(50),Role VARCHAR(50))");
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
			PreparedStatement ps = conn.prepareStatement("SELECT * FROM loggedInUsers WHERE NoUsers=(SELECT max(NoUsers) FROM loggedInUsers)");
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				number = rs.getInt("NoUsers");
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
			PreparedStatement ps = conn.prepareStatement("SELECT * FROM loggedInUsers WHERE Uuid=?");
			ps.setString(1, user_uuid);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				found_uuid = rs.getString("Uuid");
				System.out.println(found_uuid);
			}
			ps.close();
			if(found_uuid != "") {
				return "Already logged in";
			}
			
			
		} catch(SQLException | ClassNotFoundException e) {
			e.printStackTrace();	
		}
		try {
			Connection conn = null;
			
			Class.forName("com.mysql.jdbc.Driver");
			
			System.out.println("Connecting to database...");
			conn = DriverManager.getConnection(DB_URL, USER, PASS);
			System.out.println("Selecting data...");
			PreparedStatement ps = conn.prepareStatement("SELECT * FROM userstable WHERE Uuid=?");
			ps.setString(1, user_uuid);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				found_userID = rs.getInt("userID");
				found_role = rs.getString("Role");
				System.out.println(found_userID);
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
			
			//Set variables
			int NoUsers = number + 1;
			String Uuid = user_uuid;
			int userID = found_userID;
			
			//Executing query
			System.out.println("Inserting data...");
			PreparedStatement ps = conn.prepareStatement("INSERT INTO loggedInUsers (NoUsers, Uuid, userID,Role) VALUES (?,?,?,?)");
			ps.setInt(1, NoUsers);
			ps.setString(2, Uuid);
			ps.setInt(3, userID);
			ps.setString(4,found_role);
			ps.executeUpdate();
			System.out.println("Data inserted successfuly");
			ps.close();
		} catch(SQLException | ClassNotFoundException e) {
			e.printStackTrace();	
		}
		
		return "Done";
		

	}
}
