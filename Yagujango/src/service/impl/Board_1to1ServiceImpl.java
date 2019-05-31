package service.impl;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import dao.face.Board_1to1Dao;
import dao.impl.Board_1to1DaoImpl;
import dto.Board_1to1;
import dto.Board_faq;
import service.face.Board_1to1Service;
import util.Paging;

public class Board_1to1ServiceImpl implements Board_1to1Service {
	
	private Board_1to1Dao board_1to1Dao = new Board_1to1DaoImpl();

	@Override
	public Paging getCurPage(HttpServletRequest req) {
		
		String param = req.getParameter("cutPage");
		
		int curPage = 0;
		if( param!=null && !"".equals(param) ) {
			curPage = Integer.parseInt(param);
		}

		int totalCount = board_1to1Dao.selectCntAll();

		Paging paging = new Paging(curPage);
		
		return paging;
	}

	@Override
	public List<Board_faq> getFaqList(Paging paging) {
		return board_1to1Dao.faqSelectAll(paging);
	}

	@Override
	public void write(HttpServletRequest req) {

		Board_1to1 board_1to1 = new Board_1to1();
		int boardno = board_1to1Dao.selectBoardno();
		
		if(board_1to1 != null) {
			board_1to1.setBoardno(boardno);
			
			if(board_1to1.getTitle()!=null || "".equals(board_1to1.getTitle())) {
				board_1to1.setTitle("(제목없음)");

				//작성자id 처리
				board_1to1.setWriter_userid((String) req.getSession().getAttribute("writer_userid"));
			}

			board_1to1Dao.insert(board_1to1);
		
		}	
	}
}

