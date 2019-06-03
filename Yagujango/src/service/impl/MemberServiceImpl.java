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

	@Override
	public boolean idFind(Member member) {
		if(memberDao.selectCntMemberIdfind(member) >= 1)
			return true;
		else
			return false;
	}

	@Override
	public Member getIdfind(Member member) {
		
		return memberDao.selectMemberIdfind(member);
	}

	@Override
	public boolean pwFind(Member member) {
		if(memberDao.selectCntMemberPwfind(member) >= 1)
			return true;
		else
			return false;
	}

	@Override
	public Member getPwfind(Member member) {
		
		return memberDao.selectMemberPwfind(member);
	} 
	
	@Override
	public boolean join(Member member) {
		
		//기존에 존재하는 아이디 인지 확인하고 회원가입 처리
		if( memberDao.selectCntMemberByUserid(member) > 0 ) {
			return false; //기존에 존재함, 회원가입 실패
		}
		
		//회원가입(데이터베이스 삽입)
		memberDao.insert(member);
		
		//회원가입 성공 여부 판단
		if( memberDao.selectCntMemberByUserid(member) > 0 ) {
			return true; //회원가입 성공
		} else {
			return false; //회원가입 실패
		}
	}

}
