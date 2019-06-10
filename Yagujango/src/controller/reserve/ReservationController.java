package controller.reserve;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.Match;
import dto.Stadium;
import dto.Ticket;
import service.face.ReserveService;
import service.impl.ReserveServiceImpl;

@WebServlet("/reserve/payment")
public class ReservationController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ReserveService reserveService = new ReserveServiceImpl();
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String memberno = request.getParameter("userno");
		System.out.println("payment : " + memberno);
		request.setAttribute("memberno", memberno);
		
		String ticketcd = request.getParameter("ticket_code");
		String cnt = request.getParameter("count");
		int ticketcode = Integer.parseInt(ticketcd);
		int count = Integer.parseInt(cnt);
		request.setAttribute("ticketcode", ticketcode);
		request.setAttribute("count", count);
		
		String receive = request.getParameter("receive"); // 수령방법 받아오기
		request.setAttribute("receive", receive);
		System.out.println(receive); // TEST
		
		Match match = reserveService.getMatchCode(request);
		match = reserveService.getMatchInfo(match);
		System.out.println(match); //TEST
		request.setAttribute("match", match);
		
		Stadium stadium = reserveService.getStadiumInfo(match); //구장 정보
		request.setAttribute("stadium", stadium);
				
		List<Ticket> seatinfo = reserveService.getSeatInfoByTicket(match); // ticket 예매정보확인(My예매내역)
		System.out.println(seatinfo); // TEST
		request.setAttribute("seatinfo", seatinfo);
		
		request.getRequestDispatcher("/WEB-INF/views/reserve/payment.jsp").forward(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String deleteparam = request.getParameter("deleteparam");
//		System.out.println(deleteparam);
		
		if(deleteparam.equals("delete")) {
			reserveService.deleteTicket(request);
		}
		
		if(deleteparam.equals("insert")) {
			reserveService.insertReserve(request); // reserve테이블 insert
		}

		request.getRequestDispatcher("/WEB-INF/views/reserve/payment.jsp").forward(request, response);
	}
}