<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<style>
#result{
	width:100%;
	height:90vh;
	overflow-y: scroll;
	
}

</style>

<%
	String token = request.getParameter("token");

	if(token==null){
		response.sendRedirect("http::/192.168.0.173:8080/StudentAttendanceApp/Manage/class_Attendance/attendance.jsp");
	}
	else {
		out.print("<body onload='loadPage(`checkAttendance`,`Check Attendance `)'>");
	}
%>

<body onload="loadContent()">
	<%@page import="java.sql.*"%>
	<%@page import="java.util.ArrayList" %>
	<%
	Connection conn = null;
	Connection conn2 = null;
	PreparedStatement ps = null;
	PreparedStatement ps2 = null;
	String formValue= request.getParameter("selectClasss");
	String Driver = "com.mysql.jdbc.Driver";
	final String username = "sanjeev";
	final String password = "sanjeev@123";
	Class.forName(Driver);
	conn = DriverManager.getConnection("jdbc:mysql://192.168.0.173:3306/studentmangementsystem", username, password);
	ps = conn.prepareStatement("select id, curclass from class");
	ResultSet rs2 = null;
	if(formValue != null){
		String v = request.getParameter("selectedvalue");
		ps2 = conn.prepareStatement("select section from sections where classId='"+v+"'");
		rs2 = ps2.executeQuery();
		out.print(v);
	}
	
	
	
	ResultSet rs = ps.executeQuery();
	%>
	<div class="pageLoader input-group d-flex flex-row" id="checkStudent">
			<select class="form-select form- select-md m-1" onchange="loadContent(this.value)"  id="selectthis">
				<option selected>Select class</option>
				<%
				while (rs.next()) {
					out.print("<option value='" + rs.getString(1) + "'> Class " + rs.getString(2) + "</option>");
				}
				%>
		</select> <select class="form-select form-select-md m-1" id="select1" onchange="showData(this.value)">
			<option selected>Select Section</option>
		</select>
	</div>
	<div id="result"></div>
</body>
</html>































</html>