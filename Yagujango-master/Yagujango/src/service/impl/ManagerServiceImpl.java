package service.impl;

import java.util.List;

import dao.face.MemberDao;
import dao.impl.MemberDaoImpl;
import dto.Member;
import service.face.ManagerService;

public class ManagerServiceImpl implements ManagerService {
	
	private MemberDao memberDao = new MemberDaoImpl();
	
	@Override
	public List getList() {

		return memberDao.selectAll();
	}

}
