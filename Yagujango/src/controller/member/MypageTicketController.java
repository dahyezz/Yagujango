package controller.member;

import java.io.IOException;
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
//		로그인 되어있지 않으면 리다이렉트 
		if( req.getSession().getAttribute("login") == null ) {
			resp.sendRedirect("/member/login");
			return;
		}
		
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
		
		int term = 15;
		
		List<Reserve> reservecodeList=memberService.getReservecodeListByTerm(term, reserve);
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
				
		//매수 count
		List<Integer> seatCntList=memberService.getCntSeatList(reservecodeList);
		req.setAttribute("seatCntList",seatCntList);
		
		req.getRequestDispatcher("/WEB-INF/views/member/myticket.jsp").forward(req, resp);
	}

}
