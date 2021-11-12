<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Student Portal</title>
</head>
<style>
	
*{
	margin:0px;
	padding:0px;
	box-sizing:border-box;
}

body{
	width:100%;
	height:100vh;
	background-color:lightblue;
	display:flex;
	flex-direction:column;
	justify-content:center;
	align-items:center;	
}

.er{
	width:80%;
	height:100vh;
	background-color:lightblue;
	display:flex;
	flex-direction:column;
	justify-content:center;
	align-items:center;	
}
.er h1{
	text-align:center;
}
.cReq{
	width:100%;
	display:flex;	
	justify-content:center;
}
.cReq button{
	width:120px;
	height:40px;
	background:black;
	color:white;
	border:1px solid black;
	padding:5px;
	border-radius:5px;
	cursor:pointer;
}

nav{
	width:100%;
	position:absolute;
	left:0px;
}

</style>
<body>




<%
if(session.getAttribute("VALID_CHECK") == null){
	response.sendRedirect("http://localhost:8080/StudentAttendanceApp/Logout.jsp");
}else{
	if(session.getAttribute("VALID_CHECK").equals(1)){
		int reportedByid = (int) session.getAttribute("USERID");
	%>
	<div class='er'>
		<h1>
			You have not attended required number of classes. 
			Your access to the portal has been blocked. 
			</br>
			Contact HOD for unblocking of the access  
			<input type='hidden' name='reportedby' value='"+ <% out.print(reportedByid); %> +"' />
			</br>
			<div class='cReq'>
				<button type='submit' onclick='accountCheck()'> 
					click to raise request
				</button>
			</div>
		</h1>
	</div>
	<%
	}else{
		%>
		<nav>
			<%@include file="../navbar.jsp" %>
		</nav>
			Page development Under progress....
		<%
	}
}
%>



</body>

<script>
	var xhr = new XMLHttpRequest();
	function accountCheck(){

		xhr.open("POST","http://192.168.0.173:8081/StudentAttendanceApp/createRequest?reportedby=<% out.print((int) session.getAttribute("USERID")); %>"); 
		xhr.onload = ()=>{
			if(xhr.status === 200 && xhr.readyState === 4){
				alert(xhr.responseText);
			}
		}
		xhr.send();
	}
</script>
</html>