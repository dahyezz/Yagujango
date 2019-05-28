package service.impl;

import javax.servlet.http.HttpServletRequest;

import dao.face.MemberDao;
import dao.impl.MemberDaoImpl;
import dto.Member;
import service.face.MemberService;

public class MemberServiceImpl implements MemberService{

	private MemberDao memberDao = new MemberDaoImpl();
	
	@Override
	public Member getLoginMember(HttpServletRequest req) {
		
		Member member = new Member();
		
		member.setUserid(req.getParameter("userid"));
		member.setUserpw(req.getParameter("userpw"));
		
		return member;
	}

	@Override
	public boolean login(Member member) {
		
		if(memberDao.selectCntMemberByUserid(member) >= 1)
			return true;
		else
			return false;
	}

	@Override
	public Member getMemberByUserid(Member member) {
	
		return memberDao.selectMemberByUserid(member);
	}

}
