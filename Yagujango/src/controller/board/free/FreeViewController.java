package controller.board.free;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.Board_Free;
import dto.Comment;
import service.face.Board_FreeService;
import service.impl.Board_FreeServiceImpl;

/**
 * Servlet implementation class FreeViewController
 */
@WebServlet("/board/free/view")
public class FreeViewController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Board_FreeService board_FreeService = new Board_FreeServiceImpl();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		Board_Free viewboard = board_FreeService.getBoardno(req);
		viewboard.setTag(req.getParameter("tag"));
		List<Comment> list =  new ArrayList<Comment>();
		
		if("공지".equals(viewboard.getTag())) {
			board_FreeService.noticeaddhit(viewboard);
			viewboard = board_FreeService.noticeview(viewboard);
		}else {
			board_FreeService.addHit(viewboard);
			viewboard = board_FreeService.view(viewboard);
		}
		req.setAttribute("board", viewboard);
		
		list = board_FreeService.commentlist(viewboard);
		
		
		req.setAttribute("comment", list);
		
		req.getRequestDispatcher("/WEB-INF/views/board/free/view.jsp").forward(req, resp);
		
	}
}
