package checkAttendanceApp;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class checkAttendance
 */
@WebServlet("/checkAttendanceApp")
public class checkAttendanceApp extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public checkAttendanceApp() {
        super();
    }
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		int v =Integer.parseInt(request.getParameter("selectedvalue"));
	
		try {
			PrintWriter out = response.getWriter();
		System.out.println("value form response: "+v);
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/studentmangementsystem", "sanjeev","sanjeev@123");
		ps = conn.prepareStatement("select section from sections");
		rs =  ps.executeQuery();
		while(rs.next()) {
			out.print("<option value='"+rs.getString(1)+"'>"+rs.getString(1)+"</option>");
		}
		}catch(Exception e) {
			e.printStackTrace();
		}
	}

}
