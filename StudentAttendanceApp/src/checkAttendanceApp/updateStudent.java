package checkAttendanceApp;

import java.io.IOException;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import com.search.updateUser.searchUser;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class updateStudent
 */
@WebServlet("/updateStudent")
public class updateStudent extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public updateStudent() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	@SuppressWarnings("unchecked")
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String id = request.getParameter("appid");
		String val = request.getParameter("val");
		String cls = request.getParameter("class");
		String atndate = request.getParameter("atndDate");
		String sec = request.getParameter("section");
		List<String> result = new ArrayList<String>();
		try (PrintWriter out = response.getWriter()) {
			if (id.equals("searchUapp")) {
				// searchUser user = new searchUser();
				result = searchUser.searchUserRout(request, response, cls, atndate, sec);
				out.print("<tr><td><a href='javascript:void(0)' onclick='openRecord(`target`,`Manage/manageAttendance/openMRecord.jsp`,this.textContent)'>"
						+ result.get(0) + "</a></td><td>" + result.get(1) + "</td><td>" + result.get(2) + "</td></tr>");
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
