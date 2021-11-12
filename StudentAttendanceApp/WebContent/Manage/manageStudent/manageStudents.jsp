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

<%@include file="../../navbar.jsp"%>
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

.resultData tr:nth-child(even) {
	background-color: white;
}
.resultData tbody tr td{
  font-size:15px;  
  text-align: center;
}

body{
  counter-reset: c;
}
.resultData tbody tr td a::before{
  counter-increment: c;
  content: counter(c)".";
  padding: 5px;
  float:left;
  
}
.resultData tbody tr td a:first-child{
  text-decoration: underline;
  text-decoration-color: blue;
}


.main {
	width: 100%;
	height: 90vh;
	display: flex;
	flex-direction: row;
	justify-content: space-evenly;
	align-items: center;
}

.datasec {
	display: flex;
	flex-direction: column;
	align-items: left;
	margin-left: 170px !important;
	overflow: scroll;
	border: 1px solid black;
	outline: 1;
	margin-left: 176px
}
</style>
<body
	onload="getSessionDetails('http://192.168.0.173:8081/StudentAttendanceApp/sessionMgmt?userid=', '100001')">

	<%
	response.setHeader("Set-Cookie", response.getHeader("Set-Cookie") + ";SameSite=strict");

	if (session.getId() == null) {
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
	<main class="container-fluid bg-light" id="rdata">
		<div class="main">
			<div style="width: 150px;">
				<%@include file="../../Modules/applications_list.jsp"%>
			</div>

			<div class="d-flex align-center flex-column datasec"
				style="width: 100%; height: 90vh;">
				<table class="table resultData" id="search" style="outline: 1">
					<thead>
						<tr>
							<th scope="col">Student Id: </br> <input type="text" id="userid"
								placeholder="Enter Student id" /></th>
							<th scope="col">First Name: </br><input type="text"
								placeholder="Enter First Name" /></th>
							<th scope="col">Last Name: </br><input type="text"
								placeholder="Enter Last Name" /></th>
							<th scope="col">Date of Admission: </br><input type="date"
								placeholder="Enter Date of Admission" /></th>
							<th scope="col">Class: </br> <input type="text" placeholder="Enter class" /></th>
							<th scope="col">Date of Birth: </br><input type="date"
								placeholder="Enter Date of Birth" /> </th>
							<th scope="col">Section: </br> <input type="text"
								placeholder="Enter Section" /></th>
						</tr>
					</thead>
					<tbody>
					</tbody>
				</table>

				<table id="resultData" class="table">

				</table>

				<button class="btn-primary btn" style="display: none"
					onclick="updateUser()">Save Record</button>
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