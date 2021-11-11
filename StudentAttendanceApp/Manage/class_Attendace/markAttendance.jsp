<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
</head>

<body>
	<div class="container bg-light">
		<table class="table" id="contentTable">
			<thead>
				<tr>
					<th>
						<div>
							<label for="classname">Enter class</label> <input type="text"
								id="classname" placeholder="Enter class name" />
							<button onclick="searchClass()" class="btn btn-primary">Search
								Class</button>
						</div>
					</th>	
				</tr>
			</thead>
		</table>
	</div>
	<form method="POST" onsubmit = "checkmarkAttendance(this.id)" id="saveForm" action="http://192.168.0.173:8081/StudentAttendanceApp/saveAttendance">
		<div id="Content"></div>
	</form>
</body>

<script src="http://192.168.0.173:8080/StudentAttendanceApp/Manage/asyncjs/async.js"> 
	
</script>

</html>