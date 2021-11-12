package dataSync;

import java.sql.*;
import java.util.Date;
import java.util.*;
class syncData {
	private int u_id;
	private String f_name;
	private String lastname;
	private Date doi;
	private int valid;

	syncData(int u_id, String f_name, String lastname, Date doi, int valid) {
		this.setU_id(u_id);
		this.setF_name(f_name);
		this.setLastname(lastname);
		this.setDoi(doi);
		this.setValid(valid);
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
public class demo {

	
	
	private static List<syncData> d = new ArrayList<>();
	public static void main(String[] args) {
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.0.173:3306/loginportal","sanjeev","sanjeev@123");
			PreparedStatement ps = conn.prepareStatement(
					"select user_id, first_name, last_name, date_of_imigration, valid_user from userdb");
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				d.add(new syncData(Integer.parseInt(rs.getString(1)), rs.getString(2), rs.getString(3), rs.getDate(4),rs.getInt(5)));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		for(syncData data : d) {
			System.out.println(data.getU_id());
		}
	}
	
}
