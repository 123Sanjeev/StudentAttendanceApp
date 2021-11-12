package modules;


import java.util.List;
import java.util.ArrayList;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.PreparedStatement;

public class Modules {


	
	public static ArrayList<String> getModName(Connection conn){
		ArrayList<String> modules = new ArrayList<>();
		try {
		PreparedStatement ps1 = conn.prepareStatement("select distinct(module) from optionmenu");
		ResultSet rs1 = ps1.executeQuery();
		while(rs1.next()) {
			modules.add(rs1.getString(1));
		}
		conn.close();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(conn.isClosed()!=true) {
					conn.close();
				}
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		
		return modules;
	}
	public static ArrayList<String> getAppName(Connection conn, String modName){
		ArrayList<String> appNames = new ArrayList<>();
		try {
			PreparedStatement ps1 = conn.prepareStatement("select distinct(appName) from optionmenu where module=?");
			ps1.setString(1, modName);
			ResultSet rs1 = ps1.executeQuery();
			while(rs1.next()) {
				appNames.add(rs1.getString(1));
			}
			conn.close();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(conn.isClosed()!=true) {
					conn.close();
				}
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		
		return appNames;
	}
}
