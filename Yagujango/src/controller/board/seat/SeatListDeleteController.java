package controller.board.seat;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.Board_Seat;
import service.face.Board_SeatService;
import service.impl.Board_SeatServiceImpl;

/**
 * Servlet implementation class SeatListDeleteController
 */
@WebServlet("/board/seat/listdelete")
public class SeatListDeleteController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Board_SeatService board_SeatService = new Board_SeatServiceImpl();
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		Board_Seat board = new Board_Seat();
		
		String boardnolist = req.getParameter("boardnolist");
		String[]param = boardnolist.split(",");
		List<Integer> list = new ArrayList<Integer>();
		
		for(int i=0; i<param.length; i++) {
			int boardno = Integer.parseInt(param[i]);
			list.add(boardno);
		}
		for(int boardno : list) {
			board.setBoardno(boardno);
			board_SeatService.delete(board);
		}
		
		resp.sendRedirect("/board/seat/list");
	}
}
