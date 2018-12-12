<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Book Ticket</title>
</head>
<body>
<%

/* session.setAttribute("counter",100); */

int trainno=Integer.parseInt(request.getParameter("sTrainNo"));
out.print("Selected train: "+trainno+"<br>");
session.setAttribute("trainno", trainno);
%>
<form action="TicketApplication.jsp" method="post">
Enter travel date: <input type="date" name="date"><br>
Enter passenger name: <input type="text" name="name"><br>
Enter age: <input type="number" name="age"><br>
Select gender:
<select name="gender">
	<option>Male</option>
	<option>Female</option>
</select><br>
<input type="submit" value="Add Passenger"><br>
</form>
</body>
</html>