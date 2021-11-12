package createNewApp;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import createNewApp.createAppLogic;
import createNewApp.DatabaseConfigurationLogic;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class createNewApp
 */
@WebServlet("/createNewApp")
public class createNewApp extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public createNewApp() {
		super();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String appReq = request.getParameter("appId");
		PrintWriter out = response.getWriter();
		if (appReq.equals("applicationDesigner")) {
			String appName = request.getParameter("APP_name");
			System.out.println(appName);
			String appTitle = request.getParameter("APP_title");
			String module = request.getParameter("module");
			System.setProperty("user.dir", "F:/ECLIPSE\\StudentApp\\StudentAttendanceApp\\WebContent\\"+ module);
			String userdir = System.getProperty("user.dir");
			String user = request.getParameter("u_lg");
			try {
				File dir = new File(userdir);
				new createAppLogic(appName, appTitle,dir,module, user);
				response.sendRedirect("http://192.168.0.173:8081/StudentAttendanceApp/Application Designer/Application_Designer.jsp");
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(appReq.equals("DatabaseConfig")){
			String dbname =  request.getParameter("dbname");
			new DatabaseConfigurationLogic(dbname,out);
		}else {
			//response.sendError(0,"Invalid application");	
			response.sendRedirect("http://192.168.0.173:8081/StudentAttendanceApp/Application Designer/Application_Designer.jsp");
		}
		out.close();
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
