<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<style>
* {
	margin: 0px;
	padding: 0px;
	box-sizing: border-box;
}

.toolbar {
	position:absolute;
	left:0px;
	top:10px;
	width: 300px;
	height: 90vh;
}

.nav {
	display: flex;
	flex-direction: row;
	justify-content: center;
	align-items: center;
}

.nav li a {
	color: white !important;
}

a {
	color: black;
	text-decoration: none;
	font-style: calibri;
}

.userdetails {
	outline: 1;
	overflow: auto;
	height: 80vh;
}

thead {
	width: 100%;
}

th {
	border: 1px solid black;
	padding: 5px;
}

td a {
	color: black !important;
	text-decoration: none;
	text-align: center;
}

td {
	border: 1px solid black;
	padding: 5px;
}

.drop-down {
	display: none;
	position: absolute;
	width: 200px;
	height:auto;
	left: 200px;
	top: 0px;
	z-index:100;
}

.drop-down li {
	width: 100% !important;
	
}

.parent {
	cursor: pointer;
}

.parent:after {
	content: ">";
	position: absolute;
	right: 0px;
	font-weight: bolder;
}

.parent:hover .drop-down {
	display: revert;
	cursor: pointer;
}

.parent:hover .parent:after {
	content: "<";
	position: absolute;
	right: 0px;
	font-weight: bolder;
}
</style>
<body>
<%@page import="java.sql.*"%>
<%@page import="StudentLogin.connectionDBPool"%>
<%@page import="java.util.*"%>
	<div class="toolbar d-flex flex-column" id="tab">
			<h4 class="list-group-item text-center bg-success text-white">Content</h4>
			
	<ul class="list-group" id="menu">
				<%
				Set<String> mod = new HashSet<String>();
				
				ArrayList<String> app = new ArrayList<>();
				try (Connection urlMapping = new connectionDBPool().dbpoolConnection()) {
					PreparedStatement url = urlMapping.prepareStatement(
					"select distinct(module), concat(module,',',appName,',',srcUrl) from optionMenu group by module, appName order by module");
					ResultSet rsurl = url.executeQuery();
					while (rsurl.next()) {
						mod.add(rsurl.getString(1));
						if (rsurl.getString(2).contains(rsurl.getString(1))) {
					app.add(rsurl.getString(2));
						}
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
				ArrayList<String> mod2 = new ArrayList<String>(mod);
				Collections.sort(mod2);

				Collections.sort(app);
				for (String m : mod2) {
					out.print("<li class='parent list-group-item'> " + m + "<ul class='drop-down list-group'> ");
					for (String a : app) {
						if (a.split(",")[0].contains(m)) {
					out.print("<li class='list-group-item'><a href='" + a.split(",")[2] + "'>" + a.split(",")[1] + "</a></li>");
						}
					}
					out.print("</ul></li>");
				}
				%>
			</ul>
			</div>
	
</body>
</html>