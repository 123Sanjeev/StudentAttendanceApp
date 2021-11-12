/**
 * 
 */

const intro = document.getElementById("intro");
const details = document.getElementById("details");
const recent = document.getElementById("recent");
const li = document.querySelectorAll(".setting");
const minmax = document.getElementById("minmax");
intro.onclick = () => {
	alert("this is introduction page");
}
details.onclick = () => {

}
recent.onclick = () => {

}
var minimize = false;


minmax.onclick = () => {
	console.log("click observed");
	if (minimize == false) {
		intro.style.display = "none";
		minmax.classList.remove("fa-window-minimize");
		minmax.classList.add("fa-window-maximize");
		minimize = true;
	} else if (minimize) {
		intro.style.display = "";
		minmax.classList.remove("fa-window-maximize");
		minmax.classList.add("fa-window-minimize");
		minimize = false;
	}
	
	

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}


