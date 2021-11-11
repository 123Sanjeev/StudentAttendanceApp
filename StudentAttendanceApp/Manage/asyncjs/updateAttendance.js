/**
 * 
 */

	var tbody= document.createElement("tbody");
function searchUpdateAttendance(x){
	var table = document.getElementById("searchCls");

	var uEle = document.getElementsByClassName("updtStudent")
	var id = "searchUapp"
	x.open("GET", "http://192.168.0.173:8081/StudentAttendanceApp/updateStudent?appid="+id + "&class="+uEle[0].value+"&atndDate="+uEle[1].value+"&section="+uEle[2].value,true);
	x.onload = ()=>{
		if(x.status === 200 && x.readyState === 4){
		if(xhr.responseText == ''){
				tbody.innerHTML ="<tr><td style='color:red; width:100%; text-align:center; '>No records found</<td></tr>";
			}else{
				tbody.innerHTML = x.responseText;
			}
		}		
	}
	table.appendChild(tbody);
	x.send();
}

function loadupdateapp(val){
	var appid="oprcrd";
	xhr.open("GET","http://192.168.0.173:8081/StudentAttendanceApp/Manage/manageAttendance/openMRecord.jsp?val="+val,true);
	xhr.onload = ()=>{
		if(xhr.status===200 && xhr.readyState === 4){
			
				document.getElementById('target').innerHTML = xhr.responseText
			}
	}	
	xhr.send();
}