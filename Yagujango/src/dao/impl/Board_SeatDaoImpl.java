package dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dao.face.Board_SeatDao;
import dbutil.DBConn;
import dto.Board_Seat;
import util.Paging;

public class Board_SeatDaoImpl implements Board_SeatDao{
	private Connection conn = DBConn.getConnection();
	private PreparedStatement ps = null;
	private ResultSet rs = null;

	@Override
	public int selectCntAll(Paging paging) {
		String sql = "";
		sql += "SELECT count(*)";
		sql += " FROM board_seat";
		

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
	public List<Board_Seat> selectAll(Paging paging) {
		String name = paging.getName();
		String keyword = paging.getKeyword();
		
		List<Board_Seat> list =new ArrayList<Board_Seat>();
		
		String sql = "";
		sql += "SELECT * FROM (";
		sql += "	SELECT rownum rnum, B.* FROM (";
		sql += "		SELECT boardno, stadium_name,seat_block,seat_number,";
		sql += " 			content, writer, hit, writtendate,fileurl FROM board_seat ";
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
				Board_Seat board_seat = new Board_Seat();

				board_seat.setBoardno(rs.getInt("boardno"));
				board_seat.setStadium_name(rs.getString("stadium_name"));
				board_seat.setSeat_block(rs.getString("seat_block"));
				board_seat.setSeat_number(rs.getInt("seat_number"));
				board_seat.setContent(rs.getString("content"));
				board_seat.setWriter(rs.getString("writer"));
				board_seat.setHit(rs.getInt("hit"));
				board_seat.setWrittendate(rs.getDate("writtendate"));
				board_seat.setFileurl(rs.getString("fileurl"));
				
				
				list.add(board_seat);
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
	public void Insert(Board_Seat board_seat) {
		// INSERT INTO board_seat(boardno, stadium_name,seat_block,seat_number,content,writer, hit,filename)	VALUES (BOARD_SEAT_SEQ.nextval,?,?,	?,?,?,0,?);

		String sql = "";
		sql += "INSERT INTO board_seat(";
		sql += " boardno, stadium_name,seat_block,seat_number,content,writer, hit,fileurl)" ;
		sql += " VALUES (BOARD_SEAT_SEQ.nextval,?,?,?,?,?,0,?)";

		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, board_seat.getStadium_name());
			ps.setString(2, board_seat.getSeat_block());
			ps.setInt(3, board_seat.getSeat_number());
			ps.setString(4, board_seat.getContent());
			ps.setString(5, board_seat.getWriter());
			ps.setString(6, board_seat.getFileurl());
			rs = ps.executeQuery();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if (ps != null)
					ps.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

	}

}
