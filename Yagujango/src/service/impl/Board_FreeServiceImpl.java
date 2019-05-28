package service.impl;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import dao.face.Board_FreeDao;
import dao.impl.Board_FreeDaoImpl;
import dto.Board_Free;
import service.face.Board_FreeService;
import util.Paging;

public class Board_FreeServiceImpl implements Board_FreeService{
	Board_FreeDao board_FreeDao = new Board_FreeDaoImpl();
	@Override
	public Paging getCurPage(HttpServletRequest req) {
		//검색어 기능
		String name = req.getParameter("name");
		String keyword = req.getParameter("keyword");
		String param = req.getParameter("curPage");
		
		int curPage = 0;
		if (param != null && !"".equals(param)) {
			curPage = Integer.parseInt(param);
		}
		Paging paging = new Paging();
		paging.setName(name);
		paging.setKeyword(keyword);
		int totalCount = board_FreeDao.selectCntAll(paging);
		
		paging = new Paging(totalCount, curPage);
		
		paging.setName(name);
		paging.setKeyword(keyword);
		//		System.out.println(paging);
		
		return paging;
		
	}
	@Override
	public List<Board_Free> getList(Paging paging) {
		return board_FreeDao.selectAll(paging);
	}
	@Override
	public List<Board_Free> getListwithNotice(Paging paging) {
		return board_FreeDao.selectAllwithNotice(paging);
	}
	@Override
	public Board_Free getBoardno(HttpServletRequest req) {
		String param = req.getParameter("boardno");
		int boardno = Integer.parseInt(param);
		Board_Free board = new Board_Free();
		board.setBoardno(boardno);
		return board;
	}
	@Override
	public Board_Free view(Board_Free viewboard) {
		
		return board_FreeDao.selectBoardByBoardno(viewboard);
	}
	@Override
	public void addHit(Board_Free viewboard) {
		board_FreeDao.upHit(viewboard);
		
	}

}
