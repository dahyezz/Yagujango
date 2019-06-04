package controller.board.seat;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;

import service.face.Board_SeatService;
import service.impl.Board_SeatServiceImpl;

/**
 * Servlet implementation class SeatViewController
 */
@WebServlet("/board/seat/view")
public class SeatViewController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Board_SeatService board_SeatService = new Board_SeatServiceImpl();

}
