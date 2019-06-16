package dao.impl;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import dao.face.MemberDao;
import dbutil.DBConn;
import dto.Board_1to1;
import dto.Match;
import dto.Member;
import dto.Reserve;
import dto.Seat;
import dto.Stadium;
import dto.Ticket;
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
		} finally {
			try {
				if(ps!=null)	ps.close();
				if(rs!=null)	rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
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
		}  finally {
			try {
				if(ps!=null)	ps.close();
				if(rs!=null)	rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
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
		} finally {
			try {
				if(ps!=null)	ps.close();
				if(rs!=null)	rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
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
		} finally {
			try {
				if(ps!=null)	ps.close();
				if(rs!=null)	rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
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
		} finally {
			try {
				if(ps!=null)	ps.close();
				if(rs!=null)	rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
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
		} finally {
			try {
				if(ps!=null)	ps.close();
				if(rs!=null)	rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return member; 
	}

	@Override
	public void insert(Member member) {
		
		String sql = "";
		sql+="INSERT INTO member(userno,userid,userpw,username,usernick,birth,gender,phone,email,myteam)";
		sql+=" VALUES ( member_seq.nextval, ?, ?, ?, ?, TO_DATE(?,'yyyy-mm-dd'), ?, ?, ?, ? )";
		
		try {
			ps = conn.prepareStatement(sql);
			
			ps.setString(1, member.getUserid());
			ps.setString(2, member.getUserpw());
			ps.setString(3, member.getUsername());
			ps.setString(4, member.getUsernick());
			ps.setDate(5, (Date) member.getBirth());
			ps.setString(6, member.getGender());
			ps.setString(7, member.getPhone());
			ps.setString(8, member.getEmail());
			ps.setString(9, member.getMyteam());

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
	public int selectCntMemberIdOverlap(Member member) {
		
		String sql = "";
		sql += "SELECT count(*) FROM member"; 
		sql += " WHERE userid = ? ";
		
		int cnt = 0;

		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, member.getUserid());
			
			rs = ps.executeQuery();
			
			while(rs.next()) {
				cnt=rs.getInt(1);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(ps!=null)	ps.close();
				if(rs!=null)	rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return cnt;
	}

	@Override
	public int selectCntByBlacklist(Member member) {
		
		String sql = "";
		sql += "SELECT count(*) FROM mem_blacklist"; 
		sql += " WHERE username = ? ";
		sql += " AND phone = ?";
		
		int cnt = 0;

		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, member.getUsername());
			ps.setString(2, member.getPhone());
			
			rs = ps.executeQuery();
			
			while(rs.next()) {
				cnt=rs.getInt(1);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(ps!=null)	ps.close();
				if(rs!=null)	rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return cnt;
	}
	
	@Override
	public List<Board_1to1> OneToOneSelectAll(String userid) {
		
		List<Board_1to1> OneToOneList = new ArrayList<Board_1to1>();
		
		String sql = "";
		sql += "SELECT * FROM board_1to1";
		sql += " WHERE writer_userid = ? ";
		sql += " ORDER BY boardno DESC";
		
		try {
			
			ps = conn.prepareStatement(sql); 
			
			ps.setString(1, userid);
			
			rs = ps.executeQuery();
			
			while( rs.next() ) {
				
				Board_1to1 board_1to1 = new Board_1to1();
				board_1to1.setBoardno(rs.getInt("boardno"));
				board_1to1.setWriter_email(rs.getString("Writer_email"));
				board_1to1.setWriter_userid(rs.getString("writer_userid"));		
				board_1to1.setTitle(rs.getString("Title"));
				board_1to1.setContent(rs.getString("Content"));
				board_1to1.setWrittendate(rs.getDate("writtendate"));
				
//				Member member = new Member();
//				member.setBoardno(rs.getInt("boardno"));
//				member.setUserno(rs.getInt("userno"));
//				member.setUserid(rs.getString("userid"));
//				member.setUsernick(rs.getString("usernick"));
//				member.setWriter_email(rs.getString("writer_email"));
//				member.setMyteam(rs.getString("myteam"));
//				member.setTitle(rs.getString("title"));
//				member.setContent(rs.getString("content"));
//				member.setWrittendate(rs.getDate("writtendate"));
				
//				System.out.println(board_1to1);
				OneToOneList.add(board_1to1);
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

	@Override
	public List<Reserve> selectReservecodeByUserno(Paging mypagepaging, Reserve reserve) {
		
		String sql="";
		sql+="SELECT * FROM ("; 
		sql+=" SELECT rownum rnum, R.* FROM ("; 
		sql+="  SELECT reserve_code, payment, how_receive FROM reserve";
		sql+="  WHERE userno = ?";
		sql+="  GROUP BY reserve_code, payment, how_receive";
		sql+="  ORDER BY reserve_code) R";
		sql+=" ORDER BY rnum";
		sql+=" ) Rnum";
		sql+=" WHERE rnum BETWEEN ? AND ?";
		
		List<Reserve> list=new ArrayList<>();
		
		try {
			ps=conn.prepareStatement(sql);
			
			ps.setInt(1, reserve.getUserno());
			ps.setInt(2, mypagepaging.getStartNo());
			ps.setInt(3, mypagepaging.getEndNo());
			
			rs=ps.executeQuery();
			
			while(rs.next()) {
				Reserve reserveList = new Reserve();
				
				reserveList.setReserve_code(rs.getString("reserve_code"));
				reserveList.setPayment(rs.getString("payment"));
//				reserveList.setPayment_date(rs.getDate("payment_date"));
				reserveList.setHow_receive(rs.getString("how_receive"));
				
				list.add(reserveList);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(ps!=null)	ps.close();
				if(rs!=null)	rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return list;
	}

	@Override
	public int selectCntReservecode(Reserve reserve) {
		
		String sql="";
		sql+="SELECT count(*) FROM (";
		sql+=" SELECT reserve_code FROM reserve";
		sql+=" WHERE userno = ?";
		sql+=" GROUP BY reserve_code)";
		
		//userno별 전체 reservo_code 수
		int count=0;
		
		try {
			ps=conn.prepareStatement(sql);
			
			ps.setInt(1, reserve.getUserno());
			
			rs=ps.executeQuery();
			
			while(rs.next()) {
				count=rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(ps!=null)	ps.close();
				if(rs!=null)	rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
			
		return count;
	}

	@Override
	public List<Reserve> selectReserveByUserno(Reserve reserve) {
		
		String sql="";
		sql += "SELECT reserve_code, ticket_code, userno, payment, payment_date, how_receive, barcode";
		sql += " FROM reserve WHERE userno = ?";
		sql += " ORDER BY ticket_code";

		
		List<Reserve> list = new ArrayList<>();
		
		try {
			ps=conn.prepareStatement(sql);
			
			ps.setInt(1, reserve.getUserno());
			
			rs=ps.executeQuery();
			
			while(rs.next()) {

				Reserve addReserve=new Reserve();
				
				addReserve.setReserve_code(rs.getString("reserve_code"));
				addReserve.setTicket_code(rs.getInt("ticket_code"));
				addReserve.setUserno(rs.getInt("userno"));
				addReserve.setPayment(rs.getString("payment"));
				addReserve.setPayment_date(rs.getDate("payment_date"));
				addReserve.setHow_receive(rs.getString("how_receive"));
				addReserve.setBarcode(rs.getString("barcode"));

				list.add(addReserve);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(ps!=null)	ps.close();
				if(rs!=null)	rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return list;
	}

	@Override
	public List<Ticket> selectTicketByTicketcode(String ticket_code) {
		
		String sql = "";
		sql += "SELECT * FROM ticket"; 
		sql += " WHERE ticket_code IN (" + ticket_code + ")";
		sql += " ORDER BY ticket_code";
		
		List<Ticket> ticketList = new ArrayList<Ticket>();
		
		try {
			ps = conn.prepareStatement(sql);

			rs = ps.executeQuery();
			
			while(rs.next()) {
				Ticket ticket = new Ticket();
				
				ticket.setTicket_code(rs.getInt("ticket_code"));
				ticket.setMatch_code(rs.getInt("match_code"));
				ticket.setSeat_code(rs.getInt("seat_code"));
				
				ticketList.add(ticket);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(ps!=null)	ps.close();
				if(rs!=null)	rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return ticketList;
	}

	@Override
	public List<Match> selectMatchByMatchcode(String match_code) {
		
		String sql = "";
		sql+="SELECT";
		sql+=" match_code, hometeam_code,";
		sql+=" to_char(match_date, 'yyyy/MM/dd HH24:MI') match_date,";
		sql+=" hometeam_name, awayteam_name";
		sql+=" FROM match"; 
		sql+=" WHERE match_code IN (" + match_code + ")";
		sql += " ORDER BY match_code";
		
		List<Match> matchList = new ArrayList<Match>();
		
		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			
			while(rs.next()) {
				Match match=new Match();
				
				match.setMatch_code(rs.getInt("match_code"));
				match.setHometeam_code(rs.getInt("hometeam_code"));
				match.setMatch_date(new SimpleDateFormat("yyyy/MM/dd HH:mm").parse(rs.getString("match_date")));
				match.setHometeam_name(rs.getString("hometeam_name"));
				match.setAwayteam_name(rs.getString("awayteam_name"));
				
				matchList.add(match);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ParseException e) {
			e.printStackTrace();
		} finally {
			try {
				if(ps!=null)	ps.close();
				if(rs!=null)	rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return matchList;
	}

	@Override
	public Seat selectSeatBySeatcode(Ticket ticket) {
		
		String sql="";
		sql+="SELECT * FROM seat";
		sql+=" WHERE seat_code  = ?";
		
		Seat seat=new Seat();
		
		try {
			ps=conn.prepareStatement(sql);
			
			ps.setInt(1, ticket.getSeat_code());
			
			rs=ps.executeQuery();
			
			while(rs.next()) {
				
				seat.setSeat_code(rs.getInt("seat_code"));
				seat.setSeat_block(rs.getString("seat_block"));
				seat.setSeat_number(rs.getInt("seat_number"));
				seat.setPrice(rs.getInt("price"));
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(ps!=null)	ps.close();
				if(rs!=null)	rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		return seat;
	}
	
	@Override
	public int selectCntSeatByReservecode(Reserve reserve) {
		
		String sql = "";
		sql+="SELECT count(*) FROM (";
		sql+=" SELECT seat_code FROM seat"; 
		sql+=" WHERE seat_code IN (";
		sql+="  SELECT seat_code FROM ticket"; 
		sql+="  WHERE ticket_code IN(";
		sql+="   SELECT ticket_code FROM reserve"; 
		sql+="   WHERE reserve_code = ?)))";
		
		int count = 0;

		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, reserve.getReserve_code());
			
			rs = ps.executeQuery();
			
			while(rs.next()) {
				count=rs.getInt(1);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(ps!=null)	ps.close();
				if(rs!=null)	rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return count;
	}

	@Override
	public List<Stadium> selectStadiumByStadiumcode(String hometeam_code) {
		
		String sql = "";
		sql+="SELECT stadium_code, stadium_name";
		sql+=" FROM stadium"; 
		sql += " WHERE stadium_code IN (" + hometeam_code + ")";
		sql += " ORDER BY stadium_code";
		
		List<Stadium> list = new ArrayList<Stadium>();
		
		try {
			ps = conn.prepareStatement(sql);

			rs = ps.executeQuery();
			
			while(rs.next()) {
				Stadium stadium=new Stadium();
				
				stadium.setStadium_code(rs.getInt("stadium_code"));
				stadium.setStadium_name(rs.getString("stadium_name"));
				
				list.add(stadium);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(ps!=null)	ps.close();
				if(rs!=null)	rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return list;
	}
	
	@Override
	public void deleteMemberByUserid(Member member) {
		
		String sql = "";
		sql += " DELETE member WHERE userid = ?";
		
		try {
			ps = conn.prepareStatement(sql);
			
			ps.setString(1, member.getUserid());
		
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
	public void updateMemberByUserid(Member member) {
		String sql = "";
		sql += "UPDATE member ";
		sql += " SET userpw=?, usernick=?, phone=?, email=?, myteam=?";
		sql += " WHERE userid = ?";
	
		try {
			ps = conn.prepareStatement(sql);
			
			ps.setString(1, member.getUserpw());
			ps.setString(2, member.getUsernick());
			ps.setString(3, member.getPhone());
			ps.setString(4, member.getEmail());
			ps.setString(5, member.getMyteam());
			ps.setString(6, member.getUserid());
			
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
	public Board_1to1 selectBoardByBoardno(Board_1to1 my1to1view) {

		String sql = "";
		sql += "SELECT boardno, writer_userid, ";
		sql += "writer_email, title, content, writtendate FROM board_1to1";
		sql += " WHERE boardno = ?";
		
		try { 
			ps = conn.prepareStatement(sql);
			
			ps.setInt(1, my1to1view.getBoardno());
			
			rs = ps.executeQuery();
			
			while( rs.next() ) {
				
				my1to1view.setBoardno( rs.getInt("boardno") );
				my1to1view.setWriter_userid( rs.getString("writer_userid") );
				my1to1view.setWriter_email( rs.getString("writer_email") );
				my1to1view.setTitle( rs.getString("title") );
				my1to1view.setContent( rs.getString("content") );
				my1to1view.setWrittendate( rs.getDate("writtendate") );
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
		
		
		return my1to1view;
	}
	
	@Override
	public List<Ticket> selectTicketCodeByReservecode(String reserve_code) {
		
		String sql="";
		sql += "SELECT ticket_code";
		sql += " FROM reserve";
		sql += " WHERE reserve_code = ?";

		
		List<Ticket> ticketList=new ArrayList<>();
		
		try {
			ps=conn.prepareStatement(sql);
			ps.setString(1, reserve_code);
			
			rs=ps.executeQuery();
			
			while(rs.next()) {
				Ticket ticket = new Ticket();
				
				ticket.setTicket_code(rs.getInt("ticket_code"));
				
				ticketList.add(ticket);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(ps!=null)	ps.close();
				if(rs!=null)	rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return ticketList;
	}
	
	@Override
	public void deleteTicket(Ticket ticket) {
		
		String sql = "";
		sql += "DELETE ticket";
		sql += " WHERE ticket_code = ?";
	
		try {
			ps = conn.prepareStatement(sql);
			
			ps.setInt(1, ticket.getTicket_code());
			
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
	public void deleteReserveByReserveCode(String reserve_code) {
		
		String sql = "";
		sql += "DELETE reserve";
		sql += " WHERE reserve_code = ?";
	
		try {
			ps = conn.prepareStatement(sql);
			
			ps.setString(1, reserve_code);
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

}
