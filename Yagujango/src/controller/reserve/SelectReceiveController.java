package controller.reserve;

import java.io.IOException;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.Match;
import dto.Member;
import dto.Seat;
import dto.Stadium;
import dto.Ticket;
import service.face.ReserveService;
import service.impl.ReserveServiceImpl;

@WebServlet("/reserve/receive")
public class SelectReceiveController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private ReserveService reserveService = new ReserveServiceImpl();
	private Match match = new Match();
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 세션 객체 얻기
		HttpSession session = request.getSession();
		// userno 가져오기
		String userid = (String) session.getAttribute("userid");
		Member memberno = new Member();
		memberno = reserveService.getUserNo(userid);
		request.setAttribute("memberno", memberno);
		
		String cnt = request.getParameter("count");
		int count = Integer.parseInt(cnt);
		
		Match match = reserveService.getMatchCode(request);
		match = reserveService.getMatchInfo(match);
		System.out.println(match);
		request.setAttribute("match", match);
		
		Stadium stadium = reserveService.getStadiumInfo(match); //구장 정보
		request.setAttribute("stadium", stadium);


		// - - - ticket, seat 불러오기 - - -
		List<Ticket> ticketinfo = reserveService.getSelectSeatTicketinfo(match, count); // ticket 예매정보확인(My예매내역)
		request.setAttribute("ticketinfo", ticketinfo);

		List<Seat> seatinfo = reserveService.getSelectSeatInfo(ticketinfo, count);
		request.setAttribute("seatinfo", seatinfo);
		// - - - - - - - - - - - - - - - - - 
		
		String formatdate = reserveService.formatdate(match);
		request.setAttribute("formatdate", formatdate);
		
		request.getRequestDispatcher("/WEB-INF/views/reserve/receive.jsp").forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		// 수령방법선택창에서 좌석페이지로 돌아갈때 ticket의 좌석정보 delete
		reserveService.deleteTicket(request);

		// 좌석 선택 페이지로 리다이렉트
		match = reserveService.getMatchCode(request);
		response.sendRedirect("/reserve/seat?match_code="+match.getMatch_code());
	}
}
