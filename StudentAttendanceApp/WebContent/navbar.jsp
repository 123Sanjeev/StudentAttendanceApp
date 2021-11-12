<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta charset="ISO-8859-1">
</head>
<!--  <link rel="stylesheet" href="../Style/Login.css"> -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x"
	crossorigin="anonymous">

<link rel="icon" type="image/png"
	href="http://192.168.0.173:8081/StudentAttendanceApp/favicon.png"
	sizes="192x192">
<style>
.nav {
	display: flex;
	flex-direction: row;
	justify-content: center;
	align-items: center;
}

.nav li a {
	color: white !important;
}
</style>
<body>



	<%@page import="java.sql.*"%>
	<%@page import="StudentLogin.connectionDBPool"%>


	<%
	if (session.getAttribute("VALID_CHECK") == null) {
		response.sendRedirect("http://192.168.0.173:8081/StudentAttendanceApp/Logout.jsp");
	} else {
		//out.print(session.getId());
		String userid = null;
		try (Connection poolConn = new connectionDBPool().dbpoolConnection()) {
			//Class.forName("com.mysql.jdbc.Driver");
			//Connection conn3 = DriverManager.getConnection("jdbc:mysql://192.168.0.173:3306/studentmangementsystem", "sanjeev",
			//"sanjeev@123");
			PreparedStatement ps3 = poolConn
			.prepareStatement("select * from logintrack where usessionid = '" + session.getId() + "' ");
			ResultSet rs4 = ps3.executeQuery();

			if (rs4.next() == false) {
			out.print("<script> alert('invalid session logging user out')</script>");
			response.setStatus(response.SC_MOVED_TEMPORARILY);
			response.setHeader("Location", "http://192.168.0.173:8081/StudentAttendanceApp/Logout.jsp");
			}
			while (rs4.next()) {
		userid = rs4.getString(2);

		int uservalue = (Integer) session.getAttribute("USERID");

		System.out.println(uservalue == Integer.parseInt(userid));

		if (Integer.parseInt(userid) == uservalue) {
			out.print("<script> alert('valid session')</script>");
		} else {
			out.print("<script> alert('in-valid session')</script>");
			response.setStatus(response.SC_MOVED_TEMPORARILY);
			response.setHeader("Location", "http://192.168.0.173:8081/StudentAttendanceApp/Logout.jsp");
		}
			}
		} catch (Exception e) {
			e.printStackTrace();

		}
	%>
	<nav
		class="nav navbar-expand-lg navbar-dark bg-dark justify-content-center">
		<ul class="nav">
			<li class="nav-item">
				<div>
					<h2>
						<a class="navbar-brand" href="#"
							onclick='javascript:window.location.href=`<% 
							if(session.getAttribute("USERTYPE").equals("Student")) {
								out.print("http://192.168.0.173:8081/StudentAttendanceApp/Home_page/StudentFrame.jsp]"); 
							}else{
								out.print("http://192.168.0.173:8081/StudentAttendanceApp/Home_page/Home.jsp");
							}
						%>
						 `';
							title="LOGO">SMA</a>
					</h2>
				</div>
			</li>
			<li class="nav-item"><a class="nav-link active" href="#"
				onclick="javascript:window.location.href='http://192.168.0.173:8081/StudentAttendanceApp/Home_page/Home.jsp'">Home</a></li>
			<li class="nav-item">
				<%
				if (session.getAttribute("USERTYPE").equals("Admin") || session.getAttribute("USERTYPE").equals("Teacher/Ad")) {
					out.print(
					"<a class='nav-link' href='#' onclick='javascript:window.location.href=`http://192.168.0.173:8081/StudentAttendanceApp/New_user/CreateNewUser.jsp`'>CreateNew User</a>");
				}
				%>
			</li>
			<li class="nav-item">
				<form method="get" id="f">
					<a class="nav-link" href="../Reports/report.jsp" target="_blank"
						name="runreport" onclick="sentFormSubmit()">Reports</a>
				</form> <script>
					function sentFormSubmit() {
						document.getElementById("f").submit();
					}
				</script>
			</li>
			<%
			if (session.getAttribute("USERNAME") != null) {
				out.print(
				"<li class='nav-item'><a class='nav-link' href='#' onclick='javascript:window.location.href=`http://192.168.0.173:8081/StudentAttendanceApp/Profile/Profile.jsp`'><p title="
						+ session.getAttribute("USERNAME") + ">" + session.getAttribute("USERNAME") + "/"
						+ session.getAttribute("USERTYPE") + "</p></a></li>");
			}

			if (session.getAttribute("USERNAME") == null) {
				out.print(
				"<li class='nav-item'><a class='nav-link' href='#' onclick='javascript:window.location.href=`http://192.168.0.173:8081/StudentAttendanceApp/Login_Admin_app/Login.jsp`' class='active'>Login</a></li>");
			} else {
				out.print(
				"<li class='nav-item'><a class='nav-link' href='http://192.168.0.173:8081/StudentAttendanceApp/Logout.jsp' class='active'>Logout</a></li>");
			}
			}
			%>
		</ul>
	</nav>
</body>
</html>