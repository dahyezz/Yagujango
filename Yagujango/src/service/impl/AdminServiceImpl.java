package service.impl;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import dao.face.AdminDao;
import dao.face.MemberDao;
import dao.impl.AdminDaoImpl;
import dao.impl.MemberDaoImpl;
import dto.Board_1to1;
import dto.Mem_blacklist;
import service.face.AdminService;
import util.Paging;

public class AdminServiceImpl implements AdminService{
	
	private AdminDao adminDao = new AdminDaoImpl();

	@Override
	public List getList(Paging paging) {
		
		return adminDao.selectAll(paging);
		
	}

	@Override
	public Paging getCurPage(HttpServletRequest req) {
		//전달파라미터 curPage 파싱
		String param = req.getParameter("curPage");
		int curPage = 0;
		if(param!=null && !"".equals(param)) {
			curPage = Integer.parseInt(param);
		}
		
		//검색어
		String keyword = (String)req.getParameter("keyword");
		
		//전체 게시글 수
		int totalCount = adminDao.selectCntAll(keyword);
		
		//페이징 객체 생성
		Paging paging = new Paging(totalCount, curPage);
		paging.setKeyword(keyword);
		System.out.println(paging);
		
		return paging;	
	}

	//1:1질문목록리스트
	@Override
	public List bgetList(Paging paging) {
			
		return adminDao.bselectAll(paging);

	}

	@Override
	public List blackgetList(Paging paging) {

		return adminDao.blackselectAll(paging);
	}

	@Override
	public Board_1to1 getBoardno(HttpServletRequest req) {

		//전달파라미터 boardno 파싱
		String param = req.getParameter("boardno");
		int boardno = 0;
		if(param!=null && !"".equals(param)) {
			boardno = Integer.parseInt(param);
		}
		
		//Board_1to1 객체 생성
		Board_1to1 board_1to1 = new Board_1to1();
		board_1to1.setBoardno(boardno);
		
		return board_1to1;
	}

	@Override
	public Board_1to1 view(Board_1to1 viewBoard) {

		//게시글 조회 반환
		return adminDao.selectBoard_1to1ByBoardno(viewBoard);
	}

}
