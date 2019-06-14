package controller.member;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.Member;
import dto.Reserve;
import dto.Ticket;
import service.face.MemberService;
import service.impl.MemberServiceImpl;

@WebServlet("/mypage/ticket")
public class MypageTicketController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private MemberService memberService = new MemberServiceImpl();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		req.setCharacterEncoding("utf-8");
		
		Member member=new Member();
		member.setUserid((String)req.getSession().getAttribute("userid"));
		
		//세션에서 요청한 userid로 사용자 정보 조회
		memberService.getMemberByUserid(member);
		
		Reserve reserve = new Reserve();
		reserve.setUserno(member.getUserno());
		
		// -----------------------------------------------------------------
		
		List<Reserve> reserveList = memberService.getReserveList(reserve); //reserve table 조회
		List<Ticket> ticketList = memberService.getTicketList(reserveList); //ticket table 조회
	
		
	
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
