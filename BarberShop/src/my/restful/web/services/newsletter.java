package my.restful.web.services;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import java.sql.*;

import org.json.JSONObject;

@Path("Newsletter")

//adding newsletter to database
public class newsletter {
	static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";
	static final String DB_URL = "jdbc:mysql://localhost/barbershop?autoReconnect=true&useSSL=false&allowPublicKeyRetrieval=true";
	
	//Database credentials
	static final String USER = "jason";
	static final String PASS = "jason";
	
	
	@GET
	@Path("/new_email/{email}")
	@Produces(MediaType.TEXT_PLAIN)
	
	public String add_email(@PathParam("email") String email) {
		int number = 0;
		try {
			Connection conn = null;
			
			Class.forName("com.mysql.jdbc.Driver");
			
			System.out.println("Connecting to database...");
			conn = DriverManager.getConnection(DB_URL, USER, PASS);
			
			System.out.println("Creating a table...");
			PreparedStatement ps = conn.prepareStatement("CREATE TABLE emails (No_emails INT(50),Email_list VARCHAR(50))");
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
			PreparedStatement ps = conn.prepareStatement("SELECT * FROM emails WHERE No_emails=(SELECT max(No_emails) FROM emails)");
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				number = rs.getInt("No_emails");
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
			
			//Set variables
			int No_emails = number + 1;
			String Email_list = email;
			
			//Executing query
			System.out.println("Inserting data...");
			PreparedStatement ps = conn.prepareStatement("INSERT INTO emails (No_emails, Email_list) VALUES (?,?)");
			ps.setInt(1, No_emails);
			ps.setString(2, Email_list);
			ps.executeUpdate();
			System.out.println("Data inserted successfuly");
			ps.close();
		} catch(SQLException | ClassNotFoundException e) {
			e.printStackTrace();	
		}
		return "Done";
	}
	
	

}
