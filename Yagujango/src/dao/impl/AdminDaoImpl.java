package dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import dao.face.AdminDao;
import dbutil.DBConn;
import dto.Board_1to1;
import dto.Mem_blacklist;
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
		String keyword = paging.getKeyword();
		//수행할 SQL쿼리
		//게시글 목록 조회쿼리
		String sql = "";
		sql += "SELECT * FROM ("; 
		sql += "	SELECT rownum rnum, B.* FROM ("; 
		sql += "		SELECT"; 
		sql += "		userno,"; 
		sql += "		userid,";
		sql += "		userpw,";
		sql += "		username,";
		sql += "		usernick,"; 
		sql += "		birth,"; 
		sql += "		gender,"; 
		sql += "		phone,"; 
		sql += "		email,"; 
		sql += "		penalty,"; 
		sql += "		myteam"; 
		sql += "		FROM member"; 
		if(keyword!=null&&!"".equals(keyword)) {
			sql += "		WHERE userid LIKE '%"+keyword+"%'"; 
		}
		sql += "		ORDER BY userno DESC"; 
		sql += "	) B"; 
		sql += "	ORDER BY rnum"; 
		sql += " )"; 
		sql += " WHERE rnum BETWEEN ? AND ?";
		sql += " ORDER BY userno";
		
		//수행결과를 담을 리스트
		List list = new ArrayList();
		
		try {
			ps=conn.prepareStatement(sql);//수행객체 얻기
			
//			ps.setString(1, keyword);
			ps.setInt(1, paging.getStartNo());
			ps.setInt(2, paging.getEndNo());
			
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
	public int selectCntAll(String keyword) {

		//전체 게시글 수 조회 쿼리
		String sql = "";
		sql += "SELECT count(*) FROM member";
		sql += " WHERE userid LIKE '%'||?||'%' ";
		
		int totalCount = 0;
		try {
			
			ps=conn.prepareStatement(sql);
			
			ps.setString(1, keyword);
			
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
		sql += "SELECT * FROM board_1to1";
		
		//수행결과를 담을 리스트
		List blist = new ArrayList();
		
		try {
			ps=conn.prepareStatement(sql);//수행객체 얻기
			rs=ps.executeQuery(); //sql수행결과 얻기
			
			//sql수행결과 처리
			while(rs.next()) {
				Board_1to1 board_1to1 = new Board_1to1();
				
				board_1to1.setBoardno(rs.getInt("boardno"));
				board_1to1.setWriter_userid(rs.getString("writer_userid"));
				board_1to1.setWriter_email(rs.getString("writer_email"));
				board_1to1.setTitle(rs.getString("title"));
				board_1to1.setContent(rs.getString("content"));
				board_1to1.setWriter_comment(rs.getString("writer_comment"));
				board_1to1.setWrittendate(rs.getDate("writtendate"));

				blist.add(board_1to1);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		
		return blist;
	}
	
	//블랙리스트조회

	@Override
	public List blackselectAll(Paging paging) {
		
		//수행할 SQL쿼리
		String sql= "";
		sql += "select * FROM member A, mem_blacklist B";
		sql += " WHERE A.userid = B.userid";
		sql += " AND B.username = A.username and B.email = A.email and B.phone = A.phone ";
		
		//수행결과를 담을 리스트
		List list = new ArrayList();
		
		try {
			
			Mem_blacklist mem_blacklist = new Mem_blacklist();
			
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
		} finally {
			try {
				if(rs!=null)	rs.close();
				if(ps!=null)	ps.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			
		}
		
		return list;

	}

	@Override
	public Board_1to1 selectBoard_1to1ByBoardno(Board_1to1 viewBoard) {
		
		//게시글 조회 쿼리
		String sql = "";
		sql += "SELECT boardno, writer_userid, writer_email, title, content, writer_comment, writtendate FROM board_1to1";
		sql += " WHERE boardno = ?";
		
		try {
			ps = conn.prepareStatement(sql);
			
			ps.setInt(1, viewBoard.getBoardno());
			
			rs = ps.executeQuery();
			
			while( rs.next() ) {
				viewBoard.setBoardno( rs.getInt("boardno"));
				viewBoard.setWriter_userid( rs.getString("writer_userid"));
				viewBoard.setWriter_email( rs.getString("writer_eamil"));
				viewBoard.setTitle( rs.getString("title"));
				viewBoard.setContent( rs.getString("content"));
				viewBoard.setWriter_comment( rs.getString("writer_comment"));
				viewBoard.setWrittendate( rs.getDate("writtendate"));
				
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			//자원해제
			try{
				if(rs!=null)	rs.close();
				if(ps!=null)	ps.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}

	}
		return viewBoard;
}
}
