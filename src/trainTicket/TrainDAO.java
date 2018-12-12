package trainTicket;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
public class TrainDAO {
	public static Train findTrain(int trainNo) throws ClassNotFoundException {
		//connect to db
		try {
			Connection conn=DbUtil.getConnection();
			Statement state=conn.createStatement();
			ResultSet rs=state.executeQuery("select * from TRAINS where TRAIN_NO="+trainNo);
			Train t=null;
			while(rs.next()) {
				t=new Train(rs.getInt(1),rs.getString(2),rs.getString(3),rs.getString(4),rs.getDouble(5));
			}
			conn.close();
			return t;
		}
		catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	
	public static List<Train> findTrains(String source,String dest){
		try {
			Connection conn=DbUtil.getConnection();
			Statement state=conn.createStatement();
			ResultSet rs=state.executeQuery("select * from TRAINS where SOURCE='"+source+"' AND DESTINATION='"+dest+"'");
			ArrayList<Train>trains=new ArrayList<>();
			while(rs.next()) {
				Train t=new Train(rs.getInt(1),rs.getString(2),rs.getString(3),rs.getString(4),rs.getDouble(5));
				trains.add(t);
			}
			DbUtil.closeConnection(conn);
			return trains;
		}
		catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
}
