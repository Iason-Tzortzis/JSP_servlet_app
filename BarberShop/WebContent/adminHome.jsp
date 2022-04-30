<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.sun.jersey.api.client.Client"%>
<%@ page import="com.sun.jersey.api.client.ClientResponse"%>  
<%@ page import="com.sun.jersey.api.client.WebResource" %>
<%@ page import="org.json.JSONObject" %>
<%@ page import="org.json.JSONArray" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Admin Home</title>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>

<%

String uuid_value = "";
String userID = "";



//Getting the uuid and userID from the cookies

Cookie cookie = null;
Cookie[] cookies = null;

cookies = request.getCookies();

if( cookies != null ) {
   
   for (int i = 0; i < cookies.length; i++) {
	  cookie = cookies[i];
	  String x = cookie.getName();
      if(x.equals("uuid")){
    	  uuid_value = cookie.getValue();
      }
      if(x.equals("userID")){
    	  userID = cookie.getValue();
      }
   }
} else {
   System.out.println("No cookies founds");
}
System.out.println(uuid_value);
System.out.println(userID);

int intuserID = Integer. parseInt(userID);
if(userID.equals("") != false){ 
	try{
		Client client = Client.create();
		WebResource webResource = client.resource("http://localhost:8080/BarberShop/rest/GetuserID/get_userID/"+uuid_value);
		ClientResponse myresponse = webResource.accept("text/plain").get(ClientResponse.class);
		String output = myresponse.getEntity(String.class); 
		System.out.println(output);
		Cookie cookie1 = new Cookie("userID",output);
		cookie1.setMaxAge(60*60*24);
		response.addCookie(cookie1);
		userID = output;
	
		if(myresponse.getStatus() != 200){
			throw new RuntimeException("failed: HTTP error code : " + myresponse.getStatus());
		}
	} catch(Exception e){
			e.printStackTrace();
		}
}
//checking if user logged in and if not redirecting to login page
try{
	Client client = Client.create();
	WebResource webResource = client.resource("http://localhost:8080/BarberShop/rest/CheckIfLoggedIn/uuid_check/"+uuid_value);
	ClientResponse myresponse = webResource.accept("text/plain").get(ClientResponse.class);
	String output1 = myresponse.getEntity(String.class); 
	System.out.println(output1);
	if(output1.equals("Fail") || uuid_value == ""){
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
	WebResource webResource = client.resource("http://localhost:8080/BarberShop/rest/CheckRole/checking_role/"+intuserID);
	ClientResponse myresponse = webResource.accept("text/plain").get(ClientResponse.class);
	String output = myresponse.getEntity(String.class); 
	System.out.println(output);
	if(output.equals("administrator") != true){
		String redirectURL = "http://localhost:8080/BarberShop/Login.jsp";
	    response.sendRedirect(redirectURL);
	}

	if(myresponse.getStatus() != 200){
		throw new RuntimeException("failed: HTTP error code : " + myresponse.getStatus());
	}
} catch(Exception e){
		e.printStackTrace();
	}
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
	<div class="card mx-auto mt-5" id="adminCard">
   		<div class="card-body">
				<h3 class="card-tile text-center mb-3">Welcome Admin</h3>
				<div class="text-center mb-3">
				<h4>All available routes</h4><br>
				<a href="/BarberShop/admin_appointments.jsp">All appointments and delete appointment functionality</a><br><br>
				<a href="/BarberShop/addAppointment_admin.jsp">Add appointment</a><br><br>
				<a href="/BarberShop/usernames.jsp">All Usernames</a><br><br>
				<a href="/BarberShop/updateApppointmentAdmin.jsp">Edit an appointment</a><br><br>
				<a href="/BarberShop/earnings.jsp">View my earnings</a><br><br>
				<a href="/BarberShop/emails.jsp">All Emails</a><br><br>
				
			<form method="POST" class="mt-2">
				<button type="submit" name="logout" value="logout" class="btn btn-primary">Logout</button>
			</form>
			</div>
		</div>
	</div>
</div>
</body>
</html>