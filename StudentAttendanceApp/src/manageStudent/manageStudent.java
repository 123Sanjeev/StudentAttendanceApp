package manageStudent;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class manageStudent
 */
@WebServlet("/manageStudent")
public class manageStudent extends HttpServlet {
	private static final long serialVersionUID = 1L;
     
    public manageStudent() {
        super();
        // TODO Auto-generated constructor stub
    }
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
		
		Connection conn = null;
		PreparedStatement ps = null;		
		try {
			
			String id  = null;
			
			
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://192.168.0.173:3306/studentmangementsystem", "sanjeev", "sanjeev@123");
			ps = conn.prepareStatement(" select ");
			ps.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		
	}

}
