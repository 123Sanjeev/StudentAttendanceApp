<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.util.Date" %>
<%

String uid = null;
Connection conn = null;
PreparedStatement s = null;
String u = request.getParameter("ud");
String fn = request.getParameter("firstname");	
String ln = request.getParameter("Lastname");
String d = request.getParameter("DOB");
String p = request.getParameter("pass");
//out.print(d);
//Date da = new Date();
//SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
//Date date = f.format(da);
try{
	System.out.print(u);
	Class.forName("com.mysql.jdbc.Driver");
	conn = DriverManager.getConnection("jdbc:mysql://192.168.0.173:3306/studentmangementsystem","sanjeev","sanjeev@123");
	s = conn.prepareStatement("insert into studentlogin(Std_id,firstname,lastname,dob,pass) values('"+u+"','"+fn+"','"+ln+"','"+d+"','"+p+"')");
	s.execute();
	session.setAttribute("sentdata","Data entered succesfully ");
	String site = new String("/StudentAttendanceApp/New_user/CreateNewUser.jsp");
	response.setStatus(response.SC_MOVED_TEMPORARILY);
	response.setHeader("Location", site);


}catch(Exception e){
	out.print(e);
	//out.print(date);
}
%>