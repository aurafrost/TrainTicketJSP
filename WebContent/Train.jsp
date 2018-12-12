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
if(request.getParameter("trainno").equals("")){
	response.getWriter().append("Null or invalid characters.");
	RequestDispatcher rd=request.getRequestDispatcher("Train.html");
	rd.include(request, response);
}
else{
	int trainno=Integer.parseInt(request.getParameter("trainno"));
	//need to figure out how to get a range of trainnos to set as limits
	
	Train t=TrainDAO.findTrain(trainno);
	if(t.getTrainNo()==0){
		response.getWriter().append("Invalid train number.");
		RequestDispatcher rd=request.getRequestDispatcher("Train.html");
		rd.include(request, response);
	}
	session.setAttribute("train",t);
	session.setAttribute("counter", 100);
	response.getWriter().append("<p>Select a train:</p>");
	response.getWriter().append("<form action='Ticket.jsp' method='Get'>");
	response.getWriter().append("<select name='sTrainNo'><option value='"+t.getTrainNo()+"'>"+t.getTrainName()+"</option></select>");
	response.getWriter().append("<input type='Submit' value='Select'>");
	response.getWriter().append("</form>");
	RequestDispatcher rd=request.getRequestDispatcher("Train.html");
	rd.include(request, response);
}
%>
</body>
</html>