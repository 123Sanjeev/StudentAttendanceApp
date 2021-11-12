package jdbcConnection;

import java.sql.*;

public class jdbcListennerClass {

	final static String driver = "com.mysql.jdbc.Driver";
	final static String USER = "sanjeev";
	final static String passWord = "sanjeev@123";
	final static String host = "127.0.0.7:8080/";

	public static Connection conn(String db) throws Exception {
		Class.forName("com.mysql.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.0.173:3306/"+db, USER,
				passWord);
		return conn;
	}
}
