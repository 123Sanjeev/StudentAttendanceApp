package createNewApp;

import java.io.File;

import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import StudentLogin.connectionDBPool;
import java.sql.Connection;
import java.sql.PreparedStatement;

public class createAppLogic {

	createAppLogic(String AppName, String Apptitle, File dir,String module,String u_id) {

		File fileDir = dir;
		/*
		 * FileWriter out = null; try { out = new FileWriter(dir); } catch (IOException
		 * e1) { e1.printStackTrace(); }
		 */

		System.out.println(dir);
		if (!fileDir.isDirectory())	 {
			boolean fileCreated = fileDir.mkdir();
			if (fileCreated == true) {
				System.out.print("File created successfully");
			} else {
				System.out.print("File not created");
			}
		}
		if (fileDir.isDirectory()) {
			File createFile = new File(fileDir + "\\"+AppName.trim()+".jsp");
			try {
				FileWriter fs = new FileWriter(createFile);
				fs.write(
						"<%@ page language='java' contentType='text/html; charset=ISO-8859-1'pageEncoding='ISO-8859-1'%>\n<!DOCTYPE html>\n <html>\n<head>\n<title>\n"
								+ Apptitle + "\n</title>\n</head>\n<body>\nThis is test application\n</body>\n</html>");
				fs.close();
			} catch (Exception e) {

				e.printStackTrace();
			}
		}
try(Connection conn = new connectionDBPool().dbpoolConnection()) {
	int rs = 0;
	PreparedStatement ps = conn.prepareStatement("insert into optionmenu(appName,module,createdby, updatedby,srcUrl) value(?,?,?,?,?)");
	ps.setString(1, AppName);
	ps.setString(2, module);
	ps.setString(3,u_id);
	ps.setString(4, u_id);
	ps.setString(5, "http://192.168.0.173:8081/StudentAttendanceApp/"+module+"/"+AppName+".jsp");
	rs = ps.executeUpdate();
	if(rs == 1) {
		System.out.println("Application updated successfully");
	}else {
		System.out.println("Error exist in the application");
	}
}catch (Exception e) {
	e.printStackTrace();
}
	
	}
}
