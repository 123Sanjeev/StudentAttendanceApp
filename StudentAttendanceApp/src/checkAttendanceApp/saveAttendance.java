package checkAttendanceApp;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.DriverManager;
import java.util.ArrayList;
import java.util.List;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/saveAttendance")
public class saveAttendance extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public saveAttendance() {
		super();

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {


		//int recordCount = Integer.parseInt(request.getParameter("recordcount"));
		String id[] = request.getParameterValues("userid");
		String section[] = request.getParameterValues("section");
		String cls[] = request.getParameterValues("class");
		List<String> attendance= new ArrayList<String>();
		
		String attendanceStatus[] = request.getParameterValues("attendance");
		//System.out.println(cls.length + " " +section.length + " " + cls.length +  " " + attendanceStatus.length  );
		try (PrintWriter out = response.getWriter()) {
			Class.forName("com.mysql.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.0.173:3306/Studentmangementsystem",
					"sanjeev", "sanjeev@123");
			int res = 0;
			for(int i =0; i<attendanceStatus.length; i++) {
				//System.out.print(attendanceStatus[i]);
				if(attendanceStatus[i] == "on") {
					attendance.add(attendanceStatus[i]);
				}
			}
			System.out.println(attendance.size());
			for (int i = 0; i <id.length; i++) {
					if(attendance.size() < id.length) {
						attendance.add("off");
					}
				PreparedStatement ps = conn.prepareStatement(
						"insert into attendance(class, studentid, section , attendance_status) values(?,?,?,?)");

				ps.setString(1, cls[i]);
				ps.setString(2, id[i]);
				ps.setString(3, section[i]);
				if(attendance.get(i).equals("on")) {
					ps.setInt(4, 1);
				}else if(attendance.get(i).equals("off")) {
					ps.setInt(4, 0);
				}else {
					out.print("<script>alert('wrong value is passed!...')</script>"+ attendance.get(i));
				}
				
				
				/*if (attendanceStatus[i].equals("1")) {
					ps.setInt(4, 1);
				} else {
					ps.setInt(4, 0);
				}*/
				res = ps.executeUpdate();
			}
			if (res == 1) {
				out.print("<script>alert('record saved successfully') </script>");
				response.sendRedirect(
						"http://192.168.0.173:8081/StudentAttendanceApp/Manage/class_Attendace/attendance.jsp");

			} else {
				out.print("<script>alert('record not saved') </script>");
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
