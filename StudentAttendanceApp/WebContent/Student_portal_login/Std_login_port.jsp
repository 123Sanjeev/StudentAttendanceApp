<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Student login</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x"
	crossorigin="anonymous">
<link rel="icon" href="favicon.png" type="image/png" sizes="192x192">
</head>
<style>
* {
	margin: 0px;
	padding: 0px;
	box-sizing: border-box;
}

input {
	border: none !important;
	border-bottom: 1px solid lightblue !important;
	margin-bottom:20px;
}

.form-internal {
	width: 400px;
	height: 450px;
	padding: 20px;
	box-shadow: 2px 2px 15px grey;
}
</style>
<body>

<!-- 
	<section>
		<div></div>
		<div>
			<div>
				<form action="../StudentLogin" method="post">
					<div>
						<span></span> <label for="username">User Name : </label> <input
							type="text" placeholder="User Name" name="username" id="username" />
					</div>
					<div>
						<span></span> <label for="password">User Name : </label> <input
							type="password" placeholder="Enter the password" name="password"
							id="password" />
					</div>
					<div>
						<button type="submit">Login</button>
					</div>
				</form>
			</div>
		</div>

	</section>
-->	
	
	<main class="d-flex justify-content-center align-center"
		style="height: 100vh">
		<div class="d-flex align-center justify-content-center flex-column"
			style="height: 100vh">
			<form style="height: 100vh" action="../StudentLogin" method="POST"
				class="d-flex flex-column align-center justify-content-center">
				<div
					class="d-flex flex-column align-center form-internal justify-content-center">
					<div class="container mb-5 mt-0"
						style="border-bottom: 1px solid black">
						<h4>Student Management System</h4>
					</div>
					<div>
						<input type="text" name="username" id="userid"
							placeholder="Enter user id" class="form-control" />
					</div>
					<div>
						<input type="password" class="form-control" name="password" id="pass"
							placeholder="Enter password" />
					</div>
					<div>
						<button type="submit" class="btn-primary mt-2 p-1 ml-2">Login</button>
					</div>
					<div class="container-fluid">
						<div>
							<a href="F_P/Fogotpassword.jsp" style="margin-top:20px;">forgot password</a>
						</div>
						<div>
							<a
								href="http://192.168.0.173:8081/StudentAttendanceApp/Login_Admin_app/Login.jsp">
								Change Login</a>
						</div>
					</div>

					<div class="container text-center">
						<small class="text-center">Student Management Login page</small>
					</div>
				</div>
			</form>




		</div>

	</main>
	

</body>
</html>