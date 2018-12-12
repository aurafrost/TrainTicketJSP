package trainTicket;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DbUtil {
	private static String DRIVER_NAME="jdbc:oracle:thin:";
	private static String DB_URL="@localhost";
	private static String USERNAME="hr";
	private static String PASSWORD="hr";
	public static Connection getConnection() {
		try {
			Class.forName("oracle.jdbc.OracleDriver");
			Connection conn=DriverManager.getConnection(DRIVER_NAME+DB_URL,USERNAME,PASSWORD);
			return conn;
		}
		catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	public static void closeConnection(Connection c) throws SQLException {
		c.close();
	}
}
