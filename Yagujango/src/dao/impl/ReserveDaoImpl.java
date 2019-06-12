package dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import dao.face.ReserveDao;
import dbutil.DBConn;
import dto.Match;
import dto.Member;
import dto.Reserve;
import dto.Seat;
import dto.Stadium;
import dto.Ticket;

public class ReserveDaoImpl implements ReserveDao {
	//DB관련 객체
	private Connection conn = DBConn.getConnection(); 

	private PreparedStatement ps = null;
	private ResultSet rs = null;
	
	@Override
	public List<Stadium> selectAllStaidum() {
		String sql = "";
		sql += "SELECT stadium_code, stadium_name, stadium_logo, team_name FROM stadium";
		
		List<Stadium> list = new ArrayList<>();
		
		try {
			ps = conn.prepareStatement(sql);
			
			rs = ps.executeQuery();
			
			while( rs.next()) {
				Stadium stadium = new Stadium();
				
				stadium.setStadium_code(rs.getInt("stadium_code"));
				stadium.setStadium_name(rs.getString("stadium_name"));
				stadium.setStadium_logo(rs.getString("stadium_logo"));
				stadium.setTeam_name(rs.getString("team_name"));
				
				list.add(stadium);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			try {
				// 자원 해제
				if(rs!=null)	rs.close();
				if(ps!=null)	ps.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return list;
	}
	
	@Override
	public List<Match> selectAllByStadiumcode(Stadium stadium) {
		
		String sql = "";
//		sql += "SELECT match_code, hometeam_code, to_char(match_date, 'mm.dd') match_date, hometeam_name, awayteam_name";
		sql += "SELECT match_code, hometeam_code, match_date, hometeam_name, awayteam_name";
		sql += " FROM match";
		sql += " WHERE hometeam_code = ?";
//		sql += " AND match_date >= sysdate";
		sql += " ORDER BY match_code";
		
		List<Match> matchList = new ArrayList<Match>();
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, stadium.getStadium_code());
			
			rs = ps.executeQuery();
			
			while(rs.next()) {
				
				Match match = new Match();
				
				match.setMatch_code(rs.getInt("match_code"));
				match.setHometeam_code(rs.getInt("hometeam_code"));
				match.setMatch_date(rs.getDate("match_date"));
				match.setHometeam_name(rs.getString("hometeam_name"));
				match.setAwayteam_name(rs.getString("awayteam_name"));
				
				matchList.add(match);
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
		
		return matchList;
	}

	@Override
	public Match selectMatchByMatchCode(Match match) {
		
		String sql = "";
		sql += "SELECT match_code, hometeam_code, match_date, hometeam_name, awayteam_name";
		sql += " FROM match where match_code = ? ";
		
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, match.getMatch_code());
			
			rs = ps.executeQuery();
			
			while(rs.next()) {
				match.setMatch_code(rs.getInt("match_code"));
				match.setHometeam_code(rs.getInt("hometeam_code"));
				match.setMatch_date(rs.getDate("match_date"));
				match.setHometeam_name(rs.getString("hometeam_name"));
				match.setAwayteam_name(rs.getString("awayteam_name"));
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
		
		return match;
	}

	@Override
	public Stadium selectStadiumByHometeamCode(Match match) {
		
		String sql = "";
		sql += " SELECT * FROM stadium";
		sql += " WHERE stadium_code = ?";
		
		Stadium stadium = new Stadium();
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, match.getHometeam_code());
			
			rs = ps.executeQuery();
			
			while(rs.next()) {
				stadium.setStadium_code(rs.getInt("stadium_code"));
				stadium.setStadium_name(rs.getString("stadium_name"));
				stadium.setStadium_logo(rs.getString("stadium_logo"));
				stadium.setTeam_name(rs.getString("team_name"));
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
		
		return stadium;	
	}

	@Override
	public List<Seat> selectEmptySeatByMatchCode(Match match) {
		
		String sql = "";
		sql += "SELECT seat_code, seat_block, seat_number, price";
		sql += " FROM seat";
		sql += " WHERE seat_code NOT IN(";
		sql += "     SELECT seat_code";
		sql += "     FROM ticket";
		sql += "     WHERE match_code = ? ";
		sql += " )";
		sql += " ORDER BY seat_code";
		
		List<Seat> seatList = new ArrayList<Seat>();
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, match.getMatch_code());
			
			rs = ps.executeQuery();
			
			while(rs.next()) {
				Seat seat = new Seat();
				
				seat.setSeat_code(rs.getInt("seat_code"));
				seat.setSeat_block(rs.getString("seat_block"));
				seat.setSeat_number(rs.getInt("seat_number"));
				seat.setPrice(rs.getInt("price"));
				
				seatList.add(seat);
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
		
		return seatList;
	}

	@Override
	public List<Ticket> selectAllTicketByMatchCode(Match match) {
		
		String sql = "";
		sql += "SELECT ticket_code, match_code, seat_code";
		sql += " FROM ticket ";
		sql += " WHERE match_code = ?";
		
		List<Ticket> ticketList = new ArrayList<Ticket>();
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, match.getMatch_code());
			
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
				if(rs!=null)	rs.close();
				if(ps!=null)	ps.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return ticketList;
	}

	@Override
	public List<Ticket> selectTicketInfo(Match match, int count) {
		
		String sql = "";
		sql += "SELECT rownum, ticket_code, match_code, seat_code";
		sql += " FROM (";
		sql += "    SELECT ticket_code, match_code, seat_code";
		sql += "    FROM ticket";
		sql += "    WHERE match_code = ?";
		sql += "    ORDER BY ticket_code desc)";
		sql += " WHERE rownum <= ? ";
		sql += " ORDER BY ticket_code";
		
		List<Ticket> ticketList = new ArrayList<Ticket>();
		
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, match.getMatch_code());
			ps.setInt(2, count);
			
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
				if(rs!=null)	rs.close();
				if(ps!=null)	ps.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return ticketList;
		
	}
	
	@Override
	public Seat selectSeatInfo(int seat_code) {
		
		String sql = "";
		sql += "SELECT seat_code, seat_block, seat_number, price";
		sql += " FROM seat";
		sql += " WHERE seat_code = ? ";
		
		Seat seat = new Seat();
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, seat_code);
			
			rs = ps.executeQuery();
			
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
				if(rs!=null)	rs.close();
				if(ps!=null)	ps.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return seat;
	}

