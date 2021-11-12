package request;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import StudentLogin.connectionDBPool;

public class rowUpdate {

	public static String updateRow(int id, String status) throws Exception {
		String result = "working";
		Connection conn = null;
		PreparedStatement ps = null;
		PreparedStatement ps1 = null;
		String query = null;
		String query1 = null;
		int rs = 0;
		int rs2 = 0;
		try {
			conn = new connectionDBPool().dbpoolConnection();
			if (status == "APPR" || status == "CLOSED") {
				query1 = "update studentlogin set valid_user=0 where std_id in (select distinct request_from from request where id='"
						+ id + "')";
				query = "update request set status =? where id='" + id + "'";
				ps = conn.prepareStatement(query);
				ps1 = conn.prepareStatement(query1);
				ps.setString(1, status);
				rs = ps.executeUpdate();
				rs2 = ps1.executeUpdate();
			} else {
				query = "update request set status =? where id='" + id + "'";
				ps = conn.prepareStatement(query);
				ps.setString(1, status);
				rs = ps.executeUpdate();
			}

			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		if (rs == 1) {
			try {
				conn = new connectionDBPool().dbpoolConnection();
				PreparedStatement ps2 = conn.prepareStatement("select status from request where id='" + id + "'");
				ResultSet rs1 = ps2.executeQuery();
				while (rs1.next()) {
					result = rs1.getString(1);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else {
			result = "Error occured";
		}
		return result;
	}

}
