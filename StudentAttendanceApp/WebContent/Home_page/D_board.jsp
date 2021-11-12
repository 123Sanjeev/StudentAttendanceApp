<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Home</title>
</head>
<body>
	
	<%
		if (session.getAttribute("USERTYPE").equals("Student")) {
				out.print("<iframe src='http://192.168.0.173:8081/StudentAttendanceApp/Home_page/StudentFrame.jsp' width='100%' height='100vh'></iframe>");	
		}else if(session.getAttribute("USERTYPE").equals("Admin")){
			out.print("<iframe src='http://192.168.0.173:8081/StudentAttendanceApp/Home_page/Home.jsp' style='width:100%; height:100vh' ></iframe>");	
		}
	%>

</body>
</html>