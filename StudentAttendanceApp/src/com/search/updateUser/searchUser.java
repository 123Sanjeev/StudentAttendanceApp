package com.search.updateUser;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class searchUser {

	static Connection conn = null;
	static PreparedStatement ps = null;
	static ResultSet rs = null;

	private static Connection driverload() {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://192.168.0.173:3306/Studentmangementsystem", "sanjeev",
					"sanjeev@123");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return conn;
	}

	public static List searchUserRout(HttpServletRequest request, HttpServletResponse response, String... ar) {

		List<String> outData = new ArrayList<String>();

		try {
			Connection con = driverload();
			String sclass = ar[0];
			String aDate = ar[1];
			String section = ar[2];
			String sql = "select distinct class, section, attendance_date from attendance where ";
			if (sclass.isEmpty() != true && aDate.isEmpty() && section.isEmpty()) {
				sql += "class=?";
				ps = con.prepareStatement(sql);
				ps.setString(1, sclass);
			}
			rs = ps.executeQuery();
			while (rs.next()) {
				outData.add(rs.getString(1));
				outData.add(rs.getString(2));
				outData.add(rs.getString(3));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return outData;
	}

	public static List openrecord(HttpServletRequest request, HttpServletResponse response, String val) {
		List<String> outData = new ArrayList<String>();
		try {
			Connection con = driverload();
			String sql = "select * from attendance where class=?";
			ps = con.prepareStatement(sql);
			ps.setString(1, val);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				outData.add("<tr><td><input type='text' value='" + rs.getString(3) + "'/></td>");
				outData.add("<td><input type='text' value='" + rs.getString(2) + "'/></td>");
				outData.add("<td><input type='text' value='" + rs.getString(4) + "'/></td>");
				outData.add("<td><input type='text' value='" + rs.getString(5) + "'/></td>");
				if (rs.getInt(6) == 1) {
					outData.add("<td><input type='checkbox' checked/></td></tr>");
				} else {
					outData.add("<td><input type='checkbox' /></td></tr>");
				}
				System.out.println(rs.wasNull());
				if(rs.wasNull()) {
					outData.add("<td>No record found..</td>");
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return outData;
	}
}
