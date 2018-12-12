<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="trainTicket.TrainDAO,trainTicket.Train,java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Train Search</title>
</head>
<body>
<%
String source=request.getParameter("source");
String dest=request.getParameter("destination");
if(source.equals("")||dest.equals("")){
	response.getWriter().append("Null fields detected.");
	RequestDispatcher rd=request.getRequestDispatcher("Train.html");
	rd.include(request, response);
}
else{
	List<Train>trains=TrainDAO.findTrains(source, dest);
	if(trains.size()==0){
		response.getWriter().append("No train found.");
		RequestDispatcher rd=request.getRequestDispatcher("Train.html");
		rd.include(request, response);
	}
	else{
		response.getWriter().append("<p>Select a train:</p>");
		response.getWriter().append("<form action='Ticket.jsp' method='Get'><select name='sTrainNo'>");
		for(int i=0;i<trains.size();i++){
			Train t=trains.get(i);
			response.getWriter().append("<option value='"+t.getTrainNo()+"'>"+t.getTrainName()+"</option>");
		}
		response.getWriter().append("</select>");
		response.getWriter().append("<input type='Submit' value='Select'>");
		response.getWriter().append("</form>");
		RequestDispatcher rd=request.getRequestDispatcher("Train.html");
		rd.include(request, response);
	}
}

%>
</body>
</html>