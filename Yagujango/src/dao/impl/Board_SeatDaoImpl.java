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
import dto.Board_file;
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

	@Override
	public void upHit(Board_Seat board_seat) {
		String sql = "";
		sql+="UPDATE board_seat";
		sql+=" SET hit = hit + 1";
		sql+=" WHERE boardno = ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, board_seat.getBoardno());
			ps.executeUpdate();

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
		
	}

	@Override
	public Board_Seat selectbyboardno(Board_Seat board_seat) {
		String sql = "";
		sql +="SELECT boardno, stadium_name,seat_block,seat_number,content,writer, hit,writtendate,fileurl";
		sql +=" FROM board_seat";
		sql +=" WHERE boardno = ?";
		Board_Seat viewboard = new Board_Seat();
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, board_seat.getBoardno());
			rs = ps.executeQuery();

			while (rs.next()) {
				viewboard.setBoardno(rs.getInt("boardno"));
				viewboard.setStadium_name(rs.getString("stadium_name"));
				viewboard.setSeat_block(rs.getString("seat_block"));
				viewboard.setSeat_number(rs.getInt("seat_number"));
				viewboard.setWriter(rs.getString("writer"));
				viewboard.setContent(rs.getString("content"));
				viewboard.setHit(rs.getInt("hit"));
				viewboard.setWrittendate(rs.getDate("writtendate"));
				viewboard.setFileurl(rs.getString("fileurl"));
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

		return viewboard;
	}

	@Override
	public void deletebyboardno(Board_Seat board_seat) {
		String sql = "";
		sql += "DELETE FROM board_seat";
		sql += " WHERE boardno=?";
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, board_seat.getBoardno());
			ps.executeQuery();
			
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

	@Override
	public void update(Board_Seat board_seat) {
		String sql = "";
		sql+="UPDATE board_seat";
		sql+=" SET stadium_name = ?,";
		sql+=" 		seat_block = ?,";
		sql+=" 		seat_number = ?,";
		sql+="      content = ?";
		sql+=" WHERE boardno = ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, board_seat.getStadium_name());
			ps.setString(2, board_seat.getSeat_block());
			ps.setInt(3, board_seat.getSeat_number());
			ps.setString(4, board_seat.getContent());
			ps.setInt(5, board_seat.getBoardno());
			ps.executeUpdate();

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
	}

	@Override
	public int getboardno() {
		String sql = "";
		sql += "SELECT board_seat_seq.nextval";
		sql += " FROM dual";
		int boardno = 0;
		try {
			ps = conn.prepareStatement(sql);

			rs = ps.executeQuery();
			while (rs.next()) {
				boardno = rs.getInt(1);
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
		return boardno;
	}

	@Override
	public void insertFile(Board_file board_file) {
		String sql = "";
		sql +="INSERT INTO board_seatfile(fileno,boardno,originname,storedname,filesize)";
		sql +=" VALUES(board_seatfile_seq.nextval,?,?,?,?)";
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, board_file.getBoardno());
			ps.setString(2, board_file.getOriginname());
			ps.setString(3, board_file.getStoredname());
			ps.setInt(4, board_file.getFilesize());
			ps.executeUpdate();

			
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

	@Override
	public void InsertwithFile(Board_Seat board_seat) {
		String sql = "";
		sql += "INSERT INTO board_seat(";
		sql += " boardno, stadium_name,seat_block,seat_number,content,writer, hit,fileurl)" ;
		sql += " VALUES (?,?,?,?,?,?,0,?)";

		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, board_seat.getBoardno());
			ps.setString(2, board_seat.getStadium_name());
			ps.setString(3, board_seat.getSeat_block());
			ps.setInt(4, board_seat.getSeat_number());
			ps.setString(5, board_seat.getContent());
			ps.setString(6, board_seat.getWriter());
			ps.setString(7, board_seat.getFileurl());
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
