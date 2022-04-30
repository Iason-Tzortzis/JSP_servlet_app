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
<title>Total Projected Earnings</title>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>

<% 
String output = "";
String earnings = "";
String uuid_value = "";
String userID = "";
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
		WebResource webResource = client.resource("http://localhost:8080/BarberShop/rest/GetexpectedEarnings/earnings");
		ClientResponse myresponse = webResource.accept("text/plain").get(ClientResponse.class);

		if(myresponse.getStatus() != 200){
			throw new RuntimeException("failed: HTTP error code : " + myresponse.getStatus());
		}
		output = myresponse.getEntity(String.class); 
		System.out.println(output);
		earnings = output;
	} catch(Exception e){
			e.printStackTrace();
		}
	
	
	%>
	<div class="container-fluid">
		<div class="card mx-auto mt-5" id="earningsCard">
			<div class="card-body text-center">
			<h3 class="card-title">Total Projected Earnings</h3>
	
				<h4>Total earnings: <%=earnings %>$</h4>
			</div>
			<div class="text-center mt-3">
			<a class="btn btn-primary" href="/BarberShop/adminHome.jsp" role="button">Back to Home Page</a><br><br>
			</div>
		</div>
	</div>
</body>
</html>