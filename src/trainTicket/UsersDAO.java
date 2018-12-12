package trainTicket;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class UsersDAO {
	public static User getUser(String name) throws SQLException {
		Connection conn=trainTicket.DbUtil.getConnection();
		Statement state=conn.createStatement();
		ResultSet rs=state.executeQuery("select * from REGD_USERS where USERNAME='"+name+"'");
		if(rs.next()) {
			String uName=rs.getString(1);
			String password=rs.getString(2);
			String email=rs.getString(3);
			User u=new User(uName,password,email);
			DbUtil.closeConnection(conn);
			return u;
		}
		else {
			return null;
		}
	}
	public static boolean insertUser(User user) throws SQLException {
		Connection conn=trainTicket.DbUtil.getConnection();
		try {
			String query="insert into REGD_USERS values(?,?,?)";
			PreparedStatement state=conn.prepareStatement(query);
			state.setString(1, user.getUsername());
			state.setString(2, user.getPassword());
			state.setString(3, user.getEmail());
			state.executeUpdate();
			conn.commit();
			DbUtil.closeConnection(conn);
			return true;
		}
		catch(Exception e) {
			return false;
		}
	}
}
