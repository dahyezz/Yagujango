package dao.impl;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
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
	public List<String> selectSeatBlock() {
		
		String sql = "";
		sql += "SELECT seat_block";
		sql += " FROM seat";
		sql += " GROUP BY seat_block";
		sql += " ORDER BY seat_block";
		
		List<String> seatblockList = new ArrayList<>();
		
		try {
			ps = conn.prepareStatement(sql);
			
			rs = ps.executeQuery();
			
			while(rs.next()) {
				String seatblock = null;
				seatblock = rs.getString("seat_block");
				seatblockList.add(seatblock);
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
		
		return seatblockList;
	}
	
	@Override
	public List<Integer> selectSeatNumber() {
		
		String sql = "";
		sql += "SELECT seat_number";
		sql += " FROM seat";
		sql += " GROUP BY seat_number";
		sql += " ORDER BY seat_number";
		
		List<Integer> seatnumberList = new ArrayList<>();
		
		try {
			ps = conn.prepareStatement(sql);
			
			rs = ps.executeQuery();
			
			while(rs.next()) {
				int seatnumber = 0;
				seatnumber = rs.getInt("seat_number");
				seatnumberList.add(seatnumber);
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
		
		return seatnumberList;
	}

	@Override
	public List<Ticket> selectSeatInfo(Match match) {
		String sql = "";
		sql += "SELECT ticket.ticket_code, ticket.match_code, seat.seat_code, seat.seat_block, seat.seat_number, seat.price";
		sql += " FROM ticket";
		sql += " INNER JOIN seat";
		sql += " ON ticket.seat_code = seat.seat_code AND ticket.match_code = ?";
		
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
				ticket.setSeat_block(rs.getString("seat_block"));
				ticket.setSeat_number(rs.getInt("seat_number"));
				ticket.setPrice(rs.getInt("price"));
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
	public void insertReserve(Reserve receive) {
		String sql = "";
		sql += "INSERT INTO reserve (reserve_code, ticket_code, userno, payment, payment_date, ticket_quantity, how_receive)";
		sql += " VALUES (reserve_seq.nextval, ?, ?, ?, ?, 1, ?)";
		try {
			//DB작업
			ps = conn.prepareStatement(sql);
			ps.setInt(1, receive.getTicket_code());
			ps.setInt(2, receive.getUserno());
			ps.setString(3, receive.getPayment());
			ps.setDate(4, (Date) receive.getPayment_date());
			ps.setString(5, receive.getHow_receive());

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

}
