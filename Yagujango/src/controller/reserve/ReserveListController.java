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
import service.face.ReserveService;
import service.impl.ReserveServiceImpl;

@WebServlet("/reserve/list")
public class ReserveListController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ReserveService reserveService = new ReserveServiceImpl();

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<Stadium> list = reserveService.getList();
		
		request.setAttribute("st", list);
		
		request.getRequestDispatcher("/WEB-INF/views/reserve.jsp").forward(request, response);
		//
		
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println(request.getParameter("matchSeq"));
		
		List<Match> matchlist = reserveService.getMatchList();
		
		request.getRequestDispatcher("/WEB-INF/views/matchinfo.jsp").forward(request, response);
	}
}