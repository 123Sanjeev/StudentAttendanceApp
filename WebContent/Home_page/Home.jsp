<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Dash board</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x"
	crossorigin="anonymous">

<%@include file="../navbar.jsp"%>

</head>
<style>
* {
	margin: 0px;
	padding: 0px;
	box-sizing: border-box;
}

.toolbar {
	width: 200px;
	height: 90vh;
	outline: auto;
}

.nav {
	display: flex;
	flex-direction: row;
	justify-content: center;
	align-items: center;
}

.nav li a {
	color: white !important;
}

a {
	color: black;
	text-decoration: none;
	font-style: calibri;
}

.userdetails {
	outline: 1;
	overflow: auto;
	height: 80vh;
}

thead {
	width: 100%;
}

th {
	border: 1px solid black;
	padding: 5px;
}

td a {
	color: black !important;
	text-decoration: none;
	text-align: center;
}

td {
	border: 1px solid black;
	padding: 5px;
}
</style>

<%@page import="java.sql.*"%>
<%
int CountAdmin = 0;
int countStudent = 0;
String userId = null;
String fullName = null;
Connection conn = null;
Connection conn2 = null;
PreparedStatement ps = null;
PreparedStatement ps2 = null;
Class.forName("com.mysql.jdbc.Driver");
conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/loginportal", "sanjeev", "sanjeev@123");
conn2 = DriverManager.getConnection("jdbc:mysql://localhost:3306/studentmangementsystem", "sanjeev", "sanjeev@123");
ps = conn.prepareStatement("select count(*) from userdb");
ps2 = conn2.prepareStatement("select count(*) from studentlogin");
PreparedStatement p = conn2.prepareStatement(
		"select std_id, concat(firstname,' ',lastname)as student_name,if(attendance_status = 0, 0 , count(std_id)) as attendance_count  from studentlogin inner join attendance on std_id = studentid  group by std_id order by attendance_count desc");
