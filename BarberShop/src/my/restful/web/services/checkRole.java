package my.restful.web.services;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import java.sql.*;

import org.json.JSONObject;

@Path("CheckRole")


public class checkRole {

	
	static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";
	static final String DB_URL = "jdbc:mysql://localhost/usersdatabase?autoReconnect=true&useSSL=false&allowPublicKeyRetrieval=true";
	
	//Database credentials
	static final String USER = "jason";
	static final String PASS = "jason";
	
	@GET
	@Path("/checking_role/{userID}")
	@Produces(MediaType.TEXT_PLAIN)
	
	public String check_role(@PathParam("userID") int userID) {
		String Role = "";
		try {
			Connection conn = null;
			
			Class.forName("com.mysql.jdbc.Driver");
			
			System.out.println("Connecting to database...");
			conn = DriverManager.getConnection(DB_URL, USER, PASS);
			System.out.println("Selecting data...");
			PreparedStatement ps = conn.prepareStatement("SELECT * FROM loggedInUsers WHERE userID=?");
			ps.setInt(1, userID);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				Role = rs.getString("Role");
				System.out.println(Role);
			}
			ps.close();
			
			
			
		} catch(SQLException | ClassNotFoundException e) {
			e.printStackTrace();	
		}
		return Role;
	}
	
	
	
	
	
}
