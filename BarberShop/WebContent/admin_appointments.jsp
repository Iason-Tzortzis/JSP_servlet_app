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
<title>All Appointments</title>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>
<div class="container-fluid">
	<div class="card mx-auto mt-5" id="admin_appointentsCard">
   		<div class="card-body">
			<h3 class="card-title">All appointments</h3>
			<form method="POST">
			<label for="appointmentID" class="form-label">Enter the appointmentID</label>
			<input type="text" name="appointmentID" value="" placeholder="appointmentID" class="form-control" id="appointmentID" required><br><br>
			<button type="submit" name="delete" value="Delete" class="btn btn-primary">Delete</button>
			</form>
			
		</div>
	
<% 
String output = "";
String userID = "";
int i = 0;
//getting uuid and userID from cookies
String uuid_value = "";
Cookie cookie = null;
Cookie[] cookies = null;

//Get an array of Cookies associated with the this domain
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
//checking if user logged in and if not redirecting to login page
try{
	Client client = Client.create();
	WebResource webResource = client.resource("http://localhost:8080/BarberShop/rest/CheckIfLoggedIn/uuid_check/"+uuid_value);
	ClientResponse myresponse = webResource.accept("text/plain").get(ClientResponse.class);
	String output1 = myresponse.getEntity(String.class); 
	System.out.println(output1);
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

int intuserID = Integer.parseInt(userID);
try{
	Client client = Client.create();
	WebResource webResource = client.resource("http://localhost:8080/BarberShop/rest/CheckRole/checking_role/"+intuserID);
	ClientResponse myresponse = webResource.accept("text/plain").get(ClientResponse.class);
	String output1 = myresponse.getEntity(String.class); 
	System.out.println(output1);
	if(output1.equals("administrator") != true){
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
		WebResource webResource = client.resource("http://localhost:8080/BarberShop/rest/GetAdminappointments/get_appointments");
		ClientResponse myresponse = webResource.accept("application/json").get(ClientResponse.class);
		output = myresponse.getEntity(String.class); 
		System.out.println(output);
	
		if(myresponse.getStatus() != 200){
			throw new RuntimeException("failed: HTTP error code : " + myresponse.getStatus());
		}
	} catch(Exception e){
			e.printStackTrace();
		}

JSONArray obj = new JSONArray(output);

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


if(request.getParameter("delete") != null){
	
	try{
		int x = Integer.parseInt(request.getParameter("appointmentID"));
		Client client = Client.create();
		WebResource webResource = client.resource("http://localhost:8080/BarberShop/rest/Deleteappointment_Admin/delete_Appointment_Admin/"+x);
		ClientResponse myresponse = webResource.accept("text/plain").get(ClientResponse.class);

		if(myresponse.getStatus() != 200){
			throw new RuntimeException("failed: HTTP error code : " + myresponse.getStatus());
		}
		output = myresponse.getEntity(String.class); 
		System.out.println(output);
		String redirectURL = "http://localhost:8080/BarberShop/admin_appointments.jsp";
	    response.sendRedirect(redirectURL);
	} catch(Exception e){
			e.printStackTrace();
		}
	}

%>
<div class="text-center mt-4">
			<a class="btn btn-primary" href="/BarberShop/adminHome.jsp" role="button">Back to Home Page</a><br><br>
			</div>
</div>
</div>

</body>
</html>