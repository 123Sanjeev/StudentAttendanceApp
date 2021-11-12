package checkAttendanceApp;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;

/**
 * Servlet implementation class showAttendance
 */
@WebServlet("/showAttendance")
public class showAttendance extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public showAttendance() {
		super();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		// response.getWriter().append("Served at: ").append(request.getContextPath());
		String v = request.getParameter("selectedValue");
		String c = request.getParameter("selectedSection");
		String custSearch = request.getParameter("id");
		String id = request.getParameter("studentid");
		String studentname = request.getParameter("studentname");
		String attendanceDate = request.getParameter("attendanceDate");
		String atndstatus = request.getParameter("attendanceStatus");
		Connection conn = null;
		PreparedStatement ps = null;
		try {
			PrintWriter out = response.getWriter();
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://192.168.0.173:3306/studentmangementsystem", "sanjeev",
					"sanjeev@123");
			String sql = "";
			if (custSearch != null) {
				sql = "select std_id,firstname, lastname, class ,studentlogin.section, attendance_date,attendance_status from studentlogin inner join attendance on std_id = studentid where ";
				// System.out.println(id = (id.isEmpty() ) ? "true" : "false");
				if (id.isEmpty() != true && studentname.isEmpty() && attendanceDate.isEmpty() && atndstatus.isEmpty()) {
					sql += "std_id =?";
					ps = conn.prepareStatement(sql);
					ps.setString(1, id);
				} else if (studentname.isEmpty() != true && attendanceDate.isEmpty() && atndstatus.isEmpty() && id.isEmpty()) {
					sql += "firstname=?";
					ps = conn.prepareStatement(sql);
					ps.setString(1, studentname);
				} else if (attendanceDate.isEmpty() != true && atndstatus.isEmpty() && id.isEmpty() && studentname.isEmpty()) {
					sql += "attendance_date=?";
					ps = conn.prepareStatement(sql);

					ps.setString(1, attendanceDate);
				} else if (atndstatus.isEmpty() != true  && id.isEmpty() && studentname.isEmpty() && attendanceDate.isEmpty()) {
					sql += "attendance_status=?";
					ps = conn.prepareStatement(sql);
					ps.setString(1, atndstatus);
				} else if (id.isEmpty() != true && studentname.isEmpty() != true && attendanceDate.isEmpty() != true
						&& atndstatus.isEmpty() != true) {
					sql += "std_id=? and firstname=? and attendance_date=? and attendance_status=?";

					ps = conn.prepareStatement(sql);
					ps.setString(1, id);
					ps.setString(2, studentname);
					ps.setString(3, attendanceDate);
					ps.setString(4, atndstatus);
				}
				System.out.println(sql);
			} else {
				sql = "select std_id,firstname, lastname, class ,studentlogin.section, attendance_date,attendance_status from studentlogin inner join attendance on std_id = studentid where class = (select class.curClass from class where class.id = ?)";
				ps = conn.prepareStatement(sql);
				ps.setInt(1, Integer.parseInt(v));
			}
			// ps = conn.prepareStatement("select std_id, firstname, lastname from
			// studentlogin inner join class on class.curClass = studentlogin.currClass
			// where class.id='"+ v + "' and section='" + c + "'");
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				if (rs.getInt(7) == 0) {
					out.print("<tr class='text-center'> <td class='text-dark' scope='row'>" + rs.getString(1)
							+ "</td> <td class='text-dark' scope='row'>" + rs.getString(2) + rs.getString(3)
							+ "</td><td class='text-dark' scope='row'>" + rs.getString(6)
							+ "</td>  <td class='text-dark' scope='row'><input type='checkbox' /></td></tr>");
				} else {
					out.print("<tr class='text-center'> <td class='text-dark' scope='row'>" + rs.getString(1)
							+ "</td> <td class='text-dark' scope='row'>" + rs.getString(2) + rs.getString(3)
							+ "</td> <td class='text-dark' scope='row'>" + rs.getString(6)
							+ "<td class='text-dark' scope='row'><input type='checkbox' value='1' checked /></td></tr>");
				}
				if(rs.wasNull()) {
					out.print("<tr class='text-center' style='color:red; width:100%; height:40px;'> <td class='text-dark' scope='row'>No records found</td></tr>");
					System.out.println("no record found");
				}
			}
			
			System.out.println(rs);
		} catch (Exception e) {
			e.printStackTrace();
		}

	}
}
