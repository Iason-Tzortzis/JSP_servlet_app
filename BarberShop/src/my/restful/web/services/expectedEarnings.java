package my.restful.web.services;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import java.sql.*;

import org.json.JSONArray;
import org.json.JSONObject;

@Path("GetexpectedEarnings")

public class expectedEarnings {

	static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";
	static final String DB_URL = "jdbc:mysql://localhost/BarberShop?autoReconnect=true&useSSL=false&allowPublicKeyRetrieval=true";
	
	//Database credentials
	static final String USER = "jason";
	static final String PASS = "jason";
	
	@GET
	@Path("/earnings")
	@Produces(MediaType.TEXT_PLAIN)
	
	public String getEarnings() {
		int i = 0;
		try {
			Connection conn = null;
			
			Class.forName("com.mysql.jdbc.Driver");
			
			System.out.println("Connecting to database...");
			conn = DriverManager.getConnection(DB_URL, USER, PASS);
			System.out.println("Selecting data...");
			PreparedStatement ps = conn.prepareStatement("SELECT price FROM appointments");
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				i = i + Integer.parseInt(rs.getString("price"));
			}
			ps.close();
			
			
			
		} catch(SQLException | ClassNotFoundException e) {
			e.printStackTrace();	
		}
		return String.valueOf(i);
		
	}
	
	
	
}
