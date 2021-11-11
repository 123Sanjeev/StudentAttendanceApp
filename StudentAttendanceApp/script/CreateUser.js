/**
 * 
 */

document.getElementById("SaveRecord").addEventListener('click', createNewUser);
var s = window.sessionStorage;
function createNewUser(e){
	e.preventDefault();
	var generatePassButton = document.createElement("button");
	generatePassButton.innerText = "Generate Password";
	generatePassButton.onclick = utrig;
	
	var ele = [document.getElementById("UID"),
				 document.getElementById("UNAME"),
				 document.getElementById("DOB")
				];	
				console.log(ele[0].value.length);
		if(ele[0].value.length > 10){
			alert("User id can not be more than 10");
		}else if(ele[0].value.length < 6){
			alert("User id can not be less than 6");
		}else{
				document.body.append(generatePassButton)
		}	
		s.setItem("datasave",ele[0].value);
		document.getElementById("UID").disabled = false;	
}

window.onload = ()=>{
	//e.defaultPrevented();
	var saveRec = s.getItem("datasave");
	if(saveRec == document.getElementById("UID").value){
		document.getElementById("UID").disabled = false	;
	}
}

function utrig(){
	var newpass = document.getElementById("password").value = userpass(document.getElementById("UNAME").value,document.getElementById("UID").value);
	console.log(newpass);
}

function userpass(uname,uid){
	return uname.substring(0,2)+"@"+uid.substring(uid.length-2,uid.length)+"1234";
}




