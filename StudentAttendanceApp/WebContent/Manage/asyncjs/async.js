/**
 * 
 */
//setting up Ajax request
var xhr = new XMLHttpRequest();


// method for loading pages
function loadPage(data, title) {
	xhr.open("GET", data + ".jsp?token=" + data, true);
	//window.location="/StudentAttendanceApp/Manage/class_Attendace/attendance.jsp?appid="+data
	xhr.onload = () => {
		if (xhr.status === 200 && xhr.readyState === 4) {
			//window.history.pushState("","","http://192.168.0.173:8081/StudentAttendanceApp/Manage/class_Attendace/"+data+".jsp?token="+data)
			document.getElementById('target').innerHTML = xhr.responseText
			document.title = title;
		} else {
			console.log('Error in the application')
		}
		uls();
	}
	xhr.send();

}

// loading content of page check Attendance

function loadContent(option) {
	xhr.open("GET", "http://192.168.0.173:8081/StudentAttendanceApp/checkAttendanceApp?selectedvalue=" + option, true);
	xhr.responseType = "text";
	xhr.onload = () => {
		if (xhr.status === 200 && xhr.readyState === 4) {

			document.getElementById("select1").innerHTML = "<option>Select section</option>" + xhr.response.toString();
		}
	}

	xhr.send();
}

function openClassRecord(val) {
	xhr.open("GET", "http://192.168.0.173:8081/StudentAttendanceApp/calculateAttendance?class=" + val, true);
	xhr.onload = () => {
		if (xhr.readyState === 4 && xhr.status === 200) {
			console.log(xhr.responseText);
		}
	}
	xhr.send();
}

//loading users data
function showData(opt) {
	console.log(opt)
	const select = document.getElementById('selectthis');
	var option = select.options[select.selectedIndex].value;

	xhr.open("POST", "http://192.168.0.173:8081/StudentAttendanceApp/showAttendance?selectedValue=" + option + "&selectedSection=" + opt, true);
	xhr.responseType = "text";
	xhr.onload = () => {
		if (xhr.status === 200 && xhr.readyState === 4) {
			//console.log(xhr.response)
			var data = xhr.response.toString();
			data = data.replaceAll("Served at: /StudentAttendanceApp", "");

			document.getElementById("result").innerHTML = `<div class="d-flex">
				<table class="table"> 
					<thead class="thead-dark">
						<tr class="text-center">
							<th scope="col"> Student Id </br> <input type="text" name="studentid" class="customSearch"/> </th>
							<th scope="col"> Student Name </br> <input type="text" name="studentname" class="customSearch"/> </th>
							<th scope="col"> Attendance Date </br> <input type="text" name="attendanceDate" class="customSearch"/> </th>
							<th scope="col"> Attendance Status </br> <input type="text" name="attendancestatus" class="customSearch"/>  </th>
						</tr>
					</thead>
					<tbody id="res">
						 ${data}
					</tbody>
				</table>
			</div>`;
		}
		activeController();
	}
	xhr.send();

}

function activeController() {
	var cst = document.getElementsByClassName("customSearch");
	console.log("testing");
	if (cst != null) {
		for (let i = 0; i < cst.length; i++) {
			cst[i].addEventListener("keypress", e => {
				console.log("working here part 1");
				if (e.key == "Enter") {
					console.log("working here part 2");
					customSearch();
				}
			});
		}
	}
}
function customSearch() {
	var cstSearch = document.getElementsByClassName("customSearch");
	var custId = "mxschkatnd";
	xhr.open("POST", "http://192.168.0.173:8081/StudentAttendanceApp/showAttendance?id=" + custId + "&studentid=" + cstSearch[0].value + "&studentname=" + cstSearch[1].value + "&attendanceDate=" + cstSearch[2].value + "&attendanceStatus=" + cstSearch[3].value);
	xhr.onload = () => {
		if (xhr.readyState === 4 && xhr.status === 200) {
			document.getElementById("res").innerHTML = `${xhr.responseText}`;
		}
	}
	xhr.send();
}


