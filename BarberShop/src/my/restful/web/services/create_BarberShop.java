package my.restful.web.services;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import java.sql.*;

import org.json.JSONObject;

@Path("Create")


public class create_BarberShop {
	
	static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";
	static final String DB_URL = "jdbc:mysql://localhost/?autoReconnect=true&useSSL=false&allowPublicKeyRetrieval=true";
	
	//Database credentials
	static final String USER = "jason";
	static final String PASS = "jason";
	
	@GET
	@Path("/barbershop")
	//creating barbershop database
	public String create_database() {
		try{
				Connection conn = null;
				
				Class.forName("com.mysql.jdbc.Driver");
				
				System.out.println("Connecting to database...");
				conn = DriverManager.getConnection(DB_URL, USER, PASS);
				
				System.out.println("Creating a database...");
				PreparedStatement ps = conn.prepareStatement("CREATE DATABASE barbershop");
				ps.executeUpdate();
				System.out.println("Database created succesfully...");
				
				ps.close();
				return "Done";
				
			
		} catch(SQLException | ClassNotFoundException e) {
				e.printStackTrace();
				return "Failed";
		}
		
	}

}
