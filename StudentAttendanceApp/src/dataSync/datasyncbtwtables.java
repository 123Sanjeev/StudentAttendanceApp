package dataSync;

import java.sql.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import StudentLogin.connectionDBPool;
import Login.loginConnection;

class synData {
	private int u_id;
	private String f_name;
	private String lastname;
	private Date doi;
	private int valid;

	synData(int u_id, String f_name, String lastname, Date doi, int valid) {
		this.u_id = u_id;
		this.f_name = f_name;
		this.lastname = lastname;
		this.doi = doi;
		this.valid = valid;
	}

	public int getU_id() {
		return u_id;
	}

	public void setU_id(int u_id) {
		this.u_id = u_id;
	}

	public String getF_name() {
		return f_name;
	}

	public void setF_name(String f_name) {
		this.f_name = f_name;
	}

	public String getLastname() {
		return lastname;
	}

	public void setLastname(String lastname) {
		this.lastname = lastname;
	}

	public Date getDoi() {
		return doi;
	}

	public void setDoi(Date doi) {
		this.doi = doi;
	}

	public int getValid() {
		return valid;
	}

	public void setValid(int valid) {
		this.valid = valid;
	}
}

public class datasyncbtwtables {

	static List<synData> data = new ArrayList<synData>();
	static List<synData> sync = new ArrayList<synData>();

	public static List<synData> getMydata() throws Exception {
		try (Connection conn = new loginConnection().ConLogin()) {

			PreparedStatement ps = conn.prepareStatement(
					"select user_id, first_name, last_name, date_of_imigration, valid_user from userdb where user_id not in (select userid from studentmangementsystem.adminDetails)");
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				data.add(new synData(Integer.parseInt(rs.getString(1)), rs.getString(2), rs.getString(3), rs.getDate(4),
						rs.getInt(5)));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return data;
	}

	public static void syncMydata() {
		try (Connection conn = new loginConnection().ConLogin()) {
			sync = getMydata();
			CallableStatement cmt = conn.prepareCall("call loginportal.dataSync(?,?,?,?,?)");
			for (synData d : sync) {
				cmt.setInt(1, d.getU_id());
				cmt.setString(2, d.getF_name());
				cmt.setString(3, d.getLastname());
				cmt.setDate(4, (java.sql.Date) d.getDoi());
				cmt.setInt(5, d.getValid());

				cmt.executeUpdate();
			}

			sync.removeAll(sync);
			System.out.println("Data synced");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
