																																																	package controller.board.free;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.Board_Free;
import service.face.Board_FreeService;
import service.impl.Board_FreeServiceImpl;

/**
 * Servlet implementation class FreeUpdateController
 */
@WebServlet("/board/free/update")
public class FreeUpdateController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Board_FreeService board_FreeService = new Board_FreeServiceImpl();
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String tag = req.getParameter("tag");
		Board_Free viewboard = board_FreeService.getBoardno(req);
		if("공지".equals(tag)) {
			viewboard = board_FreeService.noticeview(viewboard);
		}else {
			viewboard = board_FreeService.view(viewboard);
		}
		

		System.out.println(viewboard);
		req.setAttribute("board", viewboard);
		req.getRequestDispatcher("/WEB-INF/views/board/free/update.jsp").forward(req, resp);
	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	
		req.setCharacterEncoding("UTF-8");
		board_FreeService.update(req);
		//목록으로 리다이렉트
		resp.sendRedirect("/board/free/list");
	}
	
}
