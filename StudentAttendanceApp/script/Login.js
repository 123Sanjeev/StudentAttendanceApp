/**
 * 
 */
const a = document.getElementsByTagName("a");
var isClicked = false;
for(let i=0; i<a.length;i++){
	a[i].addEventListener("click",()=>{
		if(isClicked == false){
			a[i].classList.add("active");
			isClicked = true;
		}else{
			a[i].classList.remove("active");
			isClicked = false;
		}
		
	});
}

function validate(){
	alert("i am triggered");
}

