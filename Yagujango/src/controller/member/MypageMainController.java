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

@WebServlet("/mypage/main")
public class MypageMainController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private MemberService memberService=new MemberServiceImpl();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		req.setCharacterEncoding("utf-8");
		
		Member member=new Member();
		member.setUserid((String)req.getSession().getAttribute("userid"));
		
		//세션에서 요청한 userid로 사용자 정보 조회
		memberService.getMemberByUserid(member);
		
		//view에 모델값 전달
		req.setAttribute("userid", (String)member.getUserid());
		req.setAttribute("usernick", (String)member.getUsernick());
		req.setAttribute("myteam", (String)member.getMyteam());
		
		//---------- 예매 확인 ----------------
		Reserve reserve=new Reserve();
		reserve.setUserno(member.getUserno());
		
		//예매 번호
		Paging mypagepaging=memberService.getCurPage(req,reserve);
		req.setAttribute("paging", mypagepaging);
		
		List<Reserve> reservecodeList=memberService.getReservecodeList(mypagepaging,reserve);
		req.setAttribute("reservecodeList",reservecodeList);
		
		//Reserve 리스트 조회
		List<Reserve> reserveList=memberService.getReserveList(reserve);
		req.setAttribute("reserveList",reserveList);
		
		//Ticket 리스트 조회
		List<Ticket> ticketList=memberService.getTicketList(reserveList);
		req.setAttribute("ticketList",ticketList);
		
		//Match 리스트 조회
		List<Match> matchList=memberService.getMatchList(ticketList);
		req.setAttribute("matchList",matchList);
		
		//Seat 리스트 조회
		List<Seat> seatList=memberService.getSeatList(ticketList);
		req.setAttribute("seatList",seatList);
		System.out.println(seatList);
		
		//매수 count
		List<Integer> seatCntList=memberService.getCntSeatList(reservecodeList);
		req.setAttribute("seatCntList",seatCntList);
		System.out.println(seatCntList);
		
		//View JSP 지정하기
		req.getRequestDispatcher("/WEB-INF/views/member/myPage.jsp").forward(req, resp);
	}
}
