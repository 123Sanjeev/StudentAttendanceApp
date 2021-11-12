<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Search Student</title>
</head>
<style>
table {
	width: 100%;
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
	text-align: center;
}

th {
	background: darkblue;
	padding: 10px;
	color: white;
	border: 1px inset blue;
	border-radius: 2px;
}

td, th {
	width: 300px;
	text-align: center;
	border: 1px inset blue;
}

td {
	padding: 10px;
}

tr:nth-child(even) {
	background-color: white;
}
</style>

<body>

	<%@include file="../navbar.jsp"%>

	<main>

		<h1>
			<%
			if (session.getAttribute("USERID") != null) {
				out.print("Welcome" + session.getAttribute("USERNAME"));
			}
			%>
		</h1>

		<form action="StudentRec.jsp" method="get">
			<div>
				<p>Search user by First Name/Employee Id</p>
			</div>
			<div>
				<input type="text" name="stdname" id="stdname" value="" />
			</div>
			<div>
				<button type="submit" name="student_search">Search</button>
			</div>
		</form>
		<form action="StudentRec.jsp" method="get">
			<div>
				<p>Search user by First Name/Employee Id</p>
			</div>
			<div>
				<input type="text" name="adminid" id="adminid" value="" />
			</div>
			<div>
				<button type="submit" name="adminusers">Search</button>
			</div>
		</form>
	</main>


	<!-- Result section -->
	<table>
		<thead>
			<tr>
				<th>SL NO.</th>
				<th>User Id</th>
				<th>User Name</th>
			</tr>
		</thead>
		<tbody>

			<%@ page import="java.sql.*"%>
			<%@ page import="java.util.*"%>
			<%
			int SL_NO = 0;
			ArrayList<String> val = new ArrayList<>();
			ArrayList<String> firstName = new ArrayList<>();
			ArrayList<String> lastname = new ArrayList<>();
			String stdn = request.getParameter("stdname");
			String stdsearch = request.getParameter("student_search");
			String adminsearch = request.getParameter("adminusers");
			String as = request.getParameter("adminid");
			Connection conn = null;
			PreparedStatement ps = null;
			PreparedStatement ps2 = null;
			ResultSet rs = null;
			try {
				Class.forName("com.mysql.jdbc.Driver");
				conn = DriverManager.getConnection("jdbc:mysql://192.168.0.173:3306/studentmangementsystem", "sanjeev", "sanjeev@123");

				ps = conn.prepareStatement(
				"select * from studentlogin where std_id like '%" + stdn + "%' or firstname like '%" + stdn + "%'");
				ps2 = conn.prepareStatement("select * from adminusers where user_id like '%"+as+"%'");
				
				out.print(as);
				if (stdsearch != null) {
					rs = ps.executeQuery();
				} else if (adminsearch != null) {
					rs = ps2.executeQuery();
				}
				while (rs.next()) {
					SL_NO++;
			%>
			<%
			out.print("<tr><td>" + SL_NO + "</td>");
			out.print("<td>" + rs.getString(2) + "</td>");
			out.print("<td>" + rs.getString(3) + " " + rs.getString(4) + "</td></tr>");
			val.add(rs.getString(2));
			firstName.add(rs.getString(3));
			lastname.add(rs.getString(4));
			}
			} catch (Exception e) {
			if (stdsearch != null) {
			out.print(e);
			}
			}
			%>
		</tbody>
	</table>

</body>
</html>