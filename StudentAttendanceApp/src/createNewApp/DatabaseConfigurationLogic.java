package createNewApp;

import java.sql.*;
import java.io.*;
import StudentLogin.connectionDBPool;

public class DatabaseConfigurationLogic {

	DatabaseConfigurationLogic(String DatabaseName, PrintWriter writer) {
		try (PrintWriter out = writer) {
			Connection conn = new connectionDBPool().dbpoolConnection();
			PreparedStatement ps = conn
					.prepareStatement("select * from information_schema.columns where table_name = ?");
			ps.setString(1, DatabaseName);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				out.print("<tr><td><input type='text' value='" + rs.getString(3)
						+ "'/></td><td><input type='text' value='" + rs.getString(2)
						+ "' /></td><td><input type='text' value='" + rs.getString(4) + "' /></td></tr>");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
