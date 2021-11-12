<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Forgot password</title>
</head>
<body style="background: lightblue">
	<div
		style="width: 100%; heigth: 100vh; dislay: flex; flex-direction: column; justify-content: center; align-items: center;">
		<div style="width: 600px; height: 600px; border: 1px solid black;">
			<p> Enter User id</p>
			<input type="text" id="u_id" placeholder="Enter user id" /> 
			<p>Enter the Correct Answer</p>
			<input id="inputEle" type="text" placeholder="Enter the answer" />
			<button onclick="validateAnswer()">Validate</button>
		</div>
	</div>
</body>
<script>
	function validateAnswer() {
		var secretKey = 'Sanjeev';

		var i = document.getElementById("inputEle");
		var id = document.getElementById('u_id');
		console.log(id.value);

		if (i.value.toUpperCase() == secretKey.toUpperCase()) {
			window.location.href= "http://192.168.0.173:8080/StudentAttendanceApp/F_P/reset_.jsp?="+id.value;
		} else {
			console.log("failed");
		}
	}
</script>
</html>
