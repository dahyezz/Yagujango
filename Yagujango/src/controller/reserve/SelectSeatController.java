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
		
		//전체 좌석 List
		List<Seat> allSeatList = reserveService.getAllSeat();
		request.setAttribute("allSeat", allSeatList);
		
		//좌석 disabled 되는지 check
		List<Seat> resvdSeatList = reserveService.getResevedSeatList(match);
		request.setAttribute("resvdSeatList", resvdSeatList);

		List<Integer> seatCount = reserveService.getSeatCount(match); //예매 가능한 좌석 카운트
		request.setAttribute("seatCount", seatCount);
		
		request.getRequestDispatcher("/WEB-INF/views/reserve/selectseat.jsp").forward(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String selectseat = request.getParameter("selectseat");
		List<Integer> newTicketList = reserveService.addTicket(match, selectseat);
		
		response.sendRedirect("/reserve/receive?match_code="+match.getMatch_code()+"&ticket_code="
										+newTicketList.get(0)+"&count="+newTicketList.size());

	}
}