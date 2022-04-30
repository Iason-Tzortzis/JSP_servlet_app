package my.restful.web.services;

import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import java.sql.*;

import org.json.JSONArray;
import org.json.JSONObject;

@Path("Deleteappointment")

public class deleteAppointment {

	
	static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";
	static final String DB_URL = "jdbc:mysql://localhost/barbershop?autoReconnect=true&useSSL=false&allowPublicKeyRetrieval=true";
	
	//Database credentials
	static final String USER = "jason";
	static final String PASS = "jason";
	
	@GET
	@Path("/delete_appointment/{appointmentID}")
	@Produces(MediaType.TEXT_PLAIN)
	
	
	public String delete_appointment(@PathParam("appointmentID") int appointmentID) {
		boolean found_database = false;
		try {
			Connection conn = null;
			
			Class.forName("com.mysql.jdbc.Driver");
			
			System.out.println("Connecting to database...");
			conn = DriverManager.getConnection(DB_URL, USER, PASS);
			
			System.out.println("Creating a table...");
			PreparedStatement ps = conn.prepareStatement("CREATE TABLE appointments (appointmentID INT(50), userID INT(50), time VARCHAR(50), date VARCHAR(50), haircutChosen VARCHAR(50))");
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
			PreparedStatement ps = conn.prepareStatement("SELECT * FROM appointments WHERE appointmentID = ?");
			ps.setInt(1, appointmentID);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				found_database = true;
			}else {
				return "Failed to find appointments";
			}
			ps.close();
			
			
			
			
			
		} catch(SQLException | ClassNotFoundException e) {
			e.printStackTrace();	
		}
		if(found_database) {
		try {
			Connection conn = null;
			
			Class.forName("com.mysql.jdbc.Driver");
			
			System.out.println("Connecting to database...");
			conn = DriverManager.getConnection(DB_URL, USER, PASS);
			System.out.println("Selecting data...");
			PreparedStatement ps = conn.prepareStatement("DELETE FROM appointments WHERE appointmentID = ?");
			ps.setInt(1, appointmentID);
			ps.executeUpdate();
			System.out.println("Data deleted successfuly");
			ps.close();
			
			
		} catch(SQLException | ClassNotFoundException e) {
			e.printStackTrace();	
		}
	}
		if(found_database) {
			return "Updated successfuly";
			}else {
				return "Failed";
			}
	
	}
}
