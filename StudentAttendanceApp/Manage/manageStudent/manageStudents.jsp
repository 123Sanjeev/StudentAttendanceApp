<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta charset="ISO-8859-1">
<title>Manage Student</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x"
	crossorigin="anonymous">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	
		<%@include file="../../navbar.jsp" %>
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
input {
	width: 150px;
	text-align: center;
}


#resultData tr:nth-child(even){
	background-color:white;
}

#resultData tr  td{
	text-align:center;
}

</style>
<body onload ="getSessionDetails('http://192.168.0.173:8081/StudentAttendanceApp/sessionMgmt?userid=', '100001')">

	<%
	response.setHeader("Set-Cookie", response.getHeader("Set-Cookie") + ";SameSite=strict");
	
	if(session.getId() == null){
		session.setAttribute("ERR", "Invalid user access");
		String site = new String("../Login_Admin_app/Login.jsp");
		response.setStatus(response.SC_MOVED_TEMPORARILY);
		response.setHeader("Location", site);
	}
	

	
	if (session.getAttribute("USERID") == null) {
		session.setAttribute("ERR", "Invalid user access");
		String site = new String("../Login_Admin_app/Login.jsp");
		response.setStatus(response.SC_MOVED_TEMPORARILY);
		response.setHeader("Location", site);
	}
	%>

	<%@page import="java.sql.*"%>
	<%

	%>


	<!-- <nav
		class="nav navbar-expand-lg navbar-dark bg-dark justify-content-center">
		<ul class="nav">
			<li class="nav-item">
				<div>
					<h2>
						<a class="navbar-brand" href="#"
							onclick="javascript:window.location.href='http://192.168.0.173:8081/StudentAttendanceApp/Home_page/Home.jsp'"
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
				"<li class='nav-item'><a class='nav-link' href='#' onclick='javascript:window.location.href=`http://192.168.0.173:8081/StudentAttendanceApp/Profile/Profile.jsp`'><p title="
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
				"<li class='nav-item'><a class='nav-link' href='#' onclick='javascript:window.location.href=`http://192.168.0.173:8081/StudentAttendanceApp/Login_Admin_app/Login.jsp`' class='active'>Login</a></li>");
			} else {
				out.print("<li class='nav-item'><a class='nav-link' href='http://192.168.0.173:8081/StudentAttendanceApp/Logout.jsp' class='active'>Logout</a></li>");
			}
			%>
		</ul>
	</nav>  -->
	<main class="container-fluid bg-light" id="rdata">
		<div class="d-flex flex-row" style="height: 90vh; width: 100%;">
			<div class="d-flex flex-colmun"
				style="width: 200px; height: 90vh; outline: 1">
				<ul class="list-group" style="height: 90vh; outline: 1">
					<li class="list-group-item">Manage Student</li>
				</ul>
			</div>
			<div class="d-flex align-center flex-column"
				style="width: 100%; height: 90vh;">
				<table class="table" id="search" style="outline: 1">
					<thead>
						<tr>
							<th scope="col">Student Id</th>
							<th scope="col">First Name</th>
							<th scope="col">Last Name</th>
							<th scope="col">Date of Admission</th>
							<th scope="col">Class</th>
							<th scope="col">Date of Birth</th>
							<th scope="col">Section</th>
							<th scope="col"></th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td scope="row"><input type="text" id="userid" placeholder="Enter Student id" /></td>
							<td scope="row"><input type="text" placeholder="Enter First Name" /></td>
							<td scope="row"><input type="text" placeholder="Enter Last Name" /></td>
							<td scope="row"><input type="date" placeholder="Enter Date of Admission" /></td>
							<td scope="row"><input type="text" placeholder="Enter class" /></td>
							<td scope="row"><input type="date" placeholder="Enter Date of Birth" /></td>
							<td scope="row"><input type="text" placeholder="Enter Section" /></td>
						</tr>
						<%
							/*	*/
						%>
						
						
					</tbody>
				</table>
				
				<table id="resultData" class="table">
				
				</table>
				
				<button class="btn-primary btn" style="display:none" onclick="updateUser()">Save Record</button>
			</div>
		</div>
	</main>
</body>
<script src="../asyncjs/async.js"></script>
<script type="text/javascript">
	var inputs = document.getElementsByTagName("input");
		for(input of inputs){
			 input.disabled = false;
		}
		var element;
		function makeEditable(ele){
			var tr = ele.parentElement.parentElement;
			var inputs = tr.getElementsByTagName('input')
			for(input of inputs){
				input.disabled = false;
			}
		}
</script>


</html>