package manageStudent;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import StudentLogin.connectionDBPool;

/**
 * Servlet implementation class searchStudent
 */
@WebServlet("/searchStudent")
public class searchStudent extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public searchStudent() {
		super();
		// TODO Auto-generated constructor stub
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		String values = request.getParameter("value");
		String a = request.getParameter("a");
		PreparedStatement ps = null;
		Connection conn = null ;
		int count = 0;
		try {
			conn = new connectionDBPool().dbpoolConnection();
			PrintWriter out = response.getWriter();
			if (a != null) {
				PreparedStatement ps2 = conn.prepareStatement("select * from studentlogin where std_id = '" + a + "'");
				ResultSet rs2 = ps2.executeQuery();
				while (rs2.next()) {
					out.print(rs2.getString(1));
				}
			} else if (a == null) {

				ps = conn.prepareStatement(
						"select std_id, firstname,lastname, date_of_admission, DOB,currClass, section from studentlogin where std_id like '%"
								+ values + "%'");
				ResultSet rs = ps.executeQuery();
				out.print("<section>");
				while (rs.next()) {
					String output = "<tr>\n<td scope='row'> <a href='javascript:void(0)' onclick='openRecord(`rdata`,`Profiles/people.jsp`,this.textContent)'>" + rs.getString(1)
					+ "</a> </td>\n <td scope='row'>" + rs.getString(2) + " </td>\n <td scope='row' >" + rs.getString(3) + "</td> \n<td scope='row'>"
					+ rs.getString(4) + " </td>\n<td scope='row'>" + rs.getString(6) + "</td> \n<td scope='row'>" + rs.getString(5)
					+ "</td>\n <td scope='row'>" + rs.getString(7) + "</td>\n</tr>";
					System.out.println(output.replaceAll("_", "").trim());
					out.print(output.trim()+"\n");
				}
				out.print("</section>");
			}
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				conn.close();
			}catch(Exception e) {
				e.printStackTrace();
			}
			
		}
	}

}
