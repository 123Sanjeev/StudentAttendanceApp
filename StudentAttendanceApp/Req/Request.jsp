<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Pending request</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" />

</head>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x"
	crossorigin="anonymous" />


<style>
* {
	margin: 0px;
	padding: 0px;
	box-sizing: border-box;
}

.outer {
	width: 100%;
	height: 100vh;
	position: fixed;
	top: 0;
	background-color: black;
	opacity: 0.4;
}

.inner {
	width: 400px;
	height: 200px;
	background-color: white;
	box-shadow: 4px 4px 4px 4px grey;
	position: relative;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
}

.inner>p {
	display: flex;
	flex-direction: column;
	align-items: center;
	justify-content: center;
	width: 100%;
	padding: 10px;
	text-align: center;
}

.inner>p:after {
	width: 100%;
	content: "";
	margin: 10px;
	border: 1px solid black;
}

.inner div {
	width: 100%;
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
}

.inner div>select {
	width: 200px;
	padding: 10px;
	background-color: white;
	border: 1px inset black;
}
</style>

<body>
	<%@include file="../navbar.jsp"%>
	<%@page import="java.sql.*"%>
	<%@page import="StudentLogin.connectionDBPool"%>
	<table class="table">
		<thead>
			<tr>
				<th>Request Number</th>
				<th>Description</th>
				<th>Requester</th>
				<th>Owner</th>
				<th>Request Type</th>
				<th>Request date</th>
				<th>Status</th>
			</tr>
		</thead>
		<tbody>
			<%
			int LOGGED_IN_USER = (int) session.getAttribute("USERID");
			try (Connection conn = new connectionDBPool().dbpoolConnection()) {
				PreparedStatement ps = conn.prepareStatement("select * from request where owner=?");
				ps.setInt(1, LOGGED_IN_USER);
				ResultSet rs = ps.executeQuery();
				while (rs.next()) {
					if(rs.getString(7).equals("CLOSED") || rs.getString(7).equals("REJECTED")){
						out.print("<tr><td>" + rs.getString(1) + "</td><td>" + rs.getString(3) + "</td><td>" + rs.getString(4)
						+ "</td><td>" + rs.getString(5) + "</td><td>" + rs.getString(2) + "</td><td>" + rs.getString(6)
						+ "</td><td><span class='status'>" + rs.getString(7)
						+ "</span></td></tr>");
							
					}else{
					out.print("<tr><td>" + rs.getString(1) + "</td><td>" + rs.getString(3) + "</td><td>" + rs.getString(4)
					+ "</td><td>" + rs.getString(5) + "</td><td>" + rs.getString(2) + "</td><td>" + rs.getString(6)
					+ "</td><td><span class='status'>" + rs.getString(7)
					+ "</span><td><i class='fa fa-pencil fa-fw'  style='cursor:pointer;' onclick='changeStatus(this)'></i></td></td></tr>");
					}
					boolean noRecord = rs.wasNull();
					if (noRecord == true) {
				out.print("No record found");
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			%>
		</tbody>
	</table>
</body>









<script>

var xhr = new XMLHttpRequest();
	var uValue, requestId;
	function updateRow(id,val){
			const reqType = "rowUpdate";
			xhr.open("POST", "http://localhost:8080/StudentAttendanceApp/createRequest?reqType="+reqType+"&rowId="+id+"&currentStatus="+val);
				xhr.onload = ()=>{
					if(xhr.status == 200 && xhr.readyState == 4){
						var s = document.querySelectorAll(".status");
						for(let i=0; i<s.length; i++){
							var v = s[i].parentElement.parentElement.querySelectorAll("td")[0].textContent;
							if(v == id){
								s[i].textContent = xhr.responseText;
							}else{
								console.log(v);
							}
						}	
						console.log(xhr.responseText)
					}
				}
			xhr.send();
	}
var val;
function changeStatus(rows){
	var rowsStatus = rows.parentElement.parentElement.querySelectorAll("td")[6].textContent;
	if(rowsStatus == "CLOSED" || rowsStatus == "REJECTED"){
		alert("selected Record is readonly");
	}else{
	val = rows.parentElement.parentElement.querySelectorAll("td")[0].textContent;
	var cStatus = document.createElement("div");
	cStatus.id="cStatus"
	if(rowsStatus == "APPR"){
		cStatus.innerHTML =  `<div class='outer'></div>
		<div class='inner'>
		<p>
			Change Status
		</p>
	<div> 
		<select class='chgSts' onchange='uStatus(this)'>
		<option value='' selected>Select Status</option>
		<option value='CLOSED'>Close</option>
	</select>
	
	
		<p> selected Record `+val+`</p>
		<button onclick='javascript:this.parentElement.parentElement.parentElement.remove()'>
			Close
		</button>
	</div>
</div>
	`;
	}else if(rowsStatus === "PENDING"){
		cStatus.innerHTML =  `<div class='outer'></div>
			<div class='inner'>
			<p>
				Change Status
			</p>
		<div> 
		
		<select class='chgSts' onchange='uStatus(this)'>
		<option value='' selected>Select Status</option>
		<option value='APPR'>Appr</option>
		<option value='REJECTED'>Reject</option>
		<option value='CLOSED'>Close</option>
	</select>

			<p> selected Record `+val+`</p>
			<button onclick='javascript:this.parentElement.parentElement.parentElement.remove()'>
				Close
			</button>
		</div>
	</div>`;
	}
	document.body.appendChild(cStatus);
	}
}




function uStatus(rData){
	console.log(rData.options[rData.selectedIndex].value);
	var res = rData.options[rData.selectedIndex].value;
	updateRow(val, res);
	document.body.removeChild(document.getElementById("cStatus"));
}

</script>



</html>













