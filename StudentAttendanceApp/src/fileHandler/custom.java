package fileHandler;

import java.sql.*;
public class custom {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		int time = 0;
		 try{
	            Connection con = null;
	            Class.forName("com.mysql.jdbc.Driver");
	            con = DriverManager.getConnection("jdbc:mysql://192.168.0.173:3306/performance_schema","sanjeev","sanjeev@123");
	            PreparedStatement stmt = con.prepareStatement("show processlist");
	            ResultSet rs = stmt.executeQuery();
	            while(rs.next()){
	                System.out.println(rs.getString(1) + " " + rs.getString(6));
	                time = rs.getInt(6);
	                if(time > 100) {
		            	PreparedStatement ps = con.prepareStatement("kill " + rs.getString(1));
		            	ps.executeUpdate();
		            }
	            }
	            
	        }catch(Exception e){
	                e.printStackTrace();
	        }
	}

}
