package controller.reserve;

import java.io.IOException;
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
		
		Match match = reserveService.getMatchCode(request);
		match = reserveService.getMatchInfo(match);
//		System.out.println(match); //TEST
		
		request.setAttribute("match", match);
		
		Stadium stadium = reserveService.getStadiumInfo(match); //구장 정보
		request.setAttribute("stadium", stadium);

		List<Ticket> seatinfo = reserveService.getSeatInfoByTicket(match); // ticket 예매정보확인(My예매내역)
		System.out.println(seatinfo); // TEST

		request.setAttribute("seatinfo", seatinfo);

		request.getRequestDispatcher("/WEB-INF/views/reserve/receive.jsp").forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		match = reserveService.getMatchCode(request);
		match = reserveService.getMatchInfo(match);
		
		request.setAttribute("match", match);
		
		Stadium stadium = reserveService.getStadiumInfo(match); //구장 정보
		request.setAttribute("stadium", stadium);
		
		// 수령방법선택창에서 좌석페이지로 돌아깔때 ticket의 좌석정보 delete
		String ticketcd = request.getParameter("ticket_code");
		String cnt = request.getParameter("count");
		int ticketcode = Integer.parseInt(ticketcd);
		int count = Integer.parseInt(cnt);
		
		for(int i = ticketcode; i < ticketcode+count; i++) {
			reserveService.deletetSeatInfoByTicket(i);
		}
		/////////////////////////////////////////////////////
		
		List<Seat> seatAvailable = reserveService.getSeatInfo(match); // 예매 가능한 좌석
		request.setAttribute("seat", seatAvailable);
		
		List<Integer> seatCount = reserveService.getSeatCount(match); //예매 가능한 좌석 카운트
		request.setAttribute("seatCount", seatCount);
		
		List<Ticket> ticket = reserveService.getReserveStatus(match); //예매현황
		request.setAttribute("ticket", ticket);
				
		List<String> seatBlock = reserveService.getSeatBlock();
		request.setAttribute("seatBlock", seatBlock);
		
		List<Integer> seatNumber = reserveService.getSeatNumber();
		request.setAttribute("seatNumber", seatNumber);
		
		request.getRequestDispatcher("/WEB-INF/views/reserve/selectseat.jsp").forward(request, response);
	}
}
