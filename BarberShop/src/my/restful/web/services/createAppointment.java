package my.restful.web.services;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import java.sql.*;

import org.json.JSONObject;

@Path("CreateAppointment")


public class createAppointment {
	
	static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";
	static final String DB_URL = "jdbc:mysql://localhost/barbershop?autoReconnect=true&useSSL=false&allowPublicKeyRetrieval=true";
	
	//Database credentials
	static final String USER = "jason";
	static final String PASS = "jason";
	
	@GET
	@Path("/new_appointment/{date}/{haircut}/{time}/{userID}/{price}/{Firstname}")
	@Produces(MediaType.TEXT_PLAIN)
	//adding appointment to database
	public String add_appointment(@PathParam("date") String date, @PathParam("haircut") String haircut , @PathParam("time") String time, @PathParam("userID") int userID,@PathParam("price") String price,@PathParam("Firstname") String Firstname) {
		int number = 0;
		try {
			Connection conn = null;
			
			Class.forName("com.mysql.jdbc.Driver");
			
			System.out.println("Connecting to database...");
			conn = DriverManager.getConnection(DB_URL, USER, PASS);
			
			System.out.println("Creating a table...");
			PreparedStatement ps = conn.prepareStatement("CREATE TABLE appointments (appointmentID INT(50), userID INT(50), time VARCHAR(50), date VARCHAR(50), haircutChosen VARCHAR(50), price VARCHAR(50), Firstname VARCHAR(50))");
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
			PreparedStatement ps = conn.prepareStatement("SELECT * FROM appointments WHERE appointmentID =(SELECT max(appointmentID ) FROM appointments)");
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				number = rs.getInt("appointmentID");
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
			int appointmentID = number + 1;
			int userid = userID;
			String Time = time;
			String Date = date;
			String haircutChosen = haircut; 
			
			//Executing query
			System.out.println("Inserting data...");
			PreparedStatement ps = conn.prepareStatement("INSERT INTO appointments (appointmentID, userID, time, date, haircutChosen,price,Firstname) VALUES (?,?,?,?,?,?,?)");
			ps.setInt(1, appointmentID);
			ps.setInt(2, userid);
			ps.setString(3,Time);
			ps.setString(4,Date);
			ps.setString(5,haircutChosen);
			ps.setString(6,price);
			ps.setString(7, Firstname);
			ps.executeUpdate();
			System.out.println("Data inserted successfuly");
			ps.close();
		} catch(SQLException | ClassNotFoundException e) {
			e.printStackTrace();	
		}
		return "Done";
	}

}
