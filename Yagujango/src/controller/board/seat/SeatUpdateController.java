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
 * Servlet implementation class SeatUpdateController
 */
@WebServlet("/board/seat/update")
public class SeatUpdateController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Board_SeatService board_SeatService = new Board_SeatServiceImpl();
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		Board_Seat board_seat = board_SeatService.getBoardno(req);
		
		board_seat = board_SeatService.view(board_seat);
		
		req.setAttribute("board", board_seat);
		req.getRequestDispatcher("/WEB-INF/views/board/seat/update.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		
		board_SeatService.update(req);
		
		resp.sendRedirect("/board/seat/view?boardno="+req.getParameter("boardno"));
	}
}
