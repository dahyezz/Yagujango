package dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dao.face.Board_FreeDao;
import dto.Board_Free;
import util.Paging;
import dbutil.DBConn;

public class Board_FreeDaoImpl implements Board_FreeDao {
	private Connection conn = DBConn.getConnection();
	private PreparedStatement ps = null;
	private ResultSet rs = null;

	@Override
	public int selectCntAll(Paging paging) {
		String name = paging.getName();
		String keyword = paging.getKeyword();
		String sql = "";
		sql += "SELECT count(*)";
		sql += " FROM board_free";
		if (name != null && !"".equals(name) && keyword != null && !"".equals(keyword)) {
			sql += " WHERE " + name + " LIKE '%" + keyword + "%'";
		}

		int totalCount = 0;
		try {
			ps = conn.prepareStatement(sql);

			rs = ps.executeQuery();
			while (rs.next()) {
				totalCount = rs.getInt(1);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (ps != null)
					ps.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		return totalCount;
	}

	@Override
	public List<Board_Free> selectAll(Paging paging) {
		String name = paging.getName();
		String keyword = paging.getKeyword();

		List<Board_Free> list = new ArrayList<Board_Free>();

		String sql = "";
		sql += "SELECT * FROM (";
		sql += "	SELECT rownum rnum, B.* FROM (";
		sql += "		SELECT boardno, tag, title, writer, content, hit, writtendate FROM board_free ";
		if (name != null && !"".equals(name) && keyword != null && !"".equals(keyword)) {
			sql += " WHERE " + name + " LIKE '%" + keyword + "%'";
		}
		sql += " 		ORDER BY boardno DESC";
		sql += "	) B";
		sql += "	ORDER BY rnum";
		sql += " ) BOARD";
		sql += " WHERE rnum BETWEEN ? AND ?";

		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, paging.getStartNo());
			ps.setInt(2, paging.getEndNo());
			rs = ps.executeQuery();

			while (rs.next()) {
				Board_Free board_free = new Board_Free();

				board_free.setBoardno(rs.getInt("boardno"));
				board_free.setTag(rs.getString("tag"));
				board_free.setTitle(rs.getString("title"));
				board_free.setWriter(rs.getString("writer"));
				board_free.setContent(rs.getString("content"));
				board_free.setHit(rs.getInt("hit"));
				board_free.setWrittendate(rs.getDate("writtendate"));

				list.add(board_free);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (ps != null)
					ps.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		return list;
	}

	@Override
	public List<Board_Free> selectAllwithNotice(Paging paging) {
		String name = paging.getName();
		String keyword = paging.getKeyword();

		List<Board_Free> list = new ArrayList<Board_Free>();

		String sql = "";
		sql += "SELECT E.* FROM (";
		sql += " 	SELECT rownum rnum, D.* FROM (";
		sql += " 		SELECT C.* FROM (";
		sql += " 			SELECT 'N' type, A.* FROM  ";
		sql += " 				(SELECT * FROM board_free_notice ORDER BY boardno DESC) A WHERE rownum <=3";
		sql += " 			UNION";
		sql += " 			SELECT 'F' type, B.* FROM board_free B";
		sql += " 		) C";
		sql += " 		ORDER BY type DESC, boardno DESC";
		sql += " 	) D ";
		sql += " 	ORDER BY rnum";
		sql += " ) E";
		sql += " WHERE rnum BETWEEN ? AND ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, paging.getStartNo());
			ps.setInt(2, paging.getEndNo());
			rs = ps.executeQuery();

			while (rs.next()) {
				Board_Free board_free = new Board_Free();

				board_free.setBoardno(rs.getInt("boardno"));
				board_free.setTag(rs.getString("tag"));
				board_free.setTitle(rs.getString("title"));
				board_free.setWriter(rs.getString("writer"));
				board_free.setContent(rs.getString("content"));
				board_free.setHit(rs.getInt("hit"));
				board_free.setWrittendate(rs.getDate("writtendate"));

				list.add(board_free);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (ps != null)
					ps.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		return list;
	}

	@Override
	public Board_Free selectBoardByBoardno(Board_Free viewboard) {
		
			String sql = "";
			sql +="SELECT boardno,tag,title,writer,content,hit,writtendate";
			sql +=" FROM board_free";
			sql +=" WHERE boardno = ?";
			Board_Free board_free = new Board_Free();
			try {
				ps = conn.prepareStatement(sql);
				ps.setInt(1, viewboard.getBoardno());
				rs = ps.executeQuery();

				while (rs.next()) {
					board_free.setBoardno(rs.getInt("boardno"));
					board_free.setTag(rs.getString("tag"));
					board_free.setTitle(rs.getString("title"));
					board_free.setWriter(rs.getString("writer"));
					board_free.setContent(rs.getString("content"));
					board_free.setHit(rs.getInt("hit"));
					board_free.setWrittendate(rs.getDate("writtendate"));
				}
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				try {
					if (rs != null)
						rs.close();
					if (ps != null)
						ps.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}

			return board_free;
	}

	@Override
	public void upHit(Board_Free viewboard) {
		String sql = "";
		sql+="UPDATE board_free";
		sql+=" SET hit = hit + 1";
		sql+=" WHERE boardno = ?";
	}

}
