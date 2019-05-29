package service.impl;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import dao.face.AdminDao;
import dao.face.MemberDao;
import dao.impl.AdminDaoImpl;
import dao.impl.MemberDaoImpl;
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
		
		//전체 게시글 수
		int totalCount = adminDao.selectCntAll();
		
		//페이징 객체 생성
		Paging paging = new Paging(totalCount, curPage);
		
		return paging;	
	}

	//1:1질문목록리스트
	@Override
	public List bgetList(Paging paging) {
			
		return adminDao.bselectAll(paging);

	}

}
