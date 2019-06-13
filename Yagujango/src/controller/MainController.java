package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.Match;
import service.face.ReserveService;
import service.impl.ReserveServiceImpl;

@WebServlet("/main")
public class MainController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private ReserveService reserveService = new ReserveServiceImpl();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		//match List 불러오기
		List<Match> matchList = reserveService.getThreeDaysMatchList(3);
		req.setAttribute("matchList", matchList);
		
//		for(Match e : matchList) {
//			System.out.println(e);
//		}
		
		req.getRequestDispatcher("/WEB-INF/views/main.jsp").forward(req, resp);
	}
	
}
