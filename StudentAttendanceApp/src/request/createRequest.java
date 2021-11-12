package request;

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
 * Servlet implementation class createRequest
 */
@WebServlet("/createRequest")
public class createRequest extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public createRequest() {
		super();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);

		System.out.println("Request came here");

		String reqType = request.getParameter("reqType");
		System.out.println(reqType);
		String rowId = request.getParameter("rowId");
		System.out.println(rowId);
		String status = request.getParameter("currentStatus");
		if (reqType != null) {
			if (reqType.equals("rowUpdate")) {
				try (PrintWriter out = response.getWriter()) {
					out.print(rowUpdate.updateRow(Integer.parseInt(rowId), status));
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		} else {

			try (PrintWriter out = response.getWriter()) {
				int seed = 0;
				boolean requestExist = false;
				int REQUESTER_ID = Integer.parseInt(request.getParameter("reportedby"));
				Connection conn = new connectionDBPool().dbpoolConnection();
				Statement stmt = conn.createStatement();
				Statement stmt2 = conn.createStatement();
				ResultSet rs2 = stmt2.executeQuery("select 1 from request where request_from ='" + REQUESTER_ID
						+ "' and status not in ('RESOLVED','CLOSED')");
				while (rs2.next()) {
					if (rs2.getInt(1) == 1) {
						requestExist = true;
					}
				}
				if (requestExist) {
					out.print("Request has already exist for the current user");
				} else {
					ResultSet rs = stmt.executeQuery("select max(id) from request");
					while (rs.next()) {
						seed = rs.getInt(1) + 1;
					}
					PreparedStatement ps = conn.prepareStatement(
							"insert into request(id, request_type,description,request_from, owner,status) values(?,?,?,?,?,?)");
					ps.setInt(1, seed);
					ps.setString(2, "A_BLC");
					ps.setString(3, "Account unlock request");
					ps.setInt(4, REQUESTER_ID);
					ps.setInt(5, 100001);
					ps.setString(6, "PENDING");
					int result = ps.executeUpdate();
					if (result != 1) {
						out.print("Request not submitted");
					} else {
						out.print("Request submitted your request id is: " + seed);
					//	out.print("<a href='192.168.0.173:8081/StudentAttendanceApp/Logout.jsp'>Log out</a>");
					}
				}
				// out.print(REQUESTER_ID);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
}
