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
		//�����Ķ���� curPage �Ľ�
		String param = req.getParameter("curPage");
		int curPage = 0;
		if(param!=null && !"".equals(param)) {
			curPage = Integer.parseInt(param);
		}
		
		//��ü �Խñ� ��
		int totalCount = adminDao.selectCntAll();
		
		//����¡ ��ü ����
		Paging paging = new Paging(totalCount, curPage);
		
		return paging;	
	}

	//1:1������ϸ���Ʈ
	@Override
	public List bgetList(Paging paging) {
			
		return adminDao.bselectAll(paging);

	}

}
