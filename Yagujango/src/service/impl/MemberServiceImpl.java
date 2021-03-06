package service.impl;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import dao.face.MemberDao;
import dao.impl.MemberDaoImpl;
import dto.Board_1to1;
import dto.Match;
import dto.Member;
import dto.Reserve;
import dto.Seat;
import dto.Stadium;
import dto.Ticket;
import service.face.MemberService;
import util.Paging;

public class MemberServiceImpl implements MemberService{

	private MemberDao memberDao = new MemberDaoImpl();
	
	@Override
	public Member getLoginMember(HttpServletRequest req) {
		
		Member member = new Member();
		
		member.setUserid(req.getParameter("userid"));
		member.setUserpw(req.getParameter("userpw"));
		
		return member;
	}

	@Override
	public boolean login(Member member) {
		
		if(memberDao.selectCntMemberByUserid(member) >= 1)
			return true;
		else
			return false;
	}

	@Override
	public Member getMemberByUserid(Member member) {
	
		return memberDao.selectMemberByUserid(member);
	}

	@Override
	public boolean idFind(Member member) {
		if(memberDao.selectCntMemberIdfind(member) >= 1)
			return true;
		else
			return false;
	}

	@Override
	public Member getIdfind(Member member) {
		
		return memberDao.selectMemberIdfind(member);
	}

	@Override
	public boolean pwFind(Member member) {
		if(memberDao.selectCntMemberPwfind(member) >= 1)
			return true;
		else
			return false;
	}

	@Override
	public Member getPwfind(Member member) {
		
		return memberDao.selectMemberPwfind(member);
	} 
	
	@Override
	public boolean join(Member member) {
		
		//회원가입(데이터베이스 삽입)
		memberDao.insert(member);
		
		//회원가입 성공 여부 판단
		if( memberDao.selectCntMemberByUserid(member) > 0 ) {
			return true; //회원가입 성공
		} else {
			return false; //회원가입 실패
		}
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
	public boolean idOverlap(Member member) {
		
		if(memberDao.selectCntMemberIdOverlap(member) >= 1)
			return true;
		else
			return false; 
	}

	@Override
	public boolean blacklistCheck(Member member) {
		
		if(memberDao.selectCntByBlacklist(member) >= 1)
			return false;
		else
			return true;
	}
	
	@Override
	public List<Board_1to1> getOneToOneList(String userid) {
		return memberDao.OneToOneSelectAll(userid); 
	}

	@Override
	public List<Reserve> getReservecodeList(Paging mypagepaging, Reserve reserve) {
		
		return memberDao.selectReservecodeByUserno(mypagepaging,reserve);
	}
	
	@Override
	public List<Reserve> getReservecodeListnotpaging(Reserve reserve) {
		return memberDao.selectReservecodeByUsernonotpaging(reserve);
	}

	@Override
	public Paging getCurPage(HttpServletRequest req,Reserve reserve) {

		//전달 파라미터 curPage 파싱
		String param=req.getParameter("curPage");
		int curPage=0;
		if(param!=null && !"".equals(param)) {
			curPage=Integer.parseInt(param);
		}
		
		//userno별 reserve_code 수
		int totalCount=memberDao.selectCntReservecode(reserve);
		int listCount = 5;
		int pageCount = 5;

		//페이징 객체 생성
		Paging paging=new Paging(totalCount,curPage, listCount,pageCount);
//		System.out.println(paging);
		
		return paging;
	}
	
	@Override
	public void modifyMemberInfo(Member member) {
		memberDao.updateMemberByUserid(member);
	}
	
	@Override
	public void leaveMember(Member member) {
		memberDao.deleteMemberByUserid(member);
	}

	@Override
	public List<Reserve> getReserveList(Reserve reserve) {
		
		return memberDao.selectReserveByUserno(reserve);
	}

	@Override
	public List<Ticket> getTicketList(List<Reserve> reserveList) {
		
		String ticket_code = "";
		
		for(Reserve reserve : reserveList) {
			ticket_code += reserve.getTicket_code();
			ticket_code += ",";
		}
//		System.out.println(ticket_code);
		if(ticket_code.charAt(ticket_code.length()-1) == ',') {
			ticket_code = ticket_code.substring(0,ticket_code.length()-1);
		}
		
		return memberDao.selectTicketByTicketcode(ticket_code);
		
//		List<Ticket> ticketList = new ArrayList<Ticket>();
//		
//		for(Reserve reserve : reserveList) {
//			Ticket ticket = memberDao.selectTicketByTicketcode(reserve);
//			
//			ticketList.add(ticket);
//		}
//		
////		for(Ticket ticket : ticketList)
////			System.out.println(ticket);
//		return ticketList;
	}

	@Override
	public List<Match> getMatchList(List<Ticket> ticketList) {

		String match_code = "";
		
		for(Ticket ticket : ticketList) {
			int matchcode = ticket.getMatch_code();
			match_code += matchcode;
			match_code += ",";
		}
		if(match_code.charAt(match_code.length()-1) == ',') {
			match_code = match_code.substring(0,match_code.length()-1);
		}
//		System.out.println(match_code);
		
		return memberDao.selectMatchByMatchcode(match_code);
	}

	@Override
	public List<Seat> getSeatList(List<Ticket> ticketList) {
		
		List<Seat> seatList = new ArrayList<Seat>();
		
		for(Ticket ticket : ticketList) {
			Seat seat = memberDao.selectSeatBySeatcode(ticket);
			
			seatList.add(seat);
		}
		
		return seatList;
	}
	
	@Override
	public List<Integer> getCntSeatList(List<Reserve> reservecodeList) {
		
		List<Integer> seatCntList = new ArrayList<Integer>();
		
		for(Reserve reserve : reservecodeList) {
			int seatCnt = memberDao.selectCntSeatByReservecode(reserve);
			
			seatCntList.add(seatCnt);
		}
		return seatCntList;

	}

	@Override
	public List<Stadium> getStadiumList(List<Match> matchList) {
		
		String hometeam_code = "";
		
		for(Match match : matchList) {
			int hometeamcode = match.getHometeam_code();
			hometeam_code += hometeamcode;
			hometeam_code += ",";
		}
		if(hometeam_code.charAt(hometeam_code.length()-1) == ',') {
			hometeam_code = hometeam_code.substring(0,hometeam_code.length()-1);
		}

		return memberDao.selectStadiumByStadiumcode(hometeam_code);

	}

	@Override
	public Board_1to1 getBoardno(HttpServletRequest req) {
		
		String param = req.getParameter("boardno");
		int boardno = 0;
		if( param!=null && !"".equals(param) ) {
			boardno = Integer.parseInt(param);
		}
		
		Board_1to1 board_1to1 = new Board_1to1();
		board_1to1.setBoardno(boardno);
		
		return board_1to1;
	}

	@Override
	public Board_1to1 view(Board_1to1 my1to1view) {

		return memberDao.selectBoardByBoardno(my1to1view);
	}
	
	@Override
	public void cancleMyTicket(String reserve_code) {
		
		//ticket_code 리스트 가져오기
		List<Ticket> ticketList = memberDao.selectTicketCodeByReservecode(reserve_code);
		
		//ticket 테이블 삭제
		for(Ticket e : ticketList) {
//			System.out.println(e);
			memberDao.deleteTicket(e);
		}
		
		//reserve 테이블 삭제
		memberDao.deleteReserveByReserveCode(reserve_code);
	}

	

}
