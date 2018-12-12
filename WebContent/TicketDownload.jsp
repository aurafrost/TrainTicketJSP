<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Ticket Download</title>
</head>
<body>
<% 
String ticket=session.getAttribute("ticket").toString();
%>
<h1>Download Ticket: </h1>

<p>Right click the link and click "save link as" to download:</p>
<a href=<%out.print(ticket);%>>Download</a><br>
<a href="Login.html">Return to Login</a>
</body>
</html>