package StudentLogin;

import java.sql.*;
import javax.sql.DataSource;
import javax.naming.InitialContext;

public class connectionDBPool {	

	public Connection dbpoolConnection() throws Exception {
		InitialContext ctx = new InitialContext();
		DataSource ds = (DataSource) ctx.lookup("java:/comp/env/jdbc/UsersDB");
		Connection conn = ds.getConnection();
		return conn;
	}
}
