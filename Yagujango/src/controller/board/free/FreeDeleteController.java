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
 * Servlet implementation class FreeDeleteController
 */
@WebServlet("/board/free/delete")
public class FreeDeleteController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Board_FreeService board_FreeService = new Board_FreeServiceImpl();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		Board_Free board = board_FreeService.getBoardno(req);

		board_FreeService.deleteboard_free(board);

		resp.sendRedirect("/board/free/list");

	}
}