	@Override
	public Member getUserNo(String userid) {
		String sql = "";
		sql += "SELECT userno";
		sql += " FROM member";
		sql += " WHERE userid = ?";
		
		Member member = new Member();
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, userid.toString());
			
			rs = ps.executeQuery();
			
			while(rs.next()) {
				member.setUserno(rs.getInt("userno"));
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
		
		return member;	
	}
	
	@Override
	public int selectSeatcodeBySeatInfo(String seat_block, int seat_number) {
		
		String sql = "";
		sql += "SELECT seat_code FROM seat";
		sql += " WHERE seat_block = ?";
		sql += " AND seat_number = ?";
		
		int seat_code = 0;
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, seat_block);
			ps.setInt(2, seat_number);
			
			rs = ps.executeQuery();
			
			while(rs.next()) {
				seat_code = rs.getInt("seat_code");
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
		
		return seat_code;	
	}
	
	@Override
	public void insertTicket(Match match, int seat_code) {
		
		String sql = "";
		sql += "INSERT INTO ticket (ticket_code, match_code, seat_code)";
		sql += " VALUES (ticket_seq.nextval, ?, ?)";
		
		try {
			//DB작업
			ps = conn.prepareStatement(sql);
			ps.setInt(1, match.getMatch_code());
			ps.setInt(2, seat_code);

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
	public int selectNewTicketCode(Match match, int seat_code) {
		
		String sql = "";
		sql += "SELECT ticket_code ";
		sql += " FROM ticket";
		sql += " WHERE match_code = ?";
		sql += " AND seat_code = ?";
		
		int ticket_code = 0;
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, match.getMatch_code());
			ps.setInt(2, seat_code);
			
			rs = ps.executeQuery();
			
			while(rs.next()) {
				ticket_code = rs.getInt("ticket_code");
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
		
		return ticket_code;	
	}
	@Override
	public List<Seat> getReservedSeatListByMatchCode(Match match) {
		
		String sql = "";
		sql += "SELECT seat_code, seat_block, seat_number";
		sql += " FROM seat";
		sql += " WHERE seat_code IN (";
		sql += "                 SELECT seat_code";
		sql += "                 FROM ticket";
		sql += "                 WHERE match_code=?";
		sql += "                 )";
		sql += " ORDER BY seat_code";
		
		List<Seat> reservedSeatList = new ArrayList<Seat>();
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, match.getMatch_code());
			
			rs = ps.executeQuery();
			
			while(rs.next()) {
				Seat seat = new Seat();
				
				seat.setSeat_code(rs.getInt("seat_code"));
				seat.setSeat_block(rs.getString("seat_block"));
				seat.setSeat_number(rs.getInt("seat_number"));

				reservedSeatList.add(seat);
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
		
		return reservedSeatList;

	}

	@Override
	public void deletetSeatInfoByTicket(int ticketcode) {
		
		String sql = "";
		sql += "DELETE FROM ticket";
		sql += " WHERE ticket_code = ?";
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, ticketcode);
			
			ps.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				// 자원 해제
				if(ps!=null)	ps.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	
	@Override
	public void insertReserve(Reserve reserve, String stringdate, String match, int userno) {
		String sql = "";

		sql += "INSERT INTO reserve (reserve_code, ticket_code, userno, payment, payment_date , how_receive)";
		sql += " VALUES (?||?||?, ?, ?, ?,(to_date(sysdate,'yyyy-MM-dd')), ?)";

		try {
			//DB작업
			ps = conn.prepareStatement(sql);
			
//			ps.setInt(1, codedate);
//			ps.setInt(2, matchcode);
			ps.setString(1, stringdate);
			ps.setString(2, match);
			ps.setInt(3, userno);

			ps.setInt(4, reserve.getTicket_code());
			ps.setInt(5, reserve.getUserno());
			ps.setString(6, reserve.getPayment());
//			ps.setDate(7, (Date)reserve.getPayment_date());
			ps.setString(7, reserve.getHow_receive());

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
	public List<Seat> selectAllSeat() {
		
		String sql = "";
		sql += "SELECT seat_code, seat_block, seat_number, price";
		sql += " FROM seat";
		sql += " ORDER BY seat_code";
		
		List<Seat> allList = new ArrayList<Seat>();
		
		try {
			ps = conn.prepareStatement(sql);
			
			rs = ps.executeQuery();
			
			while(rs.next()) {
				Seat seat = new Seat();
				
				seat.setSeat_code(rs.getInt("seat_code"));
				seat.setSeat_block(rs.getString("seat_block"));
				seat.setSeat_number(rs.getInt("seat_number"));
				seat.setPrice(rs.getInt("price"));

				allList.add(seat);
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
		
		return allList;

	}


	@Override
	public Member getMember(int memno) {
		Member member = new Member();
		
		String sql = "";
		sql += "SELECT * FROM member";
		sql += " WHERE userno = ?";
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, memno);
			
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
		} finally {
			try {
				// 자원 해제
				if(rs!=null)	rs.close();
				if(ps!=null)	ps.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
        
		return member;
	}

	
	@Override
	public void updateBarcode(Reserve reserve, String barcode) {
		
		String sql = "";
		sql += "UPDATE reserve";
		sql += " SET barcode = ? ";
		sql += " WHERE ticket_code = ?";
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, barcode);
			ps.setInt(2, reserve.getTicket_code());
			
			ps.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				// 자원 해제
				if(ps!=null)	ps.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	@Override
	public List<Match> selectThreeMatchList() {
		
		String sql = "";
		sql += "SELECT match_code, hometeam_code, to_char(match_date, 'yyyy/MM/dd:HH24:MI') match_date, hometeam_name, awayteam_name";
		sql += " FROM match";
		sql += " WHERE match_date >= sysdate";
		sql += " AND match_date < sysdate + 3";
		sql += " ORDER BY match_code";
		
		List<Match> matchList = new ArrayList<Match>();
		
		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			
			while(rs.next()) {
				Match match = new Match();
				
				match.setMatch_code(rs.getInt("match_code"));
				match.setHometeam_code(rs.getInt("hometeam_code"));
//				match.setMatch_date((Date)rs.getString("match_date"));
				match.setMatch_date(new SimpleDateFormat("yyyy/MM/dd:HH:mm").parse(rs.getString("match_date")));
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
				// 자원 해제
				if(rs!=null)	rs.close();
				if(ps!=null)	ps.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		    
		return matchList;
	}



}
