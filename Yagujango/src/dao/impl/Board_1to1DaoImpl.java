package dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dao.face.Board_1to1Dao;
import dbutil.DBConn;
import dto.Board_faq;
import util.Paging;

public class Board_1to1DaoImpl implements Board_1to1Dao{
	
	private Connection conn = DBConn.getConnection(); 
	private PreparedStatement ps = null;
	private ResultSet rs = null;

	@Override
	public List faqSelectAll(Paging paging) {

		String sql = "";
		sql += "SELECT * FROM (";
		sql += " 	SELECT rownum rnum, B.* FROM (";
		sql += " 		SELECT faq_boardno, faq_title, faq_content, faq_writtendate FROM board_faq";
		sql += " 		ORDER BY faq_boardno DESC";
		sql += " 	) B";
		sql += " 	ORDER BY rnum";
		sql += " ) BOARD_FAQ";
		sql += " WHERE rnum BETWEEN ? AND ?";
		
		List faqList = new ArrayList();
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
				// 자원 해제
				if(rs!=null)	rs.close();
				if(ps!=null)	ps.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
				
		return faqList;
	}

	@Override
	public int selectCntAll() {
		//전체 게시글 수 조회 쿼리
		String sql = "";
		sql+="SELECT count(*)";
		sql+=" FROM board_faq";
	
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
				// 자원 해제
				if(rs!=null)	rs.close();
				if(ps!=null)	ps.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
				
		return totalCount;
	}

}
