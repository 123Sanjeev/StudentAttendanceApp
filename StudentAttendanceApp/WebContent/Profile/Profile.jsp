<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Profile</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	<%@ include file="../navbar.jsp"%>
</head>
<style>
* {
	margin: 0px;
	padding: 0px;
	box-sizing: border-box;
}

.recentActivities {
	height: 300px;
	background-color: green;
	grid-area: recent;
}

.Introduction {
	height: 300px;
	background-color: red;
	grid-area: Intro;
}

.details {
	height: 635px;
	background-color: black;
	grid-area: details;
}

.dashboard {
	display: grid;
	grid-template-areas: 'Intro details details details details'
		'recent details details details details';
	grid-gap: 10px;
}

.dashboard>div {
	paddung: 10px;
	margin: 10px;
	border-radius: 10px;
	outline: none;
	cursor: pointer;
}

.userDetails {
	width: 100%;
	margin: 25px;
	padding: 10px;
}

.options {
	width: 100%;
	height: 40px;
	background-color: grey;
	color: white;
	border-top-left-radius: 10px;
	border-top-right-radius: 10px;
}

.options ul {
	width: 100%;
	display: flex;
	justify-content: right;
	align-items: center;
}

.setting {
	cursor: pointer;
}

.details table {
	width: 100%;
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
	text-align: center;
}

.details th {
	background: darkblue;
	padding: 10px;
	color: white;
	border: 1px inset blue;
	border-radius: 2px;
}

.details td, .details th {
	width: 300px;
	text-align: center;
	border: 1px inset blue;
}

.details td {
	padding: 10px;
}

.details tr:nth-child(even) {
	background-color: lightblue;
}
</style>
<body>



	<div class="dashboard">
		<div class="Introduction">
			<div class="options">
				<ul>
					<li title="setting"><i class="fa fa-cog setting"></i></li>
					<li title="minimize"><i class="fa fa-window-minimize setting"
						id="minmax"></i></li>
					<!-- <li title="maximize"><i class="fa fa-window-maximize setting"></i></li>  -->
				</ul>
			</div>
			<div class="userDetails" id="intro">
				<table>
					<tbody>
						<div>
							<tr>
								<td><h1>
										<bold>Name: </bold>
										<span> <%
 out.print(session.getAttribute("USERNAME"));
 %>
										</span>
									</h1></td>
							</tr>
						</div>
						<div>
							<tr>
								<h1>
									<bold> Profession: </bold>
									<span><bold> <%
 out.print(session.getAttribute("USERTYPE"));
 %> </bold></span>
								</h1>

							</tr>
						</div>
						<div>
							<tr>
								<h1>
									<bold> User Id: </bold>
									<span><bold> <%
 out.print(session.getAttribute("USERID"));
 %> </bold></span>
								</h1>

							</tr>
						</div>
					</tbody>
				</table>
			</div>
			<div class="footer"
				style="width: 100%; height: 20px; background-color: grey; margin-top: 100px; border-bottom-left-radius: 10px; border-bottom-right-radius: 10px;"></div>
		</div>
		<%@page import="java.sql.*"%>
		<%@page import="java.util.ArrayList"%>
		<div class="details" id="details">
			<table border=1>
				<thead>
					<tr>
						<th>Roll Number</th>
						<th>Name</th>
						<th>Date Of Birth</th>
						<th>Class</th>
					</tr>
				</thead>
				<tbody>

					<%
					Connection c;
					PreparedStatement ps;
					ArrayList<String> userId = new ArrayList<String>();
					ArrayList<String> StudentName = new ArrayList<String>();
					ArrayList<String> DOB = new ArrayList<String>();
					ArrayList<String> currClass = new ArrayList<String>();
					Class.forName("com.mysql.jdbc.Driver");
					c = DriverManager.getConnection("jdbc:mysql://192.168.0.173:3306/studentmangementsystem", "sanjeev", "sanjeev@123");
					ps = c.prepareStatement("select * from studentlogin order by ? desc");
					ps.setString(1, request.getParameter("std_id"));
					ResultSet rs = ps.executeQuery();
					while (rs.next()) {
						userId.add(rs.getString(2));
					%>
					<%
					out.print("<tr style='color:white;'><td>" + rs.getString(2) + "</td>");
					out.print("<td>" + rs.getString(3) + " " + rs.getString(4) + "</td>");
					out.print("<td>" + rs.getString(6) + "</td>");
					out.print("<td>" + rs.getString(8) + "</td></tr>");
					%>

					<%
					}
					%>
				</tbody>
			</table>
		</div>
		<div class="recentActivities" id="recent"></div>
	</div>

</body>
<script src="../script/Profile.js"></script>
</html>