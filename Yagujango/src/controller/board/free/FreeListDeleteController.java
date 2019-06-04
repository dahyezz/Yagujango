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
import service.face.Board_FreeService;
import service.impl.Board_FreeServiceImpl;

/**
 * Servlet implementation class FreeListDeleteController
 */
@WebServlet("/board/free/listdelete")
public class FreeListDeleteController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Board_FreeService board_FreeService = new Board_FreeServiceImpl();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		Board_Free board = new Board_Free();
		String boardnolist = req.getParameter("boardnolist");
		String[]param = boardnolist.split(",");
		List<Integer> list = new ArrayList<Integer>();
		
		for(int i=0; i<param.length; i++) {
			int boardno = Integer.parseInt(param[i]);
			list.add(boardno);
		}
		for(int boardno : list) {
			board.setBoardno(boardno);
			board_FreeService.deleteboard_free(board);
		}
		
		resp.sendRedirect("/board/free/list");
		
	}
}
