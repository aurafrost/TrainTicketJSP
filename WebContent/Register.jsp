<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="trainTicket.UsersDAO,trainTicket.User" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Registration</title>
</head>
<body>
<jsp:useBean id="d" class="trainTicket.UsersDAO"></jsp:useBean>
<%
String usr=request.getParameter("username").toString();
String pw=request.getParameter("password").toString();
String email=request.getParameter("email").toString();
boolean b=false;

	if(usr.equals("")||pw.equals("")||email.equals("")){
		response.getWriter().append("Null or invalid characters.");
		RequestDispatcher rd=request.getRequestDispatcher("Register.html");
		rd.include(request, response);
	}
	else{
		User user=new User(usr,pw,email);
		UsersDAO.insertUser(user);
		response.getWriter().append("User registered.");
		RequestDispatcher rd=request.getRequestDispatcher("Login.html");
		rd.include(request, response);
	}

%>
</body>
</html>