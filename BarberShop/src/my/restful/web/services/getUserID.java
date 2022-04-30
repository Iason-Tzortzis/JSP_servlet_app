package my.restful.web.services;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import java.sql.*;

import org.json.JSONObject;

@Path("GetuserID")


public class getUserID {
	
	static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";
	static final String DB_URL = "jdbc:mysql://localhost/usersdatabase?autoReconnect=true&useSSL=false&allowPublicKeyRetrieval=true";
	
	//Database credentials
	static final String USER = "jason";
	static final String PASS = "jason";
	
	@GET
	@Path("/get_userID/{uuid}")
	@Produces(MediaType.TEXT_PLAIN)
	//adding appointment to database
	public String get_UserID(@PathParam("uuid") String uuid) {
	int new_userID = 0;
	try {
		Connection conn = null;
		
		Class.forName("com.mysql.jdbc.Driver");
		
		System.out.println("Connecting to database...");
		conn = DriverManager.getConnection(DB_URL, USER, PASS);
		System.out.println("Selecting data...");
		PreparedStatement ps = conn.prepareStatement("SELECT * FROM userstable WHERE Uuid=?");
		ps.setString(1, uuid);
		ResultSet rs = ps.executeQuery();
		while(rs.next()) {
			new_userID = rs.getInt("userID");
			System.out.println(new_userID);
		}
		ps.close();
		
	} catch(SQLException | ClassNotFoundException e) {
		e.printStackTrace();	
	}
	return String.valueOf(new_userID);
}
	
}