if (document.getElementById("search") != null) {
	var t = document.getElementById("search");
	var input = t.getElementsByTagName("input");

	for (let i = 0; i < input.length; i++) {
		input[i].addEventListener("keypress", e => {
			if (e.key == "Enter") {
				searchUser();
			}
		})
	}
}

var parser = new DOMParser();
var o;
function searchUser() {
	var v = document.getElementById("userid");
	xhr.open("GET", "http://192.168.0.173:8081/StudentAttendanceApp/searchStudent?value=" + v.value, true);
	xhr.onload = () => {
		if (xhr.status === 200 && xhr.readyState === 4) {
			o = parser.parseFromString(xhr.responseText, "text/xml");
			document.getElementsByClassName("resultData")[0].querySelectorAll("tbody")[0].innerHTML = `${o.all[0].innerHTML}`;
		}
	}
	xhr.send();
}


function getSessionData() {
	xhr.open("POST", "http://192.168.0.173:8081/StudentAttendanceApp/sessionMgmt?userid=100001");
	xhr.reponseType = "text";

	xhr.onload = () => {
		if (xhr.status === 200 && xhr.readyState === 4) {
			console.log(xhr.responseText);
		}
	}
	xhr.send();
}



//setInterval(getSessionData, 6000);



function openRecord(id, app, record) {
	xhr.open("GET", "http://192.168.0.173:8081/StudentAttendanceApp/" + app + "?recordid=" + record, true);
	xhr.reponseType = "text/html";
	xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
	xhr.onloadstart = () => {
		document.body.style.cursor = "wait";
		console.log("loading");
	}

	xhr.onloadend = () => {
		document.body.style.cursor = "context-menu";
		console.log("loaded");
	}
	xhr.onload = () => {
		if (xhr.status === 200 && xhr.readyState === 4) {
			document.getElementById(id).innerHTML = `<div>${xhr.responseText}</div>`
		}
	}
	xhr.send();
}

function checkValue(a) {
	xhr.open("GET", "http://192.168.0.173:8081/StudentAttendanceApp/searchStudent?a=" + a.textContent, true);
	xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded")


	xhr.onload = () => {
		console.log("loading");

		if (xhr.status === 200 && xhr.readyState === 4) {
			console.log("loaded");
			console.log(xhr.response.toString());
		}
	}
	xhr.send();
}

function getSessionDetails(url, userid) {
	xhr.open("POST", url + userid, true);
	xhr.onload = () => {
		if (xhr.status === 200 && xhr.readyState === 4) {
			var script = document.createElement("script");
			script.textContent = `alert('${xhr.response}')`;
			document.body.appendChild(script);
		}
	}
	xhr.send();
}


function updateUser() {
	var inputs = document.getElementsByTagName("input");
	var inputvalues = [];
	for (input of inputs) {
		if (input.disabled == false) {
			inputvalues.push(input.value)
		}
	}
	console.log(inputvalues);
}


function searchClass() {
	var val = document.getElementById("classname");
	console.log("function call initaited");
	xhr.open("GET", "http://192.168.0.173:8081/StudentAttendanceApp/markAttendance?value=" + val.value, true);
	xhr.onload = () => {
		if (xhr.status === 200 && xhr.readyState === 4) {
			var table = document.getElementById("contentTable");
			var tbody = document.getElementById("Content");
			tbody.innerHTML = `${xhr.responseText} <button class='btn btn-success'type="submit"  >save Record </button>`;
		}
	}
	xhr.send();
}


function uls() {
	var els = document.getElementsByClassName("updtStudent")
	for (let i = 0; i < els.length; i++) {
		els[i].addEventListener("keypress", e => {
			if (e.key == 'Enter') {
				searchUpdateAttendance(xhr);
			}
		});
	}
}





