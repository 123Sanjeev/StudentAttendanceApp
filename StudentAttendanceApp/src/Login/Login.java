package Login;

import java.io.IOException;

import Login.loginConnection;
import StudentLogin.connectionDBPool;
import dataSync.*;
import jdbcConnection.jdbcListennerClass;
import java.io.PrintWriter;
import java.sql.DriverManager;
import java.sql.Connection;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 * Servlet implementation class Login
 */
@WebServlet("/Login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		final String jpbcDriver = "com.mysql.jdbc.Driver";
		int Res_ID;
		String Res_Name;
		final String err = "Wrong user credentials";
		HttpSession session = request.getSession();
		String userid = request.getParameter("userid");
		String pass = request.getParameter("pass");
		PrintWriter out = response.getWriter();

		Connection conn2 = null;
		PreparedStatement s = null;

		try (Connection conn =  new loginConnection().ConLogin()) {
			// Class.forName(jpbcDriver);
			// conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/loginPortal",
			// "sanjeev", "sanjeev@123");

			PreparedStatement ps = conn.prepareStatement(
					"select user_id, first_name,last_name,user_type, valid_user from userdb where USER_ID=? and USER_Pass = ?");
			ps.setString(1, userid);
			ps.setString(2, pass);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				Res_ID = rs.getInt(1);
				out.print(Res_ID);
				Res_Name = rs.getString(2) + " " + rs.getString(3);
				out.print(Res_Name);
				// Res_Name = rs.getString(1) + rs.getString(2);
				session.setAttribute("USERID", Res_ID);
				session.setAttribute("USERNAME", Res_Name);
				session.setAttribute("USERTYPE", rs.getString(4));
				session.setAttribute("VALID_CHECK", rs.getInt(5));
				Cookie username = new Cookie("userid", userid);
				// username.
				conn2 = new connectionDBPool().dbpoolConnection();
				s = conn2.prepareStatement("insert into logintrack values(null, '" + Res_ID + "', now(), now(), '"
						+ session.getId() + "')");
				s.execute();
				response.addCookie(username);
				String site = response.encodeRedirectURL(
						"Home_page/Home.jsp?=" + "status=" + response.getStatus() + "sessionid=" + session.getId());
				response.sendRedirect(site);
				session.setMaxInactiveInterval(3000);
				datasyncbtwtables d = new datasyncbtwtables();
				d.syncMydata();
				// response.setStatus(response.SC_MOVED_TEMPORARILY);
				// response.setHeader("Location", site);
			} else {
				session.setAttribute("ERR", err);
				String site = new String("/StudentAttendanceApp/");

				response.setStatus(response.SC_MOVED_TEMPORARILY);
				response.setHeader("Location", site);
			}
			conn.close();
			ps.close();
		} catch (Exception e) {
			e.printStackTrace();
			out.println("<p>" + e + "</p>");
		} finally {
			try {
				if (conn2 != null) {
					conn2.close();
					s.close();
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 * 
	 *      protected void doPost(HttpServletRequest request, HttpServletResponse
	 *      response) throws ServletException, IOException { // TODO Auto-generated
	 *      method stub doGet(request, response); }
	 */

}
