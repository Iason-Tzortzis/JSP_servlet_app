package my.restful.web.services;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import java.sql.*;
import java.util.UUID;

import org.json.JSONObject;

@Path("CheckIfLoggedIn")


public class checkIfLoggedIn {
	
	static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";
	static final String DB_URL = "jdbc:mysql://localhost/usersDatabase?autoReconnect=true&useSSL=false&allowPublicKeyRetrieval=true";
	
	//Database credentials
	static final String USER = "jason";
	static final String PASS = "jason";
	
	@GET
	@Path("/uuid_check/{user_uuid_to_check}")
	@Produces(MediaType.TEXT_PLAIN)
	//checking if logged in and if yes sending success message otherwise sending fail
	public String LoggedInCheck(@PathParam("user_uuid_to_check") String user_uuid_to_check) {
		String found_uuid = "";
		try{
				Connection conn = null;
				
				Class.forName("com.mysql.jdbc.Driver");
				
				System.out.println("Connecting to database...");
				conn = DriverManager.getConnection(DB_URL, USER, PASS);
				System.out.println("Selecting data...");
				PreparedStatement ps = conn.prepareStatement("SELECT * FROM loggedInUsers WHERE Uuid=?");
				ps.setString(1, user_uuid_to_check);
				ResultSet rs = ps.executeQuery();
				while(rs.next()) {
					found_uuid = rs.getString("Uuid");
					System.out.println(found_uuid);
				}
				ps.close();
				if(found_uuid != "") {
					return "Success";
				}else {
					return "Fail";
				}
				
			
		} catch(SQLException | ClassNotFoundException e) {
				e.printStackTrace();
				return "Fail";
		}
		
	}
	
}
