<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Student zone</title>
</head>
<body>
	<%@include file="../navbar.jsp" %>
	<%@page import="java.sql.*"%>
	<%
	Connection conn;
	PreparedStatement ps;
	ResultSet rs;
	try {
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection("jdbc:mysql://192.168.0.173/fileSystem", "sanjeev", "sanjeev@123");
		ps = conn.prepareStatement("select * from file_storage");
		rs = ps.executeQuery();
		while (rs.next()) {
			String file_Name = rs.getString(2);
			String path_name = rs.getString(3);
	%>
	<div>
		<a href="<%out.print(path_name + file_Name);%>" download> <%
 out.print(file_Name);
 %></a>
		<%
		out.print(path_name + " " + rs.getInt(4) + " " + rs.getDate(5));
		%>

	</div>

	<%
	}
	} catch (Exception e) {
	out.print(e);
	}
	%>


	<h1 align="center">Student Zone</h1>
	<hr>

</body>
</html>