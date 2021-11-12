package Login;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class sessionMgmt
 */
@WebServlet("/sessionMgmt")
public class sessionMgmt extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public sessionMgmt() {
		super();
		// TODO Auto-generated constructor stub
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String uid = request.getParameter("userid");
		try (PrintWriter out = response.getWriter()) {
			Class.forName("com.mysql.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.0.173:3306/studentmangementsystem",
					"sanjeev", "sanjeev@123");

			PreparedStatement ps = conn.prepareStatement("select * from logintrack where u_id ='" + uid + "'");
			ResultSet rs = ps.executeQuery();
		
			while (rs.next()) {
				int sessionsCount = rs.getInt((1));
				if (rs.getString(5) == null) {
					out.print("invalid session");
					response.setStatus(response.SC_MOVED_TEMPORARILY);
					response.setHeader("Location",
							"Logout.jsp?=userSession is incorrectly set");
				}
				
				
				if (sessionsCount > 1) {
					out.print("<p>session count is more than norma Session count: " + sessionsCount + "</p>");
				} else {
					out.print(sessionsCount);
				}
			}

		} catch (Exception e) {
			e.printStackTrace();

		}

	}

}
