<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Reset Password</title>
</head>
<body>
	<%@page import="java.sql.*" %>
	<%
		String pass = request.getParameter("c_pass"); 
		String id = request.getParameter("u_id");
		Connection c = null;
		PreparedStatement p = null;
		try{
			Class.forName("com.mysql.jdbc.Driver");
			c = DriverManager.getConnection("jdbc:mysql://192.168.0.173:3306/loginportal","sanjeev","sanjeev@123");
			p = c.prepareStatement("update userdb set USER_Pass='"+pass+"' where user_id = '"+id+"'");
			int res =	p.executeUpdate();
			if(res == 1){
				String site = new String("http://192.168.0.173:8080/StudentAttendanceApp/");
				response.setStatus(response.SC_MOVED_TEMPORARILY);
				response.setHeader("Location", site);
			}
			System.out.print(res);
		}catch(Exception e){
			e.printStackTrace();
		}
	
	%>




	<form action="reset_.jsp" method=post id="f">
		<p>Current user</p>
		<input id="u_id" type="text" name="u_id" />

		<p>
			New Password <span style="color: red">*</span>
		</p>
		<input type="password" id="pass" name="pass"
			placeholder="New Password" />
		<p>
			Confirm password <span style="color: red">*</span>
		</p>
		<input type="password" id="c_pass" name="c_pass"
			placeholder="Confirm Password" />
		<button onclick='checkPass()' type="button">Reset Password</button>
	</form>

</body>
<script>
	var u = window.location.href;
	var urlTrim = u.split("=");
	var id = parseInt(urlTrim[1]);
	var uid = document.getElementById("u_id");
	uid.value = id;

	console.log(uid.value);
	var passList = [ document.getElementById("pass"),
			document.getElementById("c_pass") ];
	function checkPass() {
		if (passList[0].value.length < 8) {
			alert("Password length cannot be less than 8");
		} else {
			checkForVal();
		}
	}

	function checkForVal() {
		if (passList[0].value === passList[1].value) {
			document.getElementById("f").submit();
		} else {
			alert("Password does not matches");
		}
	}
</script>
</html>