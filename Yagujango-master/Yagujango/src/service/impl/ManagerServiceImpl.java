package service.impl;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import dao.face.MemberDao;
import dao.impl.MemberDaoImpl;
import service.face.ManagerService;
import util.Paging;

public class ManagerServiceImpl implements ManagerService{
	
	private MemberDao memberDao = new MemberDaoImpl();

	@Override
	public List getList(Paging paging) {
		
		return memberDao.selectAll(paging);
		
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
		int totalCount = memberDao.selectCntAll();
		
		//����¡ ��ü ����
		Paging paging = new Paging(totalCount, curPage);
		
		return paging;	
	}

}
