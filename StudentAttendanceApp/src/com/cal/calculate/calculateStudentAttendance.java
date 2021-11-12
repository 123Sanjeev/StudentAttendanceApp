package com.cal.calculate;

import java.util.*;
import java.sql.*;
import StudentLogin.connectionDBPool;

public class calculateStudentAttendance {
	List<String> calculation = new ArrayList<String>();

	public List calculate(String val) {

		try (Connection conn = new connectionDBPool().dbpoolConnection()) {
		PreparedStatement ps = conn.prepareStatement("select studentid,count(studentid) from attendance where class = ? group by studentid");
		ps.setString(1, val);
		ResultSet rs= ps.executeQuery();
		while(rs.next()) {
			calculation.add(rs.getString(0));
		}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return calculation;
	}
}
