package dao.impl;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dao.face.MemberDao;
import dbutil.DBConn;
import dto.Member;
import util.Paging;

public class MemberDaoImpl implements MemberDao{
	
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
			
			while(rs.next()) {
				cnt=rs.getInt(1);
			}
			
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

	@Override
	public int selectCntMemberIdfind(Member member) {
		
		String sql = "";
		sql += "SELECT count(*) FROM member"; 
		sql += " WHERE username = ? ";
		sql += " AND email = ?";
		
		int cnt = 0;

		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, member.getUsername());
			ps.setString(2, member.getEmail());
			
			rs = ps.executeQuery();
			
			while(rs.next()) {
				cnt=rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return cnt;
	}

	@Override
	public Member selectMemberIdfind(Member member) {
		
		String sql = "";
		sql += "SELECT userid FROM member";
		sql += " WHERE username = ? ";
		sql += " AND email = ?";
		
		try {
			ps = conn.prepareStatement(sql);
			
			ps.setString(1, member.getUsername());
			ps.setString(2, member.getEmail());
			
			rs = ps.executeQuery();
			
			while(rs.next()) {
				member.setUserid(rs.getString("userid"));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return member; 
	}

	@Override
	public int selectCntMemberPwfind(Member member) {
		
		String sql = "";
		sql += "SELECT count(*) FROM member"; 
		sql += " WHERE username = ? ";
		sql += " AND email = ?";
		sql += " AND userid = ?";
		
		int cnt = 0;

		try {
			ps = conn.prepareStatement(sql);
			
			ps.setString(1, member.getUsername());
			ps.setString(2, member.getEmail());
			ps.setString(3, member.getUserid());
			
			rs = ps.executeQuery();
			
			while(rs.next()) {
				cnt=rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return cnt;
	}

	@Override
	public Member selectMemberPwfind(Member member) {
		
		String sql = "";
		sql += "SELECT userpw FROM member";
		sql += " WHERE username = ? ";
		sql += " AND email = ?";
		sql += " AND userid = ?";
		
		try {
			ps = conn.prepareStatement(sql);
			
			ps.setString(1, member.getUsername());
			ps.setString(2, member.getEmail());
			ps.setString(3, member.getUserid());
			
			rs = ps.executeQuery();
			
			while(rs.next()) {
				member.setUserpw(rs.getString("userpw"));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return member; 
	}


}
