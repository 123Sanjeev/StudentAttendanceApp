/**
 * 
 */

function loadAtApp(appid){
	var xhr = new XMLHttpRequest();
	xhr.open("GET","http:192.168.0.173:8080/StudentAttendanceApp/Manage/class_Attendance/attendance.jsp?appid="+appid, true);
	xhr.onload = ()=>{
		if(xhr.status === 200 && xhr.readyState === 4){
			document.URL ="http:192.168.0.173:8080/StudentAttendanceApp/Manage/class_Attendance/attendance.jsp?appid="+appid; 
		}
	}
	
}