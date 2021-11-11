<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<html>
<head>
<title>Custom report</title>
</head>
<style>
* {
	margin: 0px;
	padding: 0px;
	box-sizing: border-box;
}

span {
	padding: 10px;
	width: 450px !important;
}

#maindiv {
	display: flex;
	flex-direction: row;
	justify-content: space-evenly;
	border: 2px solid black;
	align-items: center;
	margin-top: 10px;
}

#maindiv div {
	width: 450px !important;
	align-items: center;
	margin: 0px;
	padding: 0px;
	border: 3px solid black !important;
}

table {
	display: flex;
	flex-direction: column;
	justify-content: space-around;
	align-items: center;
	border: 1px solid black;
	padding: 0px;
	border-collapse : collapse;
}

td, th {
	width: 300px;
	padding: 10px;
	border: 2px solid black;
	text-align: center;
}
</style>
<body>
	<header>
		<div
			style="background: blue; color: white; height: 35px; box-shadow: 2px 2px 2px 2px black;">
			<h1 style="text-align: center; width: 100%;height=auto; ">Custom
				student list report</h1>
		</div>
		<div>
			<!-- <button id="save" name="save"><a href="http://192.168.0.173:8080/StudentAttendanceApp/Reports/report.txt" >Save</a> </button>-->
		</div>
	</header>

	<table>
		<thead>
			<tr>
				<th style="width: 50px; text-align: center;">SL NO.</th>
				<th>User Id</th>
				<th>User Name</th>
				<th>Date Of Admission</th>
			</tr>
		</thead>
		<tbody>

			<%@ page import="java.sql.*"%>
			<%@ page import="java.util.*, java.lang.*,java.io.*"%>
			<%
			final String jdbc = "com.mysql.jdbc.Driver";
			final String username = "sanjeev";
			final String password = "sanjeev@123";
			int SL_NO = 0;
			String s = request.getParameter("save");
			String loadmore = request.getParameter("Loadmore");
			String t = request.getParameter("teachers");
			FileWriter fw = null;
			ResultSet rs = null;
			if (s != null) {
				fw = new FileWriter("F:/myFile.txt");
			}
			Connection conn = null;
			PreparedStatement ps = null;
			PreparedStatement ps2 = null;
			//teachers

			ArrayList<Integer> Userid = new ArrayList<>();
			ArrayList<String> uname = new ArrayList<>();
			ArrayList<String> dateofadmission = new ArrayList<>();
			try {
				Class.forName(jdbc);
				conn = DriverManager.getConnection("jdbc:mysql://192.168.0.173:3306/studentmangementsystem", username, password);
				ps = conn.prepareStatement("select * from studentlogin");
				ps2 = conn.prepareStatement("select * from adminusers");
				if (t == null) {
					rs = ps.executeQuery();
				}
				if (t != null) {
					rs = ps2.executeQuery();
				}
				while (rs.next()) {
					SL_NO++;
			%>

			<%
			int sl_no = 0;
			out.print("<tr><td style='width:50px; text-align:center;'>" + SL_NO + "</td>");
			out.print("<td>" + rs.getInt(2) + "</td>");
			out.print("<td>" + rs.getString(3) + "</td>");
			out.print("<td>" + rs.getDate(5).toString() + " " + rs.getTime(5).toString() + " </td> </tr>");
			Userid.add(rs.getInt(2));
			uname.add(rs.getString(3));
			dateofadmission.add(rs.getDate(5).toString() + " " + rs.getTime(5).toString());
			if (s != null) {
				fw.write(rs.getInt(2));
			}
			}

			} catch (Exception e) {
			out.print(e);
			} finally {
			conn.close();

			}
			%>

		</tbody>
	</table>
</body>
</html>




