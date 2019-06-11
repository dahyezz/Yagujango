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
import dto.Board_1to1_answer;
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
				System.out.println(board_1to1.getWriter_comment());
				
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
				viewBoard.setWriter_email( rs.getString("writer_email"));
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

	@Override
	public int selectBoardno() {
		//다음 게시글 번호 조회 쿼리
		String sql = "";
		sql += "SELECT board_1to1_answer_seq.nextval";
		sql += " FROM dual";
		
		//게시글번호
		int boardno = 0;
		
		try {
			//DB작업
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			
			//결과 담기
			while(rs.next()) {
				boardno = rs.getInt(1);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				//DB객체 닫기
				if(rs!=null)	rs.close();
				if(ps!=null)	ps.close();
				
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		//게시글 번호 반환
		return boardno;
	}


	@Override
	public void insert(Board_1to1_answer board_1to1_answer) {

		String sql = "";
		sql +="INSERT INTO board_1to1_answer(answerno, boardno,writer_userid,content)";
		sql +=" VALUES(board_1to1_answer_seq.nextval,?,?,?)";
		
		try {
			ps = conn.prepareStatement(sql);
			
			ps.setInt(1, board_1to1_answer.getBoardno());
			ps.setString(2, board_1to1_answer.getWriter_userid());
			ps.setString(3, board_1to1_answer.getContent());

			ps.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if (ps != null)		ps.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}	
	}
	
	@Override
	public void updateStatus(Board_1to1 board_1to1) {
		
		String sql = "";
		sql +="UPDATE board_1to1 SET writer_comment='처리' WHERE boardno=?";

		try {
			ps = conn.prepareStatement(sql);
			
			ps.setInt(1, board_1to1.getBoardno());

			System.out.println(board_1to1.getBoardno());
			ps.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if (ps != null)		ps.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}	
	}

	
	//답변완료목록리스트
	@Override
	public List aselectAll(Paging paging) {
		//수행할 SQL쿼리
		String sql= "";
		sql += "SELECT * FROM board_1to1_answer";
		
		//수행결과를 담을 리스트
		List alist = new ArrayList();
		
		try {
			ps=conn.prepareStatement(sql);//수행객체 얻기
			rs=ps.executeQuery(); //sql수행결과 얻기
			
			//sql수행결과 처리
			while(rs.next()) {
				Board_1to1_answer board_1to1_answer = new Board_1to1_answer();
				
				board_1to1_answer.setAnswerno(rs.getInt("answerno"));
				board_1to1_answer.setBoardno(rs.getInt("boardno"));
				board_1to1_answer.setWriter_userid(rs.getString("writer_userid"));
				board_1to1_answer.setContent(rs.getString("content"));
				board_1to1_answer.setWrittendate(rs.getDate("writtendate"));

				alist.add(board_1to1_answer);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
			
		return alist;
	
	}

	@Override
	public Board_1to1_answer selectBoard_answerByBoardno(Board_1to1_answer answerBoard) {
		//게시글 조회 쿼리
		String sql = "";
		sql += "SELECT answerno, boardno, writer_userid, content, writtendate FROM board_1to1_answer";
		sql += " WHERE answerno = ?";
		
		try {
			ps = conn.prepareStatement(sql);
			
			ps.setInt(1, answerBoard.getAnswerno());
			
			rs = ps.executeQuery();
			
			while( rs.next() ) {
				answerBoard.setAnswerno( rs.getInt("answerno"));
				answerBoard.setBoardno( rs.getInt("boardno"));
				answerBoard.setWriter_userid( rs.getString("writer_userid"));
				answerBoard.setContent( rs.getString("content"));
				answerBoard.setWrittendate( rs.getDate("writtendate"));	
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
		return answerBoard;	
	}
	
	//1:1질문삭제
	@Override
	public void delete(Board_1to1 board_1to1) {

		String sql = "";
		sql += "DELETE board_1to1";
		sql += " WHERE boardno = ?";
		
		//DB객체
		PreparedStatement ps = null;
		
		try {
			ps=conn.prepareStatement(sql);
			ps.setInt(1, board_1to1.getBoardno());
			
			ps.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				//DB객체 담기
				if(ps!=null)	ps.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	//답변삭제
	@Override
	public void Adelete(Board_1to1_answer board_1to1_answer) {
		String sql = "";
		sql += "DELETE board_1to1_answer";
		sql += " WHERE answerno = ?";
		
		//DB객체
		PreparedStatement ps = null;
		
		try {
			ps=conn.prepareStatement(sql);
			ps.setInt(1, board_1to1_answer.getAnswerno());
			
			ps.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				//DB객체 담기
				if(ps!=null)	ps.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	//답변수정
	@Override
	public void update(Board_1to1_answer board_1to1_answer) {

		String sql = "";
		sql += "UPDATE board_1to1_answer";
		sql += " SET content = ?";
		sql += " WHERE answerno = ?";
		
		//DB 객체
		PreparedStatement ps = null; 
		
		try {
			//DB작업
			ps = conn.prepareStatement(sql);
			ps.setString(1, board_1to1_answer.getContent());
			ps.setInt(2, board_1to1_answer.getAnswerno());


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
	//멤버 체크선택삭제
	@Override
	public void deleteMemberList(String names) {
		
		String sql = "DELETE FROM member WHERE userno IN ( "+names+" )";
		
		try {
			ps = conn.prepareStatement(sql);
			
			ps.executeUpdate();
			
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
	public void updatePenalty(String names) {

		String sql = "UPDATE member SET penalty = 1 WHERE userno IN ( "+names+" )";
		
		try {
			ps = conn.prepareStatement(sql);
			
			ps.executeUpdate();
			
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
	//보류
	@Override
	public void deleteBlackList(String names) {
		String sql = "DELETE FROM mem_blacklist WHERE userno IN ( "+names+" )";
		
		try {
			ps = conn.prepareStatement(sql);
			
			ps.executeUpdate();
			
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

	// update하기전에 select penalty from member where userno=? 이런식으로 불러와서
	@Override
	public List<Integer> selectPenalty(String names) {
		String sql = "";
		sql += "SELECT penalty FROM member WHERE userno IN ( "+names+" ) ";
			
		//수행결과를 담을 리스트
		List list = new ArrayList();
		
		try {
			ps = conn.prepareStatement(sql);
			
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
		return list;
	}
}
