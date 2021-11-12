package modules;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import StudentLogin.connectionDBPool;

import java.util.ArrayList;
import java.util.HashMap;

/**
 * Servlet implementation class customModules
 */
@WebServlet("/customModules")
public class customModules extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public customModules() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		PrintWriter out = response.getWriter();
		HttpSession session = request.getSession();
		ArrayList<String> modulesNamesList = null;
		ArrayList<String> appNamesList = null;
		HashMap<String, String> h = new HashMap<>();
		try {
			modulesNamesList = Modules.getModName(new connectionDBPool().dbpoolConnection());
			for (String mod : modulesNamesList) {
			//	out.print(mod);
				appNamesList = Modules.getAppName(new connectionDBPool().dbpoolConnection(), mod);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	
		// h.put(modulesNamesList, appNamesList);
	
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
