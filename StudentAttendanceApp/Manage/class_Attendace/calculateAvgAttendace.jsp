<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>

<body>

	<%@page import="StudentLogin.connectionDBPool"%>
	<%@page import="java.sql.*"%>
	<%@page import="java.util.*" %>
	<%
	List<String> data = new ArrayList<String>();
	try {
		Connection conn = new connectionDBPool().dbpoolConnection();
		PreparedStatement ps = conn.prepareStatement("select curclass from class");
		ResultSet rs = ps.executeQuery();
		while (rs.next()) {
			data.add(rs.getString(1));
			
		}
	} catch (Exception e) {
		e.printStackTrace();
	}
	%>


<table class="table">
	<thead>
		<tr>
			<th>
				Class
			</th>
		</tr>
	</thead>
	
		
			<%
			out.print("<tbody><tr>");
				for(String className : data){
					out.print("<p onclick='openClassRecord(this.textContent)'>"+className+"</p>");
				}
				out.print("</tr></table>");
			%>
</table>

</body>
</html>