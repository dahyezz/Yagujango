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
import util.Paging;

/**
 * Servlet implementation class SeatListController
 */
@WebServlet("/board/seat/list")
public class SeatListController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Board_SeatService board_SeatService = new Board_SeatServiceImpl();
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		Paging paging = board_SeatService.getCurPage(req);
		
		List<Board_Seat> list =new ArrayList<Board_Seat>();
		
		list = board_SeatService.getList(paging);
		
		
		
		req.setAttribute("name", paging.getName());
		req.setAttribute("keyword", paging.getKeyword());
		//MODEL로 Paging 객체 넣기
		req.setAttribute("paging", paging);
		//MODEL로 조회 결과 넣기
		req.setAttribute("board_seatlist", list);
		
		
		req.getRequestDispatcher("/WEB-INF/views/board/seat/list.jsp").forward(req, resp);
		
	}
}
