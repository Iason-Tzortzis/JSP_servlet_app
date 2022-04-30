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
<title>Delete Appointment</title>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>
<% 
String uuid_value = "";
String userID = "";
String output2 = "";
int i = 0;
//Getting the uuid and userID from the cookies

Cookie cookie = null;
Cookie[] cookies = null;

cookies = request.getCookies();

if( cookies != null ) {
   
   for (int y = 0; y < cookies.length; y++) {
	  cookie = cookies[y];
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
	if(output.equals("user") != true){
		String redirectURL = "http://localhost:8080/BarberShop/Login.jsp";
	    response.sendRedirect(redirectURL);
	}

	if(myresponse.getStatus() != 200){
		throw new RuntimeException("failed: HTTP error code : " + myresponse.getStatus());
	}
} catch(Exception e){
		e.printStackTrace();
	}

if(request.getParameter("btn") != null){
	int appointmentID = Integer.parseInt(request.getParameter("appointmentID"));
	try{
		Client client = Client.create();
		WebResource webResource = client.resource("http://localhost:8080/BarberShop/rest/Deleteappointment/delete_appointment/"+appointmentID);
		ClientResponse myresponse = webResource.accept("text/plain").get(ClientResponse.class);

		if(myresponse.getStatus() != 200){
			throw new RuntimeException("failed: HTTP error code : " + myresponse.getStatus());
		}
		String output = myresponse.getEntity(String.class); 
		System.out.println(output);
	} catch(Exception e){
			e.printStackTrace();
		}
	}

%>
<div class="container-fluid">
	<div class="card mx-auto mt-5" id="deleteCard">
   		<div class="card-body">
   		<h3 class="card-title text-center mb-3">Delete appointment based on appointmentID</h3>
			<form method="POST">
			<label for="appointmentID" class="form-label">Enter the appointmentID</label>
			<input type="text" name="appointmentID" value="" placeholder="appointmentID" class="form-control" id="appointmentID" required><br><br>
			<button type="submit" name="btn" value="Submit" class="btn btn-primary">Submit</button>
			
			</form>
			
		</div>
	
<% 
int intUserID = Integer.parseInt(userID);

//getting all appointments for user
try{
	Client client = Client.create();
	WebResource webResource = client.resource("http://localhost:8080/BarberShop/rest/GetAppointment/get_appointments/"+intUserID);
	ClientResponse myresponse = webResource.accept("text/plain").get(ClientResponse.class);

	if(myresponse.getStatus() != 200){
		throw new RuntimeException("failed: HTTP error code : " + myresponse.getStatus());
	}
	output2 = myresponse.getEntity(String.class); 
	System.out.println(output2);
} catch(Exception e){
		e.printStackTrace();
	}
JSONArray obj = new JSONArray(output2);

System.out.println(obj);
System.out.println(obj.length());
for(i=1; i<=obj.length(); i++){
	JSONObject json_obj = obj.getJSONObject(i - 1); 
    String date = json_obj.getString("date");
    String time = json_obj.getString("time");
    String haircutChosen = json_obj.getString("haircutChosen");
    int appointmentID = json_obj.getInt("appointmentID");
%>
<div class="container-fluid mt-5" id="infoTable" >
<table class="table table-striped">
<thead>
<tr>
<th align=center class='tr'>Date</th>
<th align=center class='tr'>Time</th>
<th align=center class='tr'>Haircut</th>
<th align=center class='tr'>AppointmentID</th>
</tr>
</thead>
<tbody>
<tr>
<td><%= date %></td>
<td><%= time %></td>
<td><%= haircutChosen %></td>
<td><%= appointmentID %></td>
</tr>
</tbody>
</table>
</div>

<% 
}
%>
<div class="text-center mt-4">
			<a class="btn btn-primary" href="/BarberShop/home.jsp" role="button">Back to Home Page</a><br><br>
			</div>
</div>
</div>
</body>
</html>