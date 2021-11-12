<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Dashboard</title>
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

.toolbar {
	width: 300px;
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

.drop-down {
	display: none;
	position: absolute;
	width: 200px;
	height:auto;
	left: 200px;
	top: 0px;
	z-index:100;
}

.drop-down li {
	width: 100% !important;
	
}

.parent {
	cursor: pointer;
}

.parent:after {
	content: ">";
	position: absolute;
	right: 0px;
	font-weight: bolder;
}

.parent:hover .drop-down {
	display: revert;
	cursor: pointer;
}

.parent:hover .parent:after {
	content: "<";
	position: absolute;
	right: 0px;
	font-weight: bolder;
}
</style>

<%@page import="java.sql.*"%>
<%@page import="StudentLogin.connectionDBPool"%>
<%@page import="java.util.*"%>
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
conn = DriverManager.getConnection("jdbc:mysql://192.168.0.173:3306/loginportal", "sanjeev", "sanjeev@123");
conn2 = DriverManager.getConnection("jdbc:mysql://192.168.0.173:3306/studentmangementsystem", "sanjeev", "sanjeev@123");
ps = conn.prepareStatement("select count(*) from userdb");
ps2 = conn2.prepareStatement("select count(*) from studentlogin");
PreparedStatement p = conn2.prepareStatement("select std_id , firstname, lastname from studentlogin");
ResultSet rs3 = p.executeQuery();
ResultSet rs2 = ps2.executeQuery();
ResultSet rs = ps.executeQuery();
%>
<body>
	<%
	if (session.getAttribute("USERID") == null) {
		session.setAttribute("ERR", "Invalid user access");
		String site = new String("../Login_Admin_app/Login.jsp");
		response.setStatus(response.SC_MOVED_TEMPORARILY);
		response.setHeader("Location", site);
	}
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
			}

			if (session.getAttribute("USERNAME") == null) {
				out.print(
				"<li class='nav-item'><a class='nav-link' href='#' onclick='javascript:window.location.href=`http://192.168.0.173:8080/StudentAttendanceApp/Login_Admin_app/Login.jsp`' class='active'>Login</a></li>");
			} else {
				out.print("<li class='nav-item'><a class='nav-link' href='../Logout.jsp' class='active'>Logout</a></li>");
			}
			%>
		</ul>
	</nav>

	<main class="container-fluid d-flex flex-row ">

		<%@include file="../Modules/applications_list.jsp" %>			

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

								conn.close();
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
								</tr>
							</thead>
							<tbody>
								<%
								while (rs3.next()) {
									userId = rs3.getString(1);
									fullName = rs3.getString(2) + " " + rs3.getString(3);
									out.print("<tr><td><a href='#'>" + userId + " </a></td> <td><a href='#'>" + fullName + " </a></td></tr>");
								}
								conn2.close();
								try {
									conn.close();
									conn2.close();
								} catch (Exception e) {
									e.printStackTrace();

								}
								%>
							</tbody>
						</table>
					</div>
				</div>
			</div>

		</div>

	</main>
	<%
	if (session.getAttribute("USERTYPE") == "Student") {
		//out.print("<iframe src='https://www.careadda.com' width='100%' height='400vh'></iframe>");
	} else {
		//out.print("<iframe src='http://192.168.0.173:8080/StudentAttendanceApp/Home_page/Home.jsp' width='100%' height='400vh' </iframe>");
	}
	%>

</body>

<script>
 var loadCount = 0;
 function runThis(){
 var xhr = new XMLHttpRequest();
		console.log("this is also triggerd");
		xhr.open("GET", "http://192.168.0.173:8081/StudentAttendanceApp/customModules");
		xhr.onload=()=>{
			if(xhr.status == 200 && xhr.readyState == 4){
				document.getElementById("menu").innerHTML = xhr.responseText;
			}else{
				console.error("Error exist in the application");
			}
		}
		xhr.send();
 }
</script>


</html>