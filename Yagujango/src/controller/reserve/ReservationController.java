package controller.reserve;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.Match;
import dto.Member;
import dto.Reserve;
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
		System.out.println(deleteparam);
		String ticketcd = request.getParameter("ticket_code");
		String cnt = request.getParameter("count");
		
		// 수령방법선택창에서 좌석페이지로 돌아깔때 ticket의 좌석정보 delete
		if(deleteparam == "delete") {
			int ticketcod = Integer.parseInt(ticketcd);
			int count = Integer.parseInt(cnt);
			
			for(int i = ticketcod; i < ticketcod+count; i++) {
				reserveService.deletetSeatInfoByTicket(i);
			}
		}
		/////////////////////////////////////////////////////
		
		if(deleteparam == "insert") {
			String memberno = request.getParameter("userno");
			System.out.println("paymentpost : " + memberno);
			String ticketcode = request.getParameter("ticket_code");
	
			String payment = request.getParameter("payment");
			String payment_date = request.getParameter("match_date");
			String receive = request.getParameter("receive");
			
			int ticket_code = Integer.parseInt(ticketcode);
			int userno = Integer.parseInt(memberno);
			
			Reserve reserve = new Reserve();
			reserve.setTicket_code(ticket_code);
			reserve.setPayment(payment);
			reserve.setUserno(userno);
			reserve.setPayment_date(reserveService.StringToDate(payment_date)); // String date를 java.sql.date로 바꾸기
			reserve.setHow_receive(receive);
			
			reserveService.insertReserve(reserve);
		}
		
	}
}