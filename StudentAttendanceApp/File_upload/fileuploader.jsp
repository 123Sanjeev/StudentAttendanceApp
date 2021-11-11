<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>File Uploader</title>
</head>
<body>

	<%@include file="../navbar.jsp"%>

	<form action="../fileHandler" enctype="multipart/form-data"
		method="post">
		File: <input type="file" name="file" id="file" /><input type="hidden"
			value="../uploadedfiles/" name="destination" /> </br> <input
			type="submit" value="Upload" name="upload" id="upload" /> </br> <input
			type="hidden" name="uploader"
			value="<%out.print(session.getAttribute("USERID"));%>" />

	</form>



</body>
</html>