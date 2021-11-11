<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Admin Protal</title>
</head>
<body>

<main>
	<div id="peopledata">
	<%@page import="java.sql.*" %>
		<%
		
		String id = request.getParameter("recordid");
		Class.forName("com.mysql.jdbc.Driver");
		
		Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.0.173:3306/Studentmangementsystem", "sanjeev","sanjeev@123");
		PreparedStatement ps = conn.prepareStatement("select * from studentlogin where std_id = '"+id+"'");
		ResultSet rs = ps.executeQuery();
		while(rs.next()){
			out.print("<div class='container text-center d-flex flex-column justify-content-left align-center'> <label for='userid'>User Id: </label><input name='userid' type='text' class='form-input' value='"
					+rs.getString(2)+"' disabled /><label for='firstname'>First Name: </label><input name='firstname' type='text' class='form-input' value='"
					+rs.getString(3)+"' disabled /><label for='lastname'>Last Name: </label><input name='lastname' type='text' class='form-input' value='"
					+rs.getString(4)+"' disabled /><label for='currClass'>Current Class: </label><input name='currClass' type='text' class='form-input' value='"
					+rs.getString(8)+"' disabled /></div>");
		}			
		%>
	</div>
</main>


</body>
</html>