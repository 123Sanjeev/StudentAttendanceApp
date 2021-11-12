<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Manage Attendance</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x"
	crossorigin="anonymous">
</head>
<style>
* {
	margin: 0px;
	padding: 0px;
	box-sizing: border-box;
}

.nav li a {
	color: white !important;
}

.applicationList p {
	cursor: pointer;
	transition: all 0.3s ease;
}

.applicationList p:hover {
	color: black !important;
	background-color: white !important;
	transition: all 0.3s ease;
}

.checkStudent {
	display: none;
}
</style>
<body>

	<%
	if (session.getAttribute("USERID") == null) {
		session.setAttribute("ERR", "Invalid user access");
		String site = new String("http://192.168.0.173:8081/StudentAttendanceApp/Logout.jsp");
		response.setStatus(response.SC_MOVED_TEMPORARILY);
		response.setHeader("Location", site);
	} else {
	%>


	<nav
		class="nav navbar-expand-lg navbar-dark bg-dark justify-content-center">
		<ul class="nav">
			<li class="nav-item">
				<div>
					<h2>
						<a class="navbar-brand" href="#"
							onclick="javascript:window.location.href='http://192.168.0.173:8080/StudentAttendanceApp/Home_page/Home.jsp'"
							title="LOGO">SMA</a>
					</h2>
				</div>
			</li>
			<li class="nav-item"><a class="nav-link active" href="#"
				onclick="javascript:window.location.href='http://192.168.0.173:8080/StudentAttendanceApp/Home_page/Home.jsp'">Home</a></li>
			<li class="nav-item">
				<%
				if (session.getAttribute("USERTYPE").equals("Admin") || session.getAttribute("USERTYPE").equals("Teacher/Ad")) {
					out.print(
					"<a class='nav-link' href='#' onclick='javascript:window.location.href=`http://192.168.0.173:8080/StudentAttendanceApp/New_user/CreateNewUser.jsp`'>CreateNew User</a>");
				} else {
					session.setAttribute("ERR", "Invalid user access");
					String site = new String("../Login_Admin_app/Login.jsp");
					response.setStatus(response.SC_MOVED_TEMPORARILY);
					response.setHeader("Location", site);
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
				"<li class='nav-item'><a class='nav-link' href='#' onclick='javascript:window.location.href=`http://192.168.0.173:8080/StudentAttendanceApp/Profile/Profile.jsp`'><p title="
						+ session.getAttribute("USERNAME") + ">" + session.getAttribute("USERNAME") + "/"
						+ session.getAttribute("USERTYPE") + "</p></a></li>");
			} else {
				session.setAttribute("ERR", "Invalid user access");
				String site = new String("../Login_Admin_app/Login.jsp");
				response.setStatus(response.SC_MOVED_TEMPORARILY);
				response.setHeader("Location", site);
			}
			if (session.getAttribute("USERNAME") == null) {
				out.print(
				"<li class='nav-item'><a class='nav-link' href='#' onclick='javascript:window.location.href=`http://192.168.0.173:8080/StudentAttendanceApp/Login_Admin_app/Login.jsp`' class='active'>Login</a></li>");
			} else {
				out.print("<li class='nav-item'><a class='nav-link' href='../Logout.jsp' class='active'>Logout</a></li>");
			}
			}
			%>
		</ul>
	</nav>

	<main class="container-fluid d-flex flex-row">
		<div class=" text-white bg-dark applicationList"
			style="width: 250px; height: 90vh; outline: 1">
			<p
				class="list-group-item text-center text-white bg-dark border border-white">Applications</p>
			<p
				class="list-group-item text-center text-white bg-dark border border-white font-weight-light "
				onclick="loadPage('checkAttendance', 'Check Attendance')">Check
				Attendance</p>

			<p
				class="list-group-item text-center text-white bg-dark border border-white font-weight-light"
				onclick="loadPage('markAttendance', 'Mark Attendance')">Mark
				Attendance</p>

			<p
				class="list-group-item text-center text-white bg-dark border border-white font-weight-light"
				onclick="loadPage('UpdateAttendance', 'Update Attendance')">Update
				Attendance</p>

			<p
				class="list-group-item text-center text-white bg-dark border border-white font-weight-light"
				onclick="loadPage('calculateAvgAttendace','Calculate Average Attendance' )">Calculate
				Average Attendance</p>
		</div>
		<div class="bg-light text-dark"
			style="width: 100%; height: 90vh; outline: 1" id="target"></div>
	</main>
</body>
<script src="../asyncjs/async.js"></script>
<script src="../asyncjs/updateAttendance.js"></script>
<script
	src="http://192.168.0.173:8080/StudentAttendanceApp/script/checkAttendance.js"></script>
</html>