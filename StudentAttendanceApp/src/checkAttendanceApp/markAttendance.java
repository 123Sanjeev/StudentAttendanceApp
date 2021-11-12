package checkAttendanceApp;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class markAttendance
 */
@WebServlet("/markAttendance")
public class markAttendance extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public markAttendance() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int count = 0;
		String cls = request.getParameter("value");
		try (PrintWriter out = response.getWriter()) {
			Class.forName("com.mysql.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Studentmangementsystem",
					"sanjeev", "sanjeev@123");
			PreparedStatement ps = conn.prepareStatement(
					"select std_id , concat(firstname, lastname) as studentname, currClass, section from studentlogin where currClass = '"
							+ cls + "'");
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				count++;
				out.print("<tr scope='col'><td scope='row'><input type='text' name='userid' value='" + rs.getString(1)
						+ "' /></td><td scope='row'><input type='text' name='studentname' value='" + rs.getString(2)
						+ "' /></td><td scope='row'> <input type='text' name='class' value='" + rs.getString(3)
						+ "' /> </td><td scope='row'><input type='text' name='section' value='" + rs.getString(4)
						+ "' /></td><td scope='row'><input type='checkbox' name='attendance' /></td></tr>");

			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
