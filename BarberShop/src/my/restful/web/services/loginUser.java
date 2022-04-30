package my.restful.web.services;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import java.sql.*;
import java.util.UUID;

import org.json.JSONObject;


@Path("Login")
//logging in user
public class loginUser {
	
	static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";
	static final String DB_URL = "jdbc:mysql://localhost/usersdatabase?autoReconnect=true&useSSL=false&allowPublicKeyRetrieval=true";
	
	//Database credentials
	static final String USER = "jason";
	static final String PASS = "jason";
	
	@GET
	@Path("/login_user/{username}/{password}")
	@Produces(MediaType.TEXT_PLAIN)
	
	public String add_user(@PathParam("username") String username, @PathParam("password") String password) {
		String x = new String(username);
		String y = new String(password);
		String uuid = "";
		try {
		Connection conn = null;
		
		Class.forName("com.mysql.jdbc.Driver");
		
		System.out.println("Connecting to database...");
		conn = DriverManager.getConnection(DB_URL, USER, PASS);
		
		System.out.println("Selecting data...");
		
		PreparedStatement ps = conn.prepareStatement("SELECT * FROM userstable WHERE Username=? AND Password=?");
		ps.setString(1, x);
		ps.setString(2, y);
		ResultSet rs = ps.executeQuery();
		while(rs.next()) {
			uuid = rs.getString("Uuid");
		}
		ps.close();
		} catch(SQLException | ClassNotFoundException e) {
			e.printStackTrace();	
		}
		if(uuid != "") {
			return uuid;
		}else {
			return "Login Failed";
		}
	}
}
