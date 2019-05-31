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
		//�����Ķ���� curPage �Ľ�
		String param = req.getParameter("curPage");
		int curPage = 0;
		if(param!=null && !"".equals(param)) {
			curPage = Integer.parseInt(param);
		}
		
		//�˻���
		String keyword = (String)req.getParameter("keyword");
		
		//��ü �Խñ� ��
		int totalCount = adminDao.selectCntAll(keyword);
		
		//����¡ ��ü ����
		Paging paging = new Paging(totalCount, curPage);
		paging.setKeyword(keyword);
		System.out.println(paging);
		
		return paging;	
	}

	//1:1������ϸ���Ʈ
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

		//�����Ķ���� boardno �Ľ�
		String param = req.getParameter("boardno");
		int boardno = 0;
		if(param!=null && !"".equals(param)) {
			boardno = Integer.parseInt(param);
		}
		
		//Board_1to1 ��ü ����
		Board_1to1 board_1to1 = new Board_1to1();
		board_1to1.setBoardno(boardno);
		
		return board_1to1;
	}

	@Override
	public Board_1to1 view(Board_1to1 viewBoard) {

		//�Խñ� ��ȸ ��ȯ
		return adminDao.selectBoard_1to1ByBoardno(viewBoard);
	}

}
