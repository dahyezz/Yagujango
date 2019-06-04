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

@WebServlet("/reserve/receive")
public class SelectReceiveController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private ReserveService reserveService = new ReserveServiceImpl();
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Match match = reserveService.getMatchCode(request);
		match = reserveService.getMatchInfo(match);
		System.out.println(match); //TEST
		
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
	}
}
