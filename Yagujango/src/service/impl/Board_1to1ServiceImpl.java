package service.impl;

import java.io.UnsupportedEncodingException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import dao.face.Board_1to1Dao;
import dao.face.MemberDao;
import dao.impl.Board_1to1DaoImpl;
import dao.impl.MemberDaoImpl;
import dto.Board_1to1;
import dto.Board_faq;
import dto.Member;
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
		
		Paging paging = new Paging();
		int totalCount = board_1to1Dao.selectCntAll(paging);

		paging = new Paging(totalCount, curPage);
		paging.setName(req.getParameter("name"));
		paging.setKeyword(req.getParameter("keyword"));
		
//		System.out.println(paging);
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
		
		String email1 = req.getParameter("email1");
		String email2 = req.getParameter("email2");
		
		Board_1to1 board_1to1 = new Board_1to1();
		HttpSession session = req.getSession();
		board_1to1.setWriter_email(email1+email2);
		board_1to1.setTitle(req.getParameter("title"));
		board_1to1.setContent(req.getParameter("content"));
		board_1to1.setWriter_userid((String)session.getAttribute("userid"));
//		System.out.println(board_1to1);//test
		board_1to1Dao.Insert(board_1to1);
		
			
	}


}

