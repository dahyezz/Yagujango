package dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import dao.face.MemberDao;
import dbutil.DBConn;
import dto.Member;

public class MemberDaoImpl implements MemberDao{
	
	//DB 관련 객체
	private Connection conn = DBConn.getConnection();
	private PreparedStatement ps;
	private ResultSet rs;	

	@Override
	public int selectCntMemberByUserid(Member member) {
		
		String sql = "";
		sql += "SELECT count(*) FROM member"; 
		sql += " WHERE userid = ? ";
		sql += " AND userpw = ?";
		
		int cnt = 0;

		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, member.getUserid());
			ps.setString(2, member.getUserpw());
			
			rs = ps.executeQuery();
			
			rs.next();
			cnt = rs.getInt(1);
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return cnt;
	}

	@Override
	public Member selectMemberByUserid(Member member) {
		
		String sql = "";
		sql += "SELECT userno, userid, userpw, username, usernick, birth, gender, phone, email, penalty, myteam";
		sql += " FROM member";
		sql += " WHERE userid = ?";
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, member.getUserid());
			rs = ps.executeQuery();
			
			while(rs.next()) {
				member.setUserno(rs.getInt("userno"));
				member.setUserid(rs.getString("userid"));
				member.setUserpw(rs.getString("userpw"));
				member.setUsername(rs.getString("username"));
				member.setUsernick(rs.getString("usernick"));
				member.setBirth(rs.getDate("birth"));
				member.setGender(rs.getString("gender"));
				member.setPhone(rs.getString("phone"));
				member.setEmail(rs.getString("email"));
				member.setPenalty(rs.getInt("penalty"));
				member.setMyteam(rs.getString("myteam"));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return member;
	}

}
