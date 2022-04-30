<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.sun.jersey.api.client.Client"%>
<%@ page import="com.sun.jersey.api.client.ClientResponse"%>  
<%@ page import="com.sun.jersey.api.client.WebResource" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Book appointment</title>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>
<%

String uuid_value = "";
String userID = "";
String price = "";



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

//if user not logged in redirect to login page
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

int intuserID = Integer. parseInt(userID);

//checking if submitting info add appointment
if(request.getParameter("btn") != null){
	
	String date = new String(request.getParameter("Date"));
	String time = new String(request.getParameter("time"));
	String haircut = request.getParameter("haircut");
	String firstname = request.getParameter("firstname");
	if(haircut.equals("normal") != true){
		 price = String.valueOf(15);
	}else{
		 price = String.valueOf(9);
	}
	try{
		Client client = Client.create();
		WebResource webResource = client.resource("http://localhost:8080/BarberShop/rest/CreateAppointment/new_appointment/"+date+"/"+haircut+"/"+time+"/"+intuserID+"/"+price+"/"+firstname);
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

%>

<div class="container-fluid">
	<div class="card mx-auto mt-5" id="appointmentCard">
   		<div class="card-body">
				<h3 class="card-title text-center mb-3">Book your appointment</h3>
				<form method="POST">
				<label for="date" class="form-label">Enter the date</label>
				<input type="text" name="Date" value="" placeholder="DD.MM.YYYY" class="form-control" id="date" required><br><br>
				<label for="firstname" class="form-label">Enter your Firstname</label>
				<input type="text" name="firstname" value="" placeholder="Firstname" id="firstname" class="form-control" required><br><br>
				<label for="haircut">Choose type of haircut:</label>
				
				<select class="form-select" name="haircut" id="haircut">
				  <option value="normal">normal</option>
				  <option value="extreme">extreme</option>
				</select><br><br>
				
				<label for="time">Choose a time:</label>
				
				<select class="form-select" aria-label="8.00" name="time" id="time">
				  <option value="08.00">8.00</option>
				  <option value="09.00">9.00</option>
				  <option value="10.00">10.00</option>
				  <option value="11.00">11.00</option>
				  <option value="12.00">12.00</option>
				  <option value="13.00">13.00</option>
				  <option value="14.00">14.00</option>
				  <option value="15.00">15.00</option>
				</select><br>
				<button type="submit" name="btn" value="Submit" class="btn btn-primary">Submit</button>
				
				</form>
				<div class="text-center mt-4">
			<a class="btn btn-primary" href="/BarberShop/home.jsp" role="button">Back to Home Page</a><br><br>
			</div>
		</div>
	</div>
</div>




</body>
</html>