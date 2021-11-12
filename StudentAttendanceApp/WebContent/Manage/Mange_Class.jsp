<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Manage Class</title>
<link rel="stylesheet" href="../Style/TimeTable.css">
</head>



<body>
	<%@ include file="../navbar.jsp"%>

	<div class="s">
		<div class="ClassSelector">
			<select id="selector" class="selector">
				<option value="">Select class</option>
				<option value="1">Class 1</option>
				<option value="2">Class 2</option>
				<option value="3">Class 3</option>
				<option value="4">Class 4</option>
				<option value="5">Class 5</option>
				<option value="6">Class 6</option>
				<option value="7">Class 7</option>
				<option value="8">Class 8</option>
				<option value="9">Class 9</option>
				<option value="10">Class 10</option>
			</select>
		</div>
		<div>
			<select id="selector2" class="selector">
				<option>Select subject</option>
			</select>
		</div>
	</div>
	<!-- <iframe name="careaddaContactPage" src="https://www.careadda.com/#contact" width="600px" height="400px"></iframe> -->




</body>
<script src="../script/TimeTableScript.js"></script>

<script type="text/javascript">
const url = "http://192.168.0.173:8080/StudentAttendanceApp/Manage/classData/classDetails.json";

async function setData(url, data={}){
const response = await fetch(url, {
	method : "PUT",
	 mode: 'cors', // no-cors, *cors, same-origin
	 cache: 'no-cache', // *default, no-cache, reload, force-cache, only-if-cached
	 credentials: 'same-origin',
	headers:{
		'Content-Type' : 'application/json'
	},
	body:JSON.stringify(data)
});

return response.json();
}

if(document.getElementById("save") != null){
document.getElementById("save").addEventListener("click", setData(url, {Time : document.getElementById("getTime").value}).then(data =>{
	console.log(data);
}));
}
</script>
</html>