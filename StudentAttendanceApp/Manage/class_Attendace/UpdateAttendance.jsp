<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
</head>
<%
	String token = request.getParameter("token");

	if(token==null){
		response.sendRedirect("http::/192.168.0.173:8080/StudentAttendanceApp/Manage/class_Attendance/attendance.jsp");
	}
	else {
		out.print("<body onload='loadPage(`UpdateAttedance`,`Update Attendance`)'>");
	}
%>
	<div class="container">
		<center>
			<div class="bg-light">
				<h1>Update Attendance portal.</h1>
				<hr>
			</div>
		</center>
		<table class="table" id="searchCls">
			<thead>
				<tr>
					<th>Class </br> <input type="text" class="updtStudent" /></th>
					<th>Attendance Date </br> <input type="text" class="updtStudent" /></th>
					<th>Section </br> <input type="text" class="updtStudent" /></th>
				</tr>
			</thead>
		</table>
	</div>
</body>
</html>