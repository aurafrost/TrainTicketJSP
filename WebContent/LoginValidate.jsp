<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="trainTicket.UsersDAO,trainTicket.User" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Validation</title>
</head>
<body>
<jsp:useBean id="d" class="trainTicket.UsersDAO"></jsp:useBean>
<%
//set pcount to prevent later nulls
session.setAttribute("pcount",0);

if(request.getParameter("username").equals("")||request.getParameter("password").equals("")){
	response.getWriter().append("Empty fields.");
	RequestDispatcher rd=request.getRequestDispatcher("Login.html");
	rd.include(request, response);
}
String name=request.getParameter("username");
String pw=request.getParameter("password");
User u=UsersDAO.getUser(name);
if(u.getPassword().equals(pw)){
	RequestDispatcher rd=request.getRequestDispatcher("Train.html");
	rd.forward(request, response);
}
else{
	response.getWriter().append("User not registered.");
	RequestDispatcher rd=request.getRequestDispatcher("Login.html");
	rd.include(request, response);
}
%>

</body>
</html>