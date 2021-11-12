<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Application Designer</title>
</head>
<body>
<nav>
	<%@include file="../navbar.jsp" %>
</nav>
	<form action="../createNewApp" method="POST">
	<input type="hidden" name="u_lg" value="<% out.print(session.getAttribute("USERID"));%>"/>
		<input type="hidden" name="appId" value="applicationDesigner" />
		<label for="APP_name"> Application name</label> <input type="text"
			name="APP_name" /> <label for="APP_name"> Application title</label>
		<input type="text" name="APP_title" />
		<select name='module'>
		<option value="">Select Module</option>
		
		<%@page import="java.sql.*" %>
		<%@page import="StudentLogin.connectionDBPool" %>
		<%
			try(Connection con = new connectionDBPool().dbpoolConnection()){
				String sql = "select distinct module from optionmenu";
				PreparedStatement ps = con.prepareStatement(sql);
				ResultSet rs = ps.executeQuery();
				while(rs.next()){
					out.print("<option value='"+rs.getString(1)+"'>"+rs.getString(1)+"</option>");
				}
			}catch(Exception e){
				e.printStackTrace();
			}
		%>
		</select>	
		
		<button type="submit">Create application</button>
	</form>

</body>
</html>