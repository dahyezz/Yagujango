package service.impl;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import dao.face.Board_SeatDao;
import dao.impl.Board_SeatDaoImpl;
import dto.Board_Seat;
import service.face.Board_SeatService;
import util.Paging;

public class Board_SeatServiceImpl implements Board_SeatService{
	Board_SeatDao board_SeatDao = new Board_SeatDaoImpl();
	@Override
	public Paging getCurPage(HttpServletRequest req) {
		
		
		String param = req.getParameter("curPage");
		int curPage = 0;
		if (param != null && !"".equals(param)) {
			curPage = Integer.parseInt(param);
		} 
		Paging paging = new Paging();
		
		int totalCount = board_SeatDao.selectCntAll(paging);
		
			
		paging = new Paging(totalCount, curPage);
		
		
		//		System.out.println(paging);
		
		return paging;
	}
	@Override
	public List<Board_Seat> getList(Paging paging) {
		return board_SeatDao.selectAll(paging);
	}
	@Override
	public void write(HttpServletRequest req) {
		Board_Seat board_seat = new Board_Seat();
		HttpSession session = req.getSession();
		board_seat.setStadium_name(req.getParameter("stadium_name"));
		board_seat.setSeat_block(req.getParameter("seat_block"));
		String seat_param = req.getParameter("seat_number");
		int seat_number = Integer.parseInt(seat_param);
		board_seat.setSeat_number(seat_number);
		board_seat.setContent(req.getParameter("content"));
		board_seat.setWriter((String)session.getAttribute("usernick"));
		board_seat.setFilename(req.getParameter("filename"));
		board_SeatDao.Insert(board_seat);
		
		
	}

}
