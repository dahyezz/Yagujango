package controller.board.seat;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.Board_Seat;
import service.face.Board_SeatService;
import service.impl.Board_SeatServiceImpl;

/**
 * Servlet implementation class SeatViewController
 */
@WebServlet("/board/seat/view")
public class SeatViewController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Board_SeatService board_SeatService = new Board_SeatServiceImpl();
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		Board_Seat board_seat = board_SeatService.getBoardno(req);
		
		board_SeatService.addHit(board_seat);
		Board_Seat viewboard = board_SeatService.view(board_seat);
		
		req.setAttribute("board", viewboard);
		
		req.getRequestDispatcher("/WEB-INF/views/board/seat/view.jsp").forward(req, resp);
		
	}
}
