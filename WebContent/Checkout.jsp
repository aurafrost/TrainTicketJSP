<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.time.LocalDate,java.time.format.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Checkout(JSP)</title>
</head>
<body>
<%
if(request.getParameter("cardnum")==""||request.getParameter("emonth")==""||request.getParameter("eyear")==""){
	response.getWriter().append("Empty field.");
	RequestDispatcher rd=request.getRequestDispatcher("Checkout.html");
	rd.include(request, response);
}
if(request.getParameter("cardnum").length()!=16){
	response.getWriter().append("Card number length incorrect.");
	RequestDispatcher rd=request.getRequestDispatcher("Checkout.html");
	rd.include(request, response);
}
String cardnum=request.getParameter("cardnum");

LocalDate curr = LocalDate.now();
if((Integer.parseInt(request.getParameter("emonth"))<curr.getMonthValue()&&
		Integer.parseInt(request.getParameter("eyear"))<=curr.getYear())||
		Integer.parseInt(request.getParameter("eyear"))<curr.getYear()){
	response.getWriter().append("Card has expired.");
	RequestDispatcher rd=request.getRequestDispatcher("Checkout.html");
	rd.include(request, response);
}
int month=Integer.parseInt(request.getParameter("emonth"));
int year=Integer.parseInt(request.getParameter("eyear"));
%>
<jsp:forward page="TicketDownload.jsp"/>
</body>
</html>