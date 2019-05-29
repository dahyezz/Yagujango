package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.Stadium;
import service.face.ReserveService;
import service.impl.ReserveServiceImpl;

@WebServlet("/main")
public class MainController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private ReserveService reserveService = new ReserveServiceImpl();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		List<Stadium> list = reserveService.getList();
		req.setAttribute("list", list);
		
		req.getRequestDispatcher("/WEB-INF/views/main.jsp").forward(req, resp);
	}
	
}
