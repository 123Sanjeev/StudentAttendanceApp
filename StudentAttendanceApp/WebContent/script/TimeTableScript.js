/**
 * 
 */



const subject = {
    One: ["Hindi", "English", "Maths", "Science", "Drawing"],
    Two: ["Hindi", "English", "Maths", "Science", "Drawing", "Social Studies"],
    Three: ["Hindi", "English", "Maths", "Science", "Drawing", "Social Studies"],
    Four: ["Hindi", "English", "Maths", "Science", "Drawing", "Social Studies"],
    Five: ["Hindi", "English", "Maths", "Science", "Drawing", "Social Studies"],
    Six: ["Hindi", "English", "Maths", "Science", "Drawing", "Social Studies"],
    Seven: ["Hindi", "English", "Maths", "Science", "Drawing", "Social Studies"]
}


var d = new Date();

function monthMaking() {
    var monthList = ["", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
    return monthList[d.getDay()];
}

const select = document.getElementById("selector")
const select2 = document.getElementById("selector2")
var opt;

select.addEventListener("change", e => {
    e.preventDefault()
    var m = select.options[select.selectedIndex].value
    select.disabled = true;
    switch (m) {
        case "1":

            for (let i = 0; i < subject.One.length; i++) {

                opt = document.createElement("option")
                opt.value = subject.One[i]
                opt.textContent = subject.One[i]
                select2.appendChild(opt)
            }


            break;
        case "2":
            for (let i = 0; i < subject.Two.length; i++) {

                opt = document.createElement("option")
                opt.value = subject.Two[i]
                opt.textContent = subject.Two[i]
                select2.appendChild(opt)
            }
            break;
        case "3":
            for (let i = 0; i < subject.Three.length; i++) {

                opt = document.createElement("option")
                opt.value = subject.Three[i]
                opt.textContent = subject.Three[i]
                select2.appendChild(opt)
            }
            break;
        case "4":
            if (select2.hasChildNodes()) {
                select2.remove(select2.childNodes);
            }
            for (let i = 0; i < subject.Four.length; i++) {

                opt = document.createElement("option")
                opt.value = subject.Four[i]
                opt.textContent = subject.Four[i]
                select2.appendChild(opt)
            }
            break;
        case "5":

            for (let i = 0; i < subject.Five.length; i++) {

                opt = document.createElement("option")
                opt.value = subject.Five[i]
                opt.textContent = subject.Five[i]
                select2.appendChild(opt)
            }
            break;
        case "6":

            for (let i = 0; i < subject.Six.length; i++) {

                opt = document.createElement("option")
                opt.value = subject.Six[i]
                opt.textContent = subject.Six[i]
                select2.appendChild(opt)
            }
            break;

    }


    //console.log(select.options[select.selectedIndex].value)
});

select2.addEventListener("change", e => {
    e.preventDefault();
    var m2 = select2.options[select2.selectedIndex].value;

    var div = document.createElement("div");
    div.classList.add("result-div");
    div.innerHTML = `<div class="header" style="width:100%; display:flex; flex-direction:column; justify-content:center; align-items:center"> <h1 align="center"> Create time table </h1><div class="main-div"><table border=1>
	<tr>
		<th>Class </th>
		<th> Date </th>
		<th>  Subject </th>
		<th> Time</th>
	</tr>
	<tbody>
		<tr>
			<td>` + select.options[select.selectedIndex].value + `</td>\
			<td>` + d.getDate() + ` ` + monthMaking() +
        `</td>
		
			<td>` + select2.options[select2.selectedIndex].value + `</td>
			<td><input type="text" id="getTime" onchange="checkTime()" placeholder="Enter time"/></td>
		</tr>
		<tr>
		
			<tr style="width:100%; display:flex; justify-content:center; align-items:center;">
			<td><button id="save" ><a href="Manage_class.jsp">Save</a></button></td>
		</tr>
		</tr>
		
	</tbody>
	</table>
	</div>`;
    console.log(select.options[select.selectedIndex].value, select2.options[select2.selectedIndex].value)
    document.body.appendChild(div);
    select2.disabled = true;
});

function checkTime() {
    var gt = document.getElementById("getTime");
    var g = gt.value;
    if (g.charAt(2) != ":") {
        gt.style.border = "1px solid red";
        gt.value = "";
    } else {
        gt.style.border = "none";
    }
}


function showFinalReport() {
    var v = document.getElementById("getTime");
    if (v.value == "" || v.value == " ") {
        v.style.border = "1px solid red";
        alert("cannot generate the report please clear the error and then try");
    } else {
        var div = document.createElement("div");
        div.innerHTML = `
			<div>
				<h1 align="center">
					Final Report
				</h1>
				<table border=1>
					<thead>
					<tr>
						<th><bold>Class </bold></th>
						<th><bold>Subject </bold></th>
						<th><bold>Date </bold></th>
						<th><bold>Time </bold></th>
						</tr>
					</thead>
					<tbody>
						<tr><td>` + select.options[select.selectedIndex].value + `</td>
						<td>` + select2.options[select2.selectedIndex].value + `</td>
						<td>` + d.getDate() + ` ` + monthMaking() + `</td>
						<td>` + document.getElementById("getTime").value + `</td></tr>
					</tbody>
				</table>
			</div>
		`;
        document.body.appendChild(div);
    }
}