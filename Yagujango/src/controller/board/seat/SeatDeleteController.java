package controller.board.seat;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;

import service.face.Board_SeatService;
import service.impl.Board_SeatServiceImpl;

/**
 * Servlet implementation class SeatDeleteController
 */
@WebServlet("/board/seat/delete")
public class SeatDeleteController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Board_SeatService board_SeatService = new Board_SeatServiceImpl();

}