ResultSet rs3 = p.executeQuery();
ResultSet rs2 = ps2.executeQuery();
ResultSet rs = ps.executeQuery();
%>
<body>
	<%
	response.setHeader("Set-Cookie", response.getHeader("Set-Cookie") + ";SameSite=strict");
	if (session.getAttribute("USERID") == null) {
		session.setAttribute("ERR", "Invalid user access");
		String site = new String("../Login_Admin_app/Login.jsp");
		response.setStatus(response.SC_MOVED_TEMPORARILY);
		response.setHeader("Location", site);
	}
	%>


	<!--<nav class="nav navbar-expand-lg navbar-dark bg-dark justify-content-center"> 
		<ul class="nav">
			<li class="nav-item">
				<div>
					<h2>
						<a class="navbar-brand" href="#"
							onclick="javascript:window.location.href='http://localhost:8080/StudentAttendanceApp/Home_page/Home.jsp'"
							title="LOGO">SMA</a>
					</h2>
				</div>
			</li>
			<li class="nav-item"><a class="nav-link active" href="#"
				onclick="javascript:window.location.href='http://localhost:8080/StudentAttendanceApp/Home_page/Home.jsp'">Home</a></li>
			<li class="nav-item">
		if (session.getAttribute("USERTYPE").equals("Admin") || session.getAttribute("USERTYPE").equals("Teacher/Ad")) {
	out.print(
			"<a class='nav-link' href='#' onclick='javascript:window.location.href=`http://localhost:8080/StudentAttendanceApp/New_user/CreateNewUser.jsp`'>CreateNew User</a>");
}				%>
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
	if (session.getAttribute("USERNAME") != null) {
					out.print(
							"<li class='nav-item'><a class='nav-link' href='#' onclick='javascript:window.location.href=`http://localhost:8080/StudentAttendanceApp/Profile/Profile.jsp`'><p title="
									+ session.getAttribute("USERNAME") + ">" + session.getAttribute("USERNAME") + "/"
									+ session.getAttribute("USERTYPE") + "</p></a></li>");
				}

				if (session.getAttribute("USERNAME") == null) {
					out.print(
							"<li class='nav-item'><a class='nav-link' href='#' onclick='javascript:window.location.href=`http://localhost:8080/StudentAttendanceApp/Login_Admin_app/Login.jsp`' class='active'>Login</a></li>");
				} else {
					out.print(
							"<li class='nav-item'><a class='nav-link' href='../Logout.jsp' class='active'>Logout</a></li>");
				}
			%>
		</ul>
	</nav> -->

	<main class="container-fluid d-flex flex-row ">

		<div class="toolbar d-flex flex-column" id="tab">
			<h4 class="list-group-item text-center bg-success text-white">Content</h4>
			<ul class="list-group">
				<li class="list-group-item"><a href="../Manage/Mange_Class.jsp">Schedule
						Class</a></li>
				<li class="list-group-item"><a
					href="../Manage/class_Attendace/attendance.jsp">Attendance</a></li>
				<li class="list-group-item"><a
					href="../Manage/manageStudent/manageStudents.jsp">Manage
						Students</a></li>
				<li class="list-group-item"><a
					href="../SearchRec/StudentRec.jsp">Search Students</a></li>
				<li class="list-group-item"><a
					href="http://localhost:8081/StudentAttendanceApp/Req/Request.jsp">Student Requests</a></li>
			</ul>
		</div>

		<div id="dashboard" style="width: 100%; outline: 1; height: 90vh;"
			class="dashboard">
			<h4 style="width: 100%" class="bg-success list-group-item text-white">
				Dashboard</h4>

			<div class="d-flex flex-row">
				<div>
					<div class="bg-success"
						style="width: 250px; margin-right: 2.5px; margin-left: 2.5px; height: 150px;"
						id="Total Student">
						<p
							class="text-white text-center d-flex align-center  flex-column justify-content-center"
							style="font-size: 22px; height: 40px;">
							Total Admin count:
							<%
						while (rs.next()) {
							CountAdmin = rs.getInt(1);
						}
						out.print(CountAdmin);
						%>
						</p>
						<hr class="text-white">
						<p
							class="text-white text-center d-flex align-center  flex-column justify-content-center"
							style="font-size: 22px; height: 40px;">
							Total Student count:
							<%
						while (rs2.next()) {
							countStudent = rs2.getInt(1);
						}
						out.print(countStudent);
						%>
						
						<hr class="text-white">
					</div>
					<div class="bg-danger m-1">
						<h5 class="text-white bg-dark text-center p-2">Admin users</h5>

						<table class="table">
							<thead>
								<tr>
									<th>User id</th>
									<th>User Name</th>

								</tr>
							</thead>
							<tbody>
								<%
								PreparedStatement p1 = conn.prepareStatement("select user_id, first_name, last_name from userdb");
								ResultSet a = p1.executeQuery();
								while (a.next()) {
									out.print("<tr><td>" + a.getString(1) + "</td><td>" + a.getString(2) + " " + a.getString(3) + "</td></tr>");
								}
								%>
							</tbody>

						</table>
					</div>
				</div>
				<div style="width: 100%">
					<div class="userdetails">
						<table class="table">
							<thead>
								<tr>
									<th scope="col" class="text-center">User Id</th>
									<th scope="col" class="text-center">User Name</th>
									<th>Attendance Count</th>
								</tr>
							</thead>
							<tbody>
								<%
								while (rs3.next()) {
									userId = rs3.getString(1);
									fullName = rs3.getString(2);
									int count = rs3.getInt(3);
									if (count > 10) {
										out.print("<tr><td style='background-color:green; '><a href='#' style='color:white!important;'>" + userId
										+ " </a></td> <td><a href='#'>" + fullName + " </a></td></td><td>" + rs3.getInt(3) + "</td></tr>");
									} else if (count == 0) {
										out.print("<tr><td style='background-color:red; '><a href='#' style='color:white!important;'>" + userId
										+ " </a></td> <td><a href='#'>" + fullName + " </a></td></td><td>" + rs3.getInt(3) + "</td></tr>");
									} else {
										out.print("<tr><td><a href='#'>" + userId + " </a></td> <td><a href='#'>" + fullName + " </a></td></td><td>"
										+ rs3.getInt(3) + "</td></tr>");
									}

									//out.print("<tr><td><a href='#'>" + userId + " </a></td> <td><a href='#'>" + fullName + " </a></td></td><td>"+rs3.getInt(3)+"</td></tr>");
								}
								%>
							</tbody>
						</table>
					</div>
				</div>
			</div>

		</div>

	</main>

</body>
</html>
