package fileHandler;

import java.io.File;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import org.apache.tomcat.util.http.fileupload.FileItem;
import org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory;
import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;

import java.sql.*;
import java.util.Iterator;

/**
 * Servlet implementation class uploadfile
 */

@WebServlet("/fileHandler")

@MultipartConfig
public class fileHandler extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Connection conn;
	PreparedStatement ps;
	ResultSet rs;
	
	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset-UTF-8");
		HttpSession session = request.getSession();
		try (PrintWriter out = response.getWriter()) {
			Part p = request.getPart("file");
			String fileName = p.getSubmittedFileName();
			String path = "F:\\ECLIPSE\\StudentAttendanceapp\\StudentAttendanceApp\\WebContent\\uploadedfiles/"
					+ fileName;
			String destination  = request.getParameter("destination");
			String uploaderId = request.getParameter("uploader");
			System.out.println(uploaderId);
			// String storeLocation =
			out.print(path);
			InputStream in = p.getInputStream();

			boolean res = uploadfiles(in, path);
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://192.168.0.173:3306/fileSystem", "sanjeev", "sanjeev@123");
			ps = conn.prepareStatement("insert into file_storage(file_name,file_path, uploaded_by) values(?,?,?)");
			ps.setString(1, fileName);
			ps.setString(2,destination);
			ps.setInt(3, Integer.parseInt(uploaderId));
			int result = ps.executeUpdate();
			if (result != 0) {
				if (res) {
					out.print("<script>alert('File Uploaded successfully');</script> ");
					String site = new String("../StudentAttendanceApp/Study_zone_content/education_material.jsp");
					response.setStatus(response.SC_MOVED_TEMPORARILY);
					response.setHeader("Location", site);
				} else {
					out.print("<script>alert('file not uploaded successfully')</script>");
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public boolean uploadfiles(InputStream in, String path) {
		boolean test = false;
		try {
			byte[] b = new byte[in.available()];
			in.read();
			FileOutputStream o = new FileOutputStream(path);
			o.write(b);
			o.flush();
			o.close();

			test = true;
			System.out.println("result 1= " + test);

		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println("Result 2= " + test);
		return test;
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		processRequest(request, response);
	}
}
