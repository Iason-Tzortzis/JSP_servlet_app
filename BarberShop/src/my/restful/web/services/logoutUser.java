package my.restful.web.services;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import java.sql.*;
import java.util.UUID;

import org.json.JSONObject;

@Path("LogoutUser")

public class logoutUser {
	
	static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";
	static final String DB_URL = "jdbc:mysql://localhost/usersDatabase?autoReconnect=true&useSSL=false&allowPublicKeyRetrieval=true";
	
	//Database credentials
	static final String USER = "jason";
	static final String PASS = "jason";
	
	
	@GET
	@Path("/logout/{user_uuid}")
	@Produces(MediaType.TEXT_PLAIN)

	public String logout_user(@PathParam("user_uuid") String user_uuid) {
		try {
			Connection conn = null;
			
			Class.forName("com.mysql.jdbc.Driver");
			
			System.out.println("Connecting to database...");
			conn = DriverManager.getConnection(DB_URL, USER, PASS);
			System.out.println("Selecting data...");
			PreparedStatement ps = conn.prepareStatement("DELETE FROM loggedInUsers WHERE Uuid = ?");
			ps.setString(1, user_uuid);
			ps.executeUpdate();
			System.out.println("Data deleted successfuly");
			ps.close();
			
		} catch(SQLException | ClassNotFoundException e) {
			e.printStackTrace();	
		}
		return "Done";
			
	}

}


