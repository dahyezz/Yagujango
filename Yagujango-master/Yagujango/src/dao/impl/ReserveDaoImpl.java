package dao.impl;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dao.face.ReserveDao;
import dbutil.DBConn;
import dto.Match;
import dto.Stadium;

public class ReserveDaoImpl implements ReserveDao {
	//DB관련 객체
	private Connection conn = DBConn.getConnection(); 

	private PreparedStatement ps = null;
	private ResultSet rs = null;
	
	@Override
	public List<Stadium> selectName() {
		String sql = "";
		sql += "SELECT * FROM stadium";
		
		List list = new ArrayList();
		
		try {
			ps = conn.prepareStatement(sql);
			
			rs = ps.executeQuery();
			
			while( rs.next()) {
				Stadium stadium = new Stadium();
				
				stadium.setStadium_code(rs.getInt("stadium_code"));
				stadium.setStadium_name(rs.getString("stadium_name"));
				stadium.setStadium_logo(rs.getString("stadium_logo"));
				
				list.add(stadium);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			try {
				// 자원 해제
				if(rs!=null)	rs.close();
				if(ps!=null)	ps.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return list;
	}
	
	@Override
	public List<Match> selectAllByStadiumcode() {
		String sql = "";
		sql += "SELECT match.hometeam_code, stadium.stadium_name, match.match_code, match.match_date, match.awayteam_code, match.highlight";
		sql += " FROM stadium";
		sql += " INNER JOIN match";
		sql += " ON stadium.stadium_code = match.hometeam_code";
		return null;
	}

}
