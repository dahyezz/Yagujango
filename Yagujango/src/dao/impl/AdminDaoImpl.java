package dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dao.face.AdminDao;
import dbutil.DBConn;
import dto.Member;
import util.Paging;

public class AdminDaoImpl implements AdminDao{
	
	//DB 愿��젴 媛앹껜
	private Connection conn = DBConn.getConnection();
	private PreparedStatement ps;
	private ResultSet rs;	
	
	//회원목록조회
	@Override
	public List selectAll(Paging paging) {
		
		//수행할 SQL쿼리
		String sql= "";
		sql += "SELECT * FROM member";
		
		//수행결과를 담을 리스트
		List list = new ArrayList();
		
		try {
			ps=conn.prepareStatement(sql);//수행객체 얻기
			rs=ps.executeQuery(); //sql수행결과 얻기
			
			//sql수행결과 처리
			while(rs.next()) {
				Member mem = new Member();
				
				mem.setUserno(rs.getInt("userno"));
				mem.setUserid(rs.getString("userid"));
				mem.setUserpw(rs.getString("userpw"));
				mem.setUsername(rs.getString("username"));
				mem.setUsernick(rs.getString("usernick"));
				mem.setBirth(rs.getDate("birth"));
				mem.setGender(rs.getString("gender"));
				mem.setPhone(rs.getString("phone"));
				mem.setEmail(rs.getString("email"));
				mem.setPenalty(rs.getInt("penalty"));
				mem.setMyteam(rs.getString("myteam"));

				list.add(mem);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		
		return list;
	}
	
	//회원목록조회
	@Override
	public int selectCntAll() {

		//전체 게시글 수 조회 쿼리
		String sql = "";
		sql += "SELECT count(*)";
		sql += " FROM member";
		
		int totalCount = 0;
		try {
			
			ps=conn.prepareStatement(sql);
			rs=ps.executeQuery();
			
			while(rs.next()) {
				totalCount = rs.getInt(1);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				//자원해제
				if(rs!=null)	rs.close();
				if(ps!=null)	ps.close();
				
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return totalCount;
		
	}

	//질문목록보기
	@Override
	public List bselectAll(Paging paging) {
		
		//수행할 SQL쿼리
		String sql= "";
		sql += "SELECT * FROM ";
		
		//수행결과를 담을 리스트
		List blist = new ArrayList();
		
		try {
			ps=conn.prepareStatement(sql);//수행객체 얻기
			rs=ps.executeQuery(); //sql수행결과 얻기
			
			//sql수행결과 처리
			while(rs.next()) {
				Member mem = new Member();
				
				mem.setUserno(rs.getInt("userno"));
				mem.setUserid(rs.getString("userid"));
				mem.setUserpw(rs.getString("userpw"));
				mem.setUsername(rs.getString("username"));
				mem.setUsernick(rs.getString("usernick"));
				mem.setBirth(rs.getDate("birth"));
				mem.setGender(rs.getString("gender"));
				mem.setPhone(rs.getString("phone"));
				mem.setEmail(rs.getString("email"));
				mem.setPenalty(rs.getInt("penalty"));
				mem.setMyteam(rs.getString("myteam"));

				blist.add(mem);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		
		return blist;
	}

}
