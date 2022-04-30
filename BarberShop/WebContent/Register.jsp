<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.sun.jersey.api.client.Client"%>
<%@ page import="com.sun.jersey.api.client.ClientResponse"%>  
<%@ page import="com.sun.jersey.api.client.WebResource" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Register</title>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>
<%
//creating user table if doesnt exist
	try{
		Client client = Client.create();
		WebResource webResource = client.resource("http://localhost:8080/BarberShop/rest/Creating/usersDatabase");
		ClientResponse myresponse = webResource.accept("text/plain").get(ClientResponse.class);
		String output = myresponse.getEntity(String.class); 
		System.out.println(output);
	
		if(myresponse.getStatus() != 200){
			throw new RuntimeException("failed: HTTP error code : " + myresponse.getStatus());
		}
	} catch(Exception e){
			e.printStackTrace();
		}
	
//taking info that was submitted and creating new account
if(request.getParameter("btn") != null){
	
	String Username = request.getParameter("Username");
	String Password = request.getParameter("Password");
	String Role = request.getParameter("role");
	try{
		Client client = Client.create();
		WebResource webResource = client.resource("http://localhost:8080/BarberShop/rest/Register/new_user/"+Username+"/"+Password+"/"+Role);
		ClientResponse myresponse = webResource.accept("text/plain").get(ClientResponse.class);

		if(myresponse.getStatus() != 200){
			throw new RuntimeException("failed: HTTP error code : " + myresponse.getStatus());
		}
		String output = myresponse.getEntity(String.class); 
		System.out.println(output);
		if(output.equals("Fail") != true){
		String redirectURL = "http://localhost:8080/BarberShop/Login.jsp";
	    response.sendRedirect(redirectURL);
		}
	} catch(Exception e){
			e.printStackTrace();
		}
	}

%>
<div class="container-fluid">
	<div class="card mx-auto mt-5" id="registerCard">
   		<div class="card-body">
			<h3 class="card-title">Register</h3>
			<form method="POST">
			<label for="Username" class="form-label">Username</label>
			<input type="text" name="Username" value="" placeholder="Username" id="Username" class="form-control" required><br>
			<label for="Password" class="form-label">Password</label>
			<input type="password" name="Password" value="" placeholder="Password" id="Password" class="form-control" required><br>
			<label for="role">Choose a role:</label>
			
			<select class="form-select" name="role" id="role">
			  <option value="user">user</option>
			  <option value="administrator">administrator</option>
			</select><br>
			<button type="submit" name="btn" value="Submit" class="btn btn-primary">Submit</button>
			</form>
			<div class="text-center mt-3">
				<a class="btn btn-primary" href="/BarberShop/Login.jsp" role="button">Login</a><br><br>
			</div>
		</div>
	</div>
</div>
</body>
</html>