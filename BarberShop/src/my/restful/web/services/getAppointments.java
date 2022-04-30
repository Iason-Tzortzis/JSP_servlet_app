package my.restful.web.services;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import java.sql.*;

import org.json.JSONArray;
import org.json.JSONObject;

@Path("GetAppointment")

//getting users appointments based on userID
public class getAppointments {
	
	static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";
	static final String DB_URL = "jdbc:mysql://localhost/barbershop?autoReconnect=true&useSSL=false&allowPublicKeyRetrieval=true";
	
	//Database credentials
	static final String USER = "jason";
	static final String PASS = "jason";
	
	@GET
	@Path("/get_appointments/{userID}")
	@Produces(MediaType.TEXT_PLAIN)
	
	public String add_appointment(@PathParam("userID") String userID) {
		JSONArray json = new JSONArray();
		try {
			Connection conn = null;
			
			Class.forName("com.mysql.jdbc.Driver");
			System.out.println("Connecting to database...");
			conn = DriverManager.getConnection(DB_URL, USER, PASS);
			System.out.println("Selecting data...");
			PreparedStatement ps = conn.prepareStatement("SELECT * FROM appointments WHERE userID=?");
			ps.setString(1, userID);
			ResultSet rs = ps.executeQuery();
			ResultSetMetaData rsmd = rs.getMetaData();
			while(rs.next()) {
				  int numColumns = rsmd.getColumnCount();
				  JSONObject obj = new JSONObject();
				  for (int i=1; i<=numColumns; i++) {
				    String column_name = rsmd.getColumnName(i);
				    obj.put(column_name, rs.getObject(column_name));
				  }
				  json.put(obj);
				}
				
				ps.close();
		} catch(SQLException | ClassNotFoundException e) {
			e.printStackTrace();	
		}
		return json.toString();
	

	}
	
}
