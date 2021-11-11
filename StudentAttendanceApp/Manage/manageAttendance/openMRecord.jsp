<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<style>
#target {
	width: 100%;
	height: 80vh;
	overflow: hidden;
	overflow-y: scroll;
}
#atndata thead{
	width:100%;
	text-align:center;
	background:darkblue;
	color:white;
}
#atndata tbody tr td input{
	text-align:center;
}
</style>
<body>
	<table class="table" id="atndata">
		<thead>
			<tr>
				<th>Student Name </th>
				<th>class</th>
				<th>Section</th>
				<th>Attendance Date</th>
				<th>Attendance</th>
			</tr>

		</thead>


		<tbody>
			<%@page import="com.search.updateUser.*"%>
			<%@page import="java.util.*"%>

			<%
			List<String> attendanceRecord = new ArrayList<String>();
			String val = request.getParameter("recordid");
			attendanceRecord = searchUser.openrecord(request, response, val);
			for (String atrec : attendanceRecord) {
				out.println(atrec);
			}
			%>

		</tbody>
	</table>

</body>
</html>