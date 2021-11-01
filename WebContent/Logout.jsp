<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%


Connection conn = null;
Statement ps = null;
try {
	Class.forName("com.mysql.jdbc.Driver");
	conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/studentmangementsystem", "sanjeev", "sanjeev@123");
	ps = conn.createStatement();
	ps.executeUpdate("Delete from logintrack where u_id = '" + session.getAttribute("USERID") + "'");

	request.getSession().invalidate();
	String site = new String("/StudentAttendanceApp/");
	response.setStatus(response.SC_MOVED_TEMPORARILY);
	response.setHeader("Set-Cookie", response.getHeader("Set-Cookie") + ";SameSite=strict");
	response.setHeader("Location", site);

} catch (Exception e) {
	out.print(e);
}
%>