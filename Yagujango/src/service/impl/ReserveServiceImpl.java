package service.impl;


import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import dao.face.ReserveDao;
import dao.impl.ReserveDaoImpl;
import dto.Match;
import dto.Member;
import dto.Reserve;
import dto.Seat;
import dto.Stadium;
import dto.Ticket;
import service.face.ReserveService;

public class ReserveServiceImpl implements ReserveService{
	private ReserveDao reserveDao = new ReserveDaoImpl();
	
	@Override
	public Stadium getStadiumcode(HttpServletRequest request) {
		String param = request.getParameter("stadium_code");
		int stadiumcode = 0;
		if( param != null && !"".equals(param)) {
			stadiumcode = Integer.parseInt(param);
		}
		
		Stadium stadium =  new Stadium();
		stadium.setStadium_code(stadiumcode);
		
		return stadium;
	}
	
	@Override
	public List<Stadium> getList() {
		return reserveDao.selectAllStaidum();
	}
	
	@Override
	public List<Match> getMatchList(Stadium stadium) {
		return reserveDao.selectAllByStadiumcode(stadium);
	}

	@Override
	public Match getMatchCode(HttpServletRequest request) {
		String param = request.getParameter("match_code");
		int match_code = 0;
		if( param != null && !"".equals(param)) {
			match_code = Integer.parseInt(param);
		}
		
		Match match = new Match();
		match.setMatch_code(match_code);
		
		return match;
	}

	@Override
	public Match getMatchInfo(Match match) {
		return reserveDao.selectMatchByMatchCode(match);
	}

	@Override
	public Stadium getStadiumInfo(Match match) {
		return reserveDao.selectStadiumByHometeamCode(match);
	}

	@Override
	public List<Seat> getSeatInfo(Match match) {
		
		return reserveDao.selectEmptySeatByMatchCode(match);
	}

	@Override
	public List<Ticket> getReserveStatus(Match match) {
		return reserveDao.selectAllTicketByMatchCode(match);
	}

	
	@Override
	public List<String> getSeatBlock() {
		return reserveDao.selectSeatBlock();
	}
	
	@Override
	public List<Integer> getSeatNumber() {
		return reserveDao.selectSeatNumber();
	}

	@Override
	public List<Ticket> getSeatInfoByTicket(Match match) {
		return reserveDao.selectSeatInfo(match);
	}

	@Override
	public List<Integer> getSeatCount(Match match) {
		List<Seat> seatcount = reserveDao.selectEmptySeatByMatchCode(match);
		
		List<Integer> seatCountList = new ArrayList<Integer>();
		int[] seatCountArray = new int[5];
		
		for(Seat e : seatcount) {
			
			if(e.getSeat_block().equals("A")) {
				seatCountArray[0]++;
			} else if(e.getSeat_block().equals("B")) {
				seatCountArray[1]++;
			} else if(e.getSeat_block().equals("C")) {
				seatCountArray[2]++;
			} else if(e.getSeat_block().equals("D")) {
				seatCountArray[3]++;
			} else if(e.getSeat_block().equals("E")) {
				seatCountArray[4]++;
			}
			
		}
		
		for(int i=0; i<seatCountArray.length;i++)
			seatCountList.add(seatCountArray[i]);
		
		return seatCountList;
	}


	@Override
	public void insertReserve(Reserve receive) {
		reserveDao.insertReserve(receive);
	}

	@Override
	public Member getUserNo(String userid) {
		return reserveDao.getUserNo(userid);
	}

	@Override
	public Date StringToDate(String payment_date) {
		DateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date to = null;
		java.sql.Date sqlDate = null;
		try {
			to = transFormat.parse(payment_date);
			sqlDate = convert(to);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return sqlDate;
	}
	
	///////////////////// java.util.date -> java.sql.date /////////////////////
	private java.sql.Date convert(java.util.Date uDate) {
        java.sql.Date sDate = new java.sql.Date(uDate.getTime());
        return sDate;
	}
	
	@Override
	public List<Integer>  addTicket(Match match, String selectseat) {
		
		String[] seatList = selectseat.split(",");
		List<Integer> newTicketList = new ArrayList<Integer>();
		
		for(String e : seatList) {
			String seat_block = e.substring(0,1);
			String seatnumber = e.substring(e.lastIndexOf("_")+1);
			int seat_number = Integer.parseInt(seatnumber);
			
			//seat_code 알아오기
			int seat_code = reserveDao.selectSeatcodeBySeatInfo(seat_block, seat_number);
//			System.out.println("seat_code : " + seat_code); //TEST
			reserveDao.insertTicket(match, seat_code); 
			
			int ticket_code = reserveDao.selectNewTicketCode(match, seat_code);
//			System.out.println(ticket_code);
			newTicketList.add(ticket_code);
		}
		
		return newTicketList;
	
	}
	
	@Override
	public List<Seat> getResevedSeatList(Match match) {
		return reserveDao.getReservedSeatListByMatchCode(match);
	}
}
