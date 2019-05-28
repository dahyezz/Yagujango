package controller.board.faq;

import java.io.IOException;
import java.util.List;
 
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.face.Board_1to1Service;
import service.impl.Board_1to1ServiceImpl;
import util.Paging;


@WebServlet("/board/faq/faqlist")
public class FaqListController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private Board_1to1Service board_1to1Service = new Board_1to1ServiceImpl();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	
		Paging paging = board_1to1Service.getCurPage(req);
		
		req.setAttribute("paging", paging);
		
		
		List faqList = board_1to1Service.getFaqList(paging);
		
		req.setAttribute("list", faqList);
		
		req.getRequestDispatcher("/WEB-INF/views/board_faq/faq.jsp").forward(req, resp);
	
	}
	
	
}