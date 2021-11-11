/**
 * 
 */




function checkmarkAttendance(d){
	event.preventDefault();
	var form = document.getElementById(d)
	var checkBoxex = document.getElementsByName('attendance');
	
	
	for(let i =0; i<checkBoxex.length; i++){
		if(checkBoxex[i].checked == true){
			checkBoxex.value =1;
			console.log(checkBoxex.value)
		}else{
			checkBoxex.value = 0;
			console.log(checkBoxex.value)
		}
	}
		
		form.submit();	

}