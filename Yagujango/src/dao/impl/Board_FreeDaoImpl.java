package dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dao.face.Board_FreeDao;
import dto.Board_Free;
import dto.Board_file;
import dto.Comment;
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
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, viewboard.getBoardno());
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
	public void NoticeupHit(Board_Free viewboard) {
		String sql = "";
		sql+="UPDATE board_free_notice";
		sql+=" SET hit = hit + 1";
		sql+=" WHERE boardno = ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, viewboard.getBoardno());
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
	public Board_Free selectNoticeByBoardno(Board_Free viewboard) {
		String sql = "";
		sql +="SELECT boardno,tag,title,writer,content,hit,writtendate";
		sql +=" FROM board_free_notice";
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
	public void InsertNotice(Board_Free board_free) {
		String sql = "";
		sql +="INSERT INTO board_free_notice(boardno,tag,title,writer,content,hit)";
		sql +=" VALUES(board_free_seq.nextval,?,?,?,?,0)";
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, board_free.getTag());
			ps.setString(2, board_free.getTitle());
			ps.setString(3, board_free.getWriter());
			ps.setString(4, board_free.getContent());
			rs = ps.executeQuery();

			
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
	public void Insert(Board_Free board_free) {
		String sql = "";
		sql +="INSERT INTO board_free(boardno,tag,title,writer,content,hit)";
		sql +=" VALUES(board_free_seq.nextval,?,?,?,?,0)";
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, board_free.getTag());
			ps.setString(2, board_free.getTitle());
			ps.setString(3, board_free.getWriter());
			ps.setString(4, board_free.getContent());
			rs = ps.executeQuery();
			
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
	public void deleteBoardbyboardno(Board_Free board) {
		String sql = "";
		sql += "DELETE FROM board_free";
		sql += " WHERE boardno=?";
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, board.getBoardno());
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
	public void updateBoard_Free(Board_Free board) {
		String sql = "";
		sql += "UPDATE board_free";
		sql += " SET tag =?,";
		sql += " 	title = ?,";
		sql += " 	content = ?";
		sql += " WHERE boardno = ?";
		

		
		try {
			//DB작업
			ps = conn.prepareStatement(sql);
			ps.setString(1, board.getTag());
			ps.setString(2, board.getTitle());
			ps.setString(3, board.getContent());
			ps.setInt(4, board.getBoardno());

			ps.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
			
		} finally {
			try {
				//DB객체 닫기
				if(ps!=null)	ps.close();
				
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
	}

	@Override
	public List<Comment> selectCommentbyboardno(Board_Free viewboard) {
		String sql = "";
		sql +="SELECT * FROM freecomment";
		sql +=" WHERE boardno=?";
		sql +=" ORDER BY commentno";
		List<Comment> list = new ArrayList<Comment>();
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, viewboard.getBoardno());
			rs = ps.executeQuery();
			
			while (rs.next()) {
				Comment comment = new Comment();

				comment.setCommentno(rs.getInt("commentno"));
				comment.setBoardno(rs.getInt("boardno"));
				comment.setWriter(rs.getString("userid"));
				comment.setContent(rs.getString("content"));
				comment.setWrittendate(rs.getDate("writtendate"));

				list.add(comment);
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
	public void CommentInsert(Comment comment) {
		String sql = "";
		sql +="INSERT INTO freecomment(commentno, boardno, userid,content)";
		sql +=" VALUES (freecomment_seq.nextval,?,?,?)";
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, comment.getBoardno());
			ps.setString(2, comment.getWriter());
			ps.setString(3, comment.getContent());
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
	public void CommentDelete(Comment comment) {
		String sql = "";
		sql += "DELETE FROM freecomment";
		sql += " WHERE commentno=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, comment.getCommentno());
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
	public List<Board_Free> selectNoticeAll(Paging paging) {
		List<Board_Free> list = new ArrayList<Board_Free>();
//		SELECT * FROM (
//	    SELECT rownum rnum, B.* FROM (
//	        SELECT boardno, tag, title, writer, content, hit, writtendate FROM board_free_notice
//	        ORDER BY boardno DESC
//	        ) B
//	    ORDER BY rnum
//	) BOARD
//	WHERE rnum BETWEEN 1 AND 10
		String sql = "";
		sql += "SELECT * FROM (";
		sql += " 	SELECT rownum rnum, B.* FROM (";
		sql += " 	 	SELECT boardno, tag, title, writer, content, hit, writtendate FROM board_free_notice";
		sql += "  		ORDER BY boardno DESC";
		sql += "	 	) B";
		sql += "	 ORDER BY rnum";
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
	public int selectCntNotice() {
		String sql = "";
		sql += "SELECT count(*)";
		sql += " FROM board_free_notice";
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
	public void updateBoard_Free_Notice(Board_Free board) {
		String sql = "";
		sql += "UPDATE board_free_notice";
		sql += " SET title = ?,";
		sql += " 	content = ?";
		sql += " WHERE boardno = ?";
		

		
		try {
			//DB작업
			ps = conn.prepareStatement(sql);
			ps.setString(1, board.getTitle());
			ps.setString(2, board.getContent());
			ps.setInt(3, board.getBoardno());

			ps.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
			
		} finally {
			try {
				//DB객체 닫기
				if(ps!=null)	ps.close();
				
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
	}

	@Override
	public int getboardno() {
		String sql = "";
		sql += "SELECT board_free_seq.nextval";
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
		sql +="INSERT INTO board_freefile(fileno,boardno,originname,storedname,filesize)";
		sql +=" VALUES(board_freefile_seq.nextval,?,?,?,?)";
		
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
	public void InsertwithFile(Board_Free board_free) {
		String sql = "";
		sql +="INSERT INTO board_free(boardno,tag,title,writer,content,hit)";
		sql +=" VALUES(?,?,?,?,?,0)";
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, board_free.getBoardno());
			ps.setString(2, board_free.getTag());
			ps.setString(3, board_free.getTitle());
			ps.setString(4, board_free.getWriter());
			ps.setString(5, board_free.getContent());
			rs = ps.executeQuery();

			
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
	public void InsertNoticewithFile(Board_Free board_free) {
		String sql = "";
		sql +="INSERT INTO board_free_notice(boardno,tag,title,writer,content,hit)";
		sql +=" VALUES(?,?,?,?,?,0)";
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, board_free.getBoardno());
			ps.setString(2, board_free.getTag());
			ps.setString(3, board_free.getTitle());
			ps.setString(4, board_free.getWriter());
			ps.setString(5, board_free.getContent());
			rs = ps.executeQuery();

			
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
	public void deletenoticeBoardbyboardno(Board_Free board) {
		String sql = "";
		sql += "DELETE FROM board_free_notice";
		sql += " WHERE boardno=?";
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, board.getBoardno());
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

}
