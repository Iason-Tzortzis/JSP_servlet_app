<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.sun.jersey.api.client.Client"%>
<%@ page import="com.sun.jersey.api.client.ClientResponse"%>  
<%@ page import="com.sun.jersey.api.client.WebResource" %>
<%@ page import="org.json.JSONObject" %>
<%@ page import="org.json.*" %>
  
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<h1>More info</h1>
<% 
String output = "";
	
try{
	Client client = Client.create();
	WebResource webResource = client.resource("http://localhost:8080/BarberShop/rest/Information/info/barber");
	ClientResponse myresponse = webResource.accept("application/json").get(ClientResponse.class);

	if(myresponse.getStatus() != 200){
		throw new RuntimeException("failed: HTTP error code : " + myresponse.getStatus());
	}
	output = myresponse.getEntity(String.class); 
	System.out.println(output);
} catch(Exception e){
		e.printStackTrace();
	}
JSONObject json = new JSONObject(output);  

String an = json.getString("hello");
%>

<p><%=an %></p>

</body>
</html>