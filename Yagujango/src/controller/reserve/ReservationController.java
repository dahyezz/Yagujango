package controller.reserve;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.Match;
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
		String cnt = request.getParameter("count"); // 내가 고른 티켓매수
		
		if(deleteparam.equals("delete")) { // parameter가 delete일 경우 ticket테이블 삭제
			String ticketcd = request.getParameter("ticket_code"); // 삭제용 ticket_code
			System.out.println("삭제");
			int ticketcod = Integer.parseInt(ticketcd);
			int count = Integer.parseInt(cnt);
			
			for(int i = ticketcod; i < ticketcod+count; i++) {
				reserveService.deletetSeatInfoByTicket(i); // ticket테이블 삭제
			}
		}
		
		if(deleteparam.equals("insert")) { // parameter가 insert일 경우 reserve테이블 삽입
			Reserve reserve = new Reserve();
			int ticketcnt = Integer.parseInt(cnt);
			String memberno = request.getParameter("userno");
			String match = request.getParameter("match_code");
			String payment = request.getParameter("payment");
			String payment_date = request.getParameter("match_date"); // reserve에 날짜를 insert하기 위한 date형 파라미터
			String string_date = request.getParameter("match_date"); // reserve에 예매코드에 날짜를표현하기 위해  string형 파라미터
			String stringdate = string_date.replace("-", "");
			String receive = request.getParameter("receive");
			String[] Arrayticket = request.getParameterValues("ticket_code"); // 내가고른 좌석이 여러개일 경우 티켓코드는 여러개 생성 -> 배열로 방아와야함
			
			for(int i=0; i < ticketcnt; i++) { // 티켓매수를 통해 reserve테이블에 반복 insert.... -> 더 좋은 방법이 있을까?
				int userno = Integer.parseInt(memberno);
				int matchcode = Integer.parseInt(match);
				int codedate = Integer.parseInt(stringdate);
				
				reserve.setTicket_code(Integer.parseInt(Arrayticket[i]));
				reserve.setPayment(payment);
				reserve.setUserno(userno);
				reserve.setPayment_date(reserveService.StringToDate(payment_date)); // String date를 java.sql.date로 바꾸기
				reserve.setHow_receive(receive);
				
				reserveService.insertReserve(reserve, codedate, matchcode, userno); // reserve테이블 삽입
				// -> reserve테이블 resserve_code에 int형파라미터를 전부합쳐서 reserve_code 보여주기..... -> 다른방법이 생각이 안남...
			}
		}
	}
}