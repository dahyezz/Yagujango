package service.impl;

import java.io.UnsupportedEncodingException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

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
		String name = req.getParameter("name");
		String keyword = req.getParameter("keyword");
		String param = req.getParameter("cutPage");
		
		int curPage = 0;
		if( param!=null && !"".equals(param) ) {
			curPage = Integer.parseInt(param);
		}

		int totalCount = board_1to1Dao.selectCntAll();

		Paging paging = new Paging(totalCount, curPage);
		paging.setName(name);
		paging.setKeyword(keyword);
		
		return paging;
	}

	@Override
	public List<Board_faq> getFaqList(Paging paging) {
		return board_1to1Dao.faqSelectAll(paging);
	}

	@Override
	public void write(HttpServletRequest req) {
		try {
			req.setCharacterEncoding("utf-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		Board_1to1 board_1to1 = new Board_1to1();
		HttpSession session = req.getSession();
		
		board_1to1.setWriter_email(req.getParameter("writer_email"));
		board_1to1.setTitle(req.getParameter("title"));
		board_1to1.setContent(req.getParameter("content"));
		board_1to1.setWriter_comment(req.getParameter("writer_comment"));
		board_1to1.setWriter_userid((String)session.getAttribute("writer_userid"));
		
		board_1to1Dao.insert(board_1to1);
		
			
	}
}

