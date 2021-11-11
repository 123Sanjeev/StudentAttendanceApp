<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Database Configuration</title>
</head>
<%@include file="../navbar.jsp"%>
<body>

	<%@page import="java.sql.*"%>
	<%@page import="StudentLogin.connectionDBPool"%>
	<%
	try (Connection conn = new connectionDBPool().dbpoolConnection()) {
		PreparedStatement ps = conn.prepareStatement("select table_name from information_schema.tables");
		ResultSet rs = ps.executeQuery();
		while (rs.next()) {
			out.print("<a href='javascript:void(0)' onclick='openDbrecord(this.textContent)' >" + rs.getString(1)
			+ "</a> </br>");
		}
	} catch (Exception e) {
		e.printStackTrace();
	}
	%>

	<table class="table">
		<thead>
			<tr>
				<th>Database name</th>
				<th>Database schema</th>
				<th>Database column name</th>
			</tr>
		</thead>
		<tbody id="res">
		</tbody>
	</table>
</body>
<script>
function openDbrecord(dbname){
	var xhr = new XMLHttpRequest();
	    xhr.open("GET","http://192.168.0.173:8081/StudentAttendanceApp/createNewApp?appId=DatabaseConfig&dbname="+dbname, true);
	    xhr.onload = ()=>{
	    if(xhr.status === 200 && xhr.readyState === 4){
	      document.getElementById("res").innerHTML = xhr.responseText;
	    }
	  }
	xhr.send();
	}
</script>
</html>