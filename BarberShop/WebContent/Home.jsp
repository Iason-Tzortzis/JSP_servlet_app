<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.sun.jersey.api.client.Client"%>
<%@ page import="com.sun.jersey.api.client.ClientResponse"%>  
<%@ page import="com.sun.jersey.api.client.WebResource" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Home</title>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>
<%
//getting uuid and userID from cookies
String uuid_value = "";
String new_userID = "";
Cookie cookie = null;
Cookie[] cookies = null;

// Get an array of Cookies associated with the this domain
cookies = request.getCookies();

if( cookies != null ) {
   
   for (int i = 0; i < cookies.length; i++) {
	  cookie = cookies[i];
	  String x = cookie.getName();
      if(x.equals("uuid")){
    	  uuid_value = cookie.getValue();
      }
   }
} else {
   System.out.println("No cookies founds");
}
System.out.println(uuid_value);

//creating barbershop database
	try{
		Client client = Client.create();
		WebResource webResource = client.resource("http://localhost:8080/BarberShop/rest/Create/barbershop");
		ClientResponse myresponse = webResource.accept("text/plain").get(ClientResponse.class);
		String output2 = myresponse.getEntity(String.class); 
		System.out.println(output2);
	
		if(myresponse.getStatus() != 200){
			throw new RuntimeException("failed: HTTP error code : " + myresponse.getStatus());
		}
	} catch(Exception e){
			e.printStackTrace();
		}
//checking if user logged in and if not redirecting to login page
try{
	Client client = Client.create();
	WebResource webResource = client.resource("http://localhost:8080/BarberShop/rest/CheckIfLoggedIn/uuid_check/"+uuid_value);
	ClientResponse myresponse = webResource.accept("text/plain").get(ClientResponse.class);
	String output = myresponse.getEntity(String.class); 
	System.out.println(output);
	if(output.equals("Fail") || uuid_value == ""){
		String redirectURL = "http://localhost:8080/BarberShop/Login.jsp";
	    response.sendRedirect(redirectURL);
	}

	if(myresponse.getStatus() != 200){
		throw new RuntimeException("failed: HTTP error code : " + myresponse.getStatus());
	}
} catch(Exception e){
		e.printStackTrace();
	}

try{
	Client client = Client.create();
	WebResource webResource = client.resource("http://localhost:8080/BarberShop/rest/GetuserID/get_userID/"+uuid_value);
	ClientResponse myresponse = webResource.accept("text/plain").get(ClientResponse.class);
	String output = myresponse.getEntity(String.class); 
	System.out.println(output);
	Cookie cookie1 = new Cookie("userID",output);
	cookie1.setMaxAge(60*60*24);
	response.addCookie(cookie1);
	new_userID = output;

	if(myresponse.getStatus() != 200){
		throw new RuntimeException("failed: HTTP error code : " + myresponse.getStatus());
	}
} catch(Exception e){
		e.printStackTrace();
	}
int intuserID = Integer. parseInt(new_userID);
try{
	Client client = Client.create();
	WebResource webResource = client.resource("http://localhost:8080/BarberShop/rest/CheckRole/checking_role/"+new_userID);
	ClientResponse myresponse = webResource.accept("text/plain").get(ClientResponse.class);
	String output = myresponse.getEntity(String.class); 
	System.out.println(output);
	if(output.equals("user") != true){
		String redirectURL = "http://localhost:8080/BarberShop/adminHome.jsp";
	    response.sendRedirect(redirectURL);
	}

	if(myresponse.getStatus() != 200){
		throw new RuntimeException("failed: HTTP error code : " + myresponse.getStatus());
	}
} catch(Exception e){
		e.printStackTrace();
	}

//if user submits info checking if user exists 

if(request.getParameter("logout") != null){
	
	try{
		Client client = Client.create();
		WebResource webResource = client.resource("http://localhost:8080/BarberShop/rest/LogoutUser/logout/"+uuid_value);
		ClientResponse myresponse = webResource.accept("text/plain").get(ClientResponse.class);

		if(myresponse.getStatus() != 200){
			throw new RuntimeException("failed: HTTP error code : " + myresponse.getStatus());
		}
		String output = myresponse.getEntity(String.class); 
		System.out.println(output);
		String redirectURL = "http://localhost:8080/BarberShop/Login.jsp";
	    response.sendRedirect(redirectURL);
				
	} catch(Exception e){
			e.printStackTrace();
		}
	}




%>
<div class="container-fluid">
	<div class="card mx-auto mt-5" id="homeCard">
   		<div class="card-body">
				<h3 class="card-tile text-center mb-3">Welcome to our barbershop</h3>
				<div class="text-center mb-3">
				<h4>All available routes</h4><br>
				<a href="/BarberShop/info.jsp">View more information</a><br><br>
				<a href="/BarberShop/Newsletter.jsp">Subscribe to our newsletter</a><br><br>
				<a href="/BarberShop/appointment.jsp">Book an appointment</a><br><br>
				<a href="/BarberShop/view_appointments.jsp">View my appointments</a><br><br>
				<a href="/BarberShop/updateAppointment.jsp">Update my appointment</a><br><br>
				<a href="/BarberShop/delete_appointment.jsp">Delete my appointment</a><br><br>
				
				
			<form method="POST" class="mt-2">
				<button type="submit" name="logout" value="logout" class="btn btn-primary">Logout</button>
			</form>
			</div>
		</div>
	</div>
</div>
</body>
</html>