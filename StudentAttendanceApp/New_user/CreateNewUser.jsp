<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Create New User</title>
</head>
<body>
<%@ page import="java.sql.*" %>
<%

	String uid = "";
	Connection conn = null;
	PreparedStatement ps = null;
	try{
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection("jdbc:mysql://192.168.0.173:3306/studentmangementsystem","sanjeev","sanjeev@123");
		ps = conn.prepareStatement("select std_id + '1' from studentlogin where id = (select max(id) from studentlogin)");
		ResultSet rs = ps.executeQuery();
		while(rs.next()){
			uid = rs.getString(1);
		}
	}catch(Exception e){
		out.print(e);
	}
%>

<% out.print(uid); %>
<%@ include file="../navbar.jsp" %>
	<div>
		<div>
		<div class="msg">
			<p><% if(session.getAttribute("sentdata")!= null){
						out.print("<script>alert('"+session.getAttribute("sentdata")+"');</script>");
					}
				%>
			
		</div>
			<form action="newuserJSP.jsp" method="post" >
				<label for="userid">User Id <span style="color:orange"> * </span></label> 
				<input type="text" value='<% out.print(uid); %>' name="ud" id="UID" required />
				<label for="Firstname">First name <span style="color:orange"> * </span></label>
				<input type="text" placeholder="User Name" name="firstname" id="UNAME" required/>
				<label for="Last name">Last name <span style="color:orange"> * </span></label>
				<input type="text" placeholder="User Name" name="Lastname" id="UNAME" required/>
				<label for="DOB">Date of Birth <span style="color:orange"> * </span></label>
				<input type="date" placeholder="DOB" name="DOB" title="Date of birth" id="DOB" />
				<button type="submit">Create User</button>
				<button id="SaveRecord" >Save</button>
				<input type="hidden" id="password" name="pass" />
				
			</form>
		</div>
	</div>
<script src="../script/CreateUser.js"></script>
</body>
</html>