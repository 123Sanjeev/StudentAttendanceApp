package Login;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.SQLException;
public class loginConnection {

	public Connection ConLogin() throws NamingException, SQLException {
		InitialContext  ctx = new InitialContext();
		DataSource ds = (DataSource) ctx.lookup("java:/comp/env/jdbc/loginDb");
		Connection conn = ds.getConnection();
		return conn;
	}
}
