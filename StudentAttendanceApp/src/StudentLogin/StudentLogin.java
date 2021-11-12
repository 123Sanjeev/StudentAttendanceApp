package StudentLogin;

import java.io.IOException;
import StudentLogin.connectionDBPool;
import jdbcConnection.jdbcListennerClass;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.PrintWriter;

/**
 * Servlet implementation class StudentLogin
 */
@WebServlet("/StudentLogin")
public class StudentLogin extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		final String err  = "Invalid user name password";
		HttpSession session = request.getSession();
		PrintWriter out = response.getWriter();
		String Std_name = request.getParameter("username");
		String Std_pass = request.getParameter("password");
		Connection conn2 = null;
		try {
			conn2 = new connectionDBPool().dbpoolConnection();
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		PreparedStatement s =null;
		try(Connection conn = new connectionDBPool().dbpoolConnection()) {
			//Class.forName("com.mysql.jdbc.Driver");
			//Connection conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/Studentmangementsystem",
				//	"sanjeev", "sanjeev@123");
			PreparedStatement ps = conn.prepareStatement("select Std_id,firstname,lastname, DOB, date_of_admission, valid_user from StudentLogin where Std_id = '"
					+ Std_name + "' and pass ='" + Std_pass + "'");
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				out.print(rs.getInt(1));
				session.setAttribute("USERID", rs.getInt((1)));
				session.setAttribute("USERNAME", rs.getString(2)+ " " + rs.getString(3));
				session.setAttribute("DateOFBirth", rs.getString(4));
				session.setAttribute("DateOFadmission", rs.getString(5));
				session.setAttribute("USERTYPE", "Student");
				session.setAttribute("VALID_CHECK",rs.getInt(6));
				Cookie username = new Cookie("userid", Std_name);
				s = conn2.prepareStatement("insert into logintrack values(null, '" + Std_name + "', now(), now(), '"
						+ session.getId() + "')");
				s.execute();
				response.addCookie(username);
				String site = response.encodeRedirectURL(
						"Home_page/StudentFrame.jsp?=" + "statius=" + response.getStatus() + "sessionid=" + session.getId());
				response.sendRedirect(site);
			} else {
				session.setAttribute("ERR", err);
				String site = new String("Student_portal_login/Std_login_port.jsp");
				response.setStatus(response.SC_MOVED_TEMPORARILY);
				response.setHeader("Location", site);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
