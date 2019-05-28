package service.impl;

import java.util.List;
 
import javax.servlet.http.HttpServletRequest;

import dao.face.Board_1to1Dao;
import dao.impl.Board_1to1DaoImpl;
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
		
		Paging paging = new Paging(curPage);
		
		return paging;
	}

	@Override
	public List getFaqList(Paging paging) {
		return board_1to1Dao.faqSelectAll(paging);
	}

}