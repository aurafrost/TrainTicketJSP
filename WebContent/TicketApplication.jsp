<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="trainTicket.Ticket,java.util.*,trainTicket.Train,java.text.SimpleDateFormat,java.text.DateFormat" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Ticket Application</title>
</head>
<body>
<%
//get and check passenger count
//set pcount to 0 in case of null
if(session.getAttribute("pcount")==""){
	session.setAttribute("pcount",0);
}
int pcount=(int)session.getAttribute("pcount");

if(pcount==6){
	response.getWriter().append("Passenger limit reached.");
	RequestDispatcher rd=request.getRequestDispatcher("Checkout.html");
	rd.include(request, response);
}
int trainno=(Integer)session.getAttribute("trainno");
Train t=(Train)session.getAttribute("train");

if(request.getParameter("date").equals("")){
	response.getWriter().append("Empty fields.");
	RequestDispatcher rd=request.getRequestDispatcher("Ticket.jsp");
	rd.include(request, response);
}
DateFormat format = new SimpleDateFormat("dd/MM/yyyy");
Date date = format.parse(request.getParameter("date"));
Ticket ticket=new Ticket(date,t);

//get and check inputs
//check name
if(request.getParameter("name").equals("")){
	response.getWriter().append("Empty fields.");
	RequestDispatcher rd=request.getRequestDispatcher("Ticket.jsp");
	rd.include(request, response);
}
String name=request.getParameter("name");
//check age
if(Integer.parseInt(request.getParameter("age"))<0){
	response.getWriter().append("Age cannot be negative.");
	RequestDispatcher rd=request.getRequestDispatcher("Ticket.jsp");
	rd.include(request, response);
}
int age=Integer.parseInt(request.getParameter("age"));
char gender=request.getParameter("gender").charAt(0);
//check gender
if((gender=='M')||(gender=='m')||(gender=='F')||(gender=='f')) {
	ticket.addPassenger(name, age, gender);
}
else {
	response.getWriter().append("Gender should be M or F.");
	RequestDispatcher rd=request.getRequestDispatcher("Ticket.jsp");
	rd.include(request, response);
}
//increment passenger count
session.setAttribute("pcount",pcount+1);
ticket.writeTicket();
String pnr=ticket.getPnr();
session.setAttribute("ticket","C:/tickets/"+pnr+".txt");
response.getWriter().append("Ticket Booked with PNR: "+pnr);
%>
<jsp:forward page="Ticket.html"/>
</body>
</html>