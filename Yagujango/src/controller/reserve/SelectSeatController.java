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
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		Match match = reserveService.getMatchCode(request);
		match = reserveService.getMatchInfo(match);
//		System.out.println(match); //TEST
		
		request.setAttribute("match", match);
		
		Stadium stadium = reserveService.getStadiumInfo(match); //구장 정보
		request.setAttribute("stadium", stadium);
		
		List<Seat> seat = reserveService.getSeatInfo(match); // 예매 가능한 좌석
		request.setAttribute("seat", seat);
		
		List<Ticket> ticket = reserveService.getReserveStatus(match); //예매현황
		request.setAttribute("ticket", ticket);
				
		List<String> seatBlock = reserveService.getSeatBlock();
		request.setAttribute("seatBlock", seatBlock);
		
		List<Integer> seatNumber = reserveService.getSeatNumber();
		request.setAttribute("seatNumber", seatNumber);
		
		request.getRequestDispatcher("/WEB-INF/views/reserve/selectseat.jsp").forward(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}
}