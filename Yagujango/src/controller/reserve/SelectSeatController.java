package controller.reserve;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.Match;
import dto.Seat;
import dto.Stadium;
import dto.Ticket;
import service.face.ReserveService;
import service.impl.ReserveServiceImpl;

@WebServlet("/reserve/seat")
public class SelectSeatController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private ReserveService reserveService = new ReserveServiceImpl();
	private Match match = new Match();
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		match = reserveService.getMatchCode(request);
		match = reserveService.getMatchInfo(match);
//		System.out.println(match); //TEST
		
		request.setAttribute("match", match);
		
		Stadium stadium = reserveService.getStadiumInfo(match); //구장 정보
		request.setAttribute("stadium", stadium);
		
		List<Seat> seatAvailable = reserveService.getSeatInfo(match); // 예매 가능한 좌석
		request.setAttribute("seat", seatAvailable);
		
		List<Integer> seatCount = reserveService.getSeatCount(match); //예매 가능한 좌석 카운트
//		System.out.println(seatCount); //TEST
		request.setAttribute("seatCount", seatCount);
		
		List<Ticket> ticket = reserveService.getReserveStatus(match); //예매현황
		request.setAttribute("ticket", ticket);
				
		List<String> seatBlock = reserveService.getSeatBlock();
		request.setAttribute("seatBlock", seatBlock);
		
		List<Integer> seatNumber = reserveService.getSeatNumber();
		request.setAttribute("seatNumber", seatNumber);
		
		// ------ TEST -----------
		//	좌석 disabled 되는지 check
		List<Seat> resvdSeatList = reserveService.getResevedSeatList(match);
//		System.out.println(resvdSeatList);
		request.setAttribute("resvdSeatList", resvdSeatList);
		
		// -----------------------

		
		request.getRequestDispatcher("/WEB-INF/views/reserve/selectseat.jsp").forward(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String selectseat = request.getParameter("selectseat");
//		System.out.println(selectseat); //TEST 
		
		
		List<Integer> newTicketList = reserveService.addTicket(match, selectseat);
	
//		for(Integer e : newTicketList) {
//			System.out.println(e);
//		}
//		System.out.println("newTicketList Size : " + newTicketList.size());
//		System.out.println("first : " + newTicketList.get(0));
		
		response.sendRedirect("/reserve/receive?match_code="+match.getMatch_code()+"&ticket_code="
										+newTicketList.get(0)+"&count="+newTicketList.size());
	}
}