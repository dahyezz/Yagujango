package dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dao.face.Board_1to1Dao;
import dbutil.DBConn;
import dto.Board_1to1;
import dto.Board_faq;
import dto.Member;
import util.Paging;

public class Board_1to1DaoImpl implements Board_1to1Dao{
	
	private Connection conn = DBConn.getConnection(); 
	private PreparedStatement ps = null;
	private ResultSet rs = null;

	@Override
	public List<Board_faq> faqSelectAll(Paging paging) {
		String name = paging.getName();
		String keyword = paging.getKeyword();
		List<Board_faq> faqList = new ArrayList<Board_faq>();
		
		String sql = "";
		sql += "SELECT * FROM (";
		sql += " 	SELECT rownum rnum, B.* FROM (";
		sql += " 		SELECT faq_boardno, faq_title, faq_content, faq_writtendate FROM board_faq";
		if (name != null && !"".equals(name) && keyword != null && !"".equals(keyword)) {
			sql += " WHERE " + name + " LIKE '%" + keyword + "%'";
		}
		sql += " 		ORDER BY faq_boardno";
		sql += " 	) B";
		sql += " 	ORDER BY rnum";
		sql += " ) BOARD_FAQ";		
		sql += " WHERE rnum BETWEEN ? AND ?";

		try {
			ps = conn.prepareStatement(sql);
			
			ps.setInt(1, paging.getStartNo());
			ps.setInt(2, paging.getEndNo());
			
			rs = ps.executeQuery();
			
			while( rs.next() ) {
				Board_faq board_faq = new Board_faq();
				
				board_faq.setFaq_boardno(rs.getInt("faq_boardno"));
				board_faq.setFaq_title( rs.getString("faq_title") );
				board_faq.setFaq_content( rs.getString("faq_content") );
				board_faq.setFaq_writtendate( rs.getDate("faq_writtendate") );
				faqList.add(board_faq);
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
				
		return faqList;
	}


	@Override
	public int selectCntAll(Paging paging) {
		String name = paging.getName();
		String keyword = paging.getKeyword();
		String sql = "";
		sql+="SELECT count(*)";
		sql+=" FROM board_faq";
		if (name != null && !"".equals(name) && keyword != null && !"".equals(keyword)) {
			sql += " WHERE " + name + " LIKE '%" + keyword + "%'";
		}
		
		int totalCount = 0;
		try {
			ps = conn.prepareStatement(sql);
			
			rs = ps.executeQuery();
			 
			while( rs.next() ) {
				totalCount = rs.getInt(1);
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
		return totalCount;
	}


	@Override
	public void Insert(Board_1to1 board_1to1) {
		String sql = "";
		sql += "INSERT INTO board_1to1(BOARDNO,WRITER_USERID,WRITER_EMAIL,TITLE,CONTENT,WRITER_COMMENT) ";
		sql += " VALUES (board_1to1_seq.nextval,?,?,?,?,?)";
		
		try {
			ps = conn.prepareStatement(sql);
			
			ps.setString(1, board_1to1.getWriter_userid());
			ps.setString(2, board_1to1.getWriter_email());
			ps.setString(3, board_1to1.getTitle());
			ps.setString(4, board_1to1.getContent());
			ps.setString(5, board_1to1.getWriter_comment());			

			ps.executeQuery();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(ps!=null)	ps.close();
				
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}	
	}


	@Override
	public List<Member> OneToOneSelectAll() {
		
		List<Member> OneToOneList = new ArrayList<Member>();
		
		String sql = "";
		sql += "SELECT";
		sql += " B.boardno,";
		sql += " M.userno, M.userid, M.usernick,M.email,M.myteam,";
		sql += " B.title, B.content, B.writer_comment, B.writtendate";		
		sql += " FROM member M, board_1to1 B";
		sql += " WHERE M.userid = B.writer_userid";
		sql += " ORDER BY B.boardno";
		
		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			
			while( rs.next() ) {
				Member member = new Member();
				
				member.setBoardno(rs.getInt("boardno"));
				member.setUserno(rs.getInt("userno"));
				member.setUserid(rs.getString("userid"));
				member.setUsernick(rs.getString("usernick"));
				member.setEmail(rs.getString("email"));
				member.setMyteam(rs.getString("myteam"));
				member.setTitle(rs.getString("title"));
				member.setContent(rs.getString("content"));
				member.setWriter_comment(rs.getString("writer_comment"));
				member.setWrittendate(rs.getDate("writtendate"));
				
				OneToOneList.add(member);
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
				
		
		return OneToOneList;
	}

	
	
	
}

