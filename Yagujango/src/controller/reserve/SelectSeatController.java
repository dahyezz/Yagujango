package controller.reserve;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.Match;
import dto.Stadium;
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
		
		Stadium stadium = reserveService.getStadiumInfo(match);
		request.setAttribute("stadium", stadium);
		
		request.getRequestDispatcher("/WEB-INF/views/reserve/selectseat.jsp").forward(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}
}