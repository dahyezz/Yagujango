package controller.member;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.Match;
import dto.Member;
import dto.Reserve;
import dto.Seat;
import dto.Stadium;
import dto.Ticket;
import service.face.MemberService;
import service.impl.MemberServiceImpl;
import util.Paging;

@WebServlet("/mypage/ticket")
public class MypageTicketController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private MemberService memberService = new MemberServiceImpl();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		req.setCharacterEncoding("utf-8");
		String reserve_code = req.getParameter("reserve_code");
		req.setAttribute("reserve_code", reserve_code);
//		System.out.println(reserve_code);
		
		Member member=new Member();
		member.setUserid((String)req.getSession().getAttribute("userid"));
		
		//세션에서 요청한 userid로 사용자 정보 조회
		memberService.getMemberByUserid(member);
		req.setAttribute("member", member);
		
		Reserve reserve = new Reserve();
		reserve.setUserno(member.getUserno());
		
		//예매 번호
		Paging mypagepaging=memberService.getCurPage(req,reserve);
		req.setAttribute("paging", mypagepaging);
		
		List<Reserve> reservecodeList=memberService.getReservecodeList(mypagepaging,reserve);
		req.setAttribute("reservecodeList",reservecodeList);
		
		// -----------------------------------------------------------------
		
		List<Reserve> reserveList = memberService.getReserveList(reserve); //reserve table 조회
		List<Ticket> ticketList = memberService.getTicketList(reserveList); //ticket table 조회
		List<Seat> seatList = memberService.getSeatList(ticketList); //seat table조회
		List<Match> matchList = memberService.getMatchList(ticketList); //match table 조회
		List<Stadium> stadiumList = memberService.getStadiumList(matchList); //stadium table 조회
		
		req.setAttribute("reserveList", reserveList);
		req.setAttribute("ticketList", ticketList);
		req.setAttribute("seatList", seatList);
		req.setAttribute("matchList", matchList);
		req.setAttribute("stadiumList", stadiumList);
		
		List<Integer> countList = new ArrayList<Integer>();
		int count = 0;
		
		for(int i=0; i<reserveList.size()-1; i++) {
			if(reserveList.get(i).getReserve_code().equals(reserveList.get(i+1).getReserve_code())) {
				count++;
			}
			countList.add(count);
			count = 0;
		}
		
		for(Integer e : countList)
			System.out.println(e);
		
		req.getRequestDispatcher("/WEB-INF/views/member/myticket.jsp").forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		// - - - reserve_code 파라미터 파싱 - - - 
		
		String reserve_code = req.getParameter("reserve_code");
//		System.out.println(reserve_code);
		// - - - - - - - - - - - - - - - - - - - -
		
		memberService.cancleMyTicket(reserve_code);
		
		resp.sendRedirect("/mypage/ticket");
		
	}
}
