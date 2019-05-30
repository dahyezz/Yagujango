package service.face;

import javax.servlet.http.HttpServletRequest;

import dto.Member;

public interface MemberService {

	/**
	 * 요청 파라미터에서 id, pw 파싱
	 * 
	 * @param req - 요청 파라미터
	 * @return Member - 로그인 요청한 아이디와 비밀번호
	 */
	public Member getLoginMember(HttpServletRequest req);

	/**
	 * 로그인 체크
	 * 
	 * @param member - 로그인 하려는 아이디, 비밀번호가 담긴 객체
	 * @return 로그인 성공 시 true
	 */
	public boolean login(Member member);

	/**
	 * 로그인 성공한 회원의 정보를 가져옴
	 * 
	 * @param member - 로그인 성공한 회원의 아이디, 비밀번호 정보만 담겨있음
	 * @return Member - 로그인 성공한 회원의 모든 정보
	 */
	public Member getMemberByUserid(Member member);
	
	/**
	 * 	아이디와 이메일이 일치하는 아이디 가져옴
	 * @param member
	 * @return 조회한 아이디와 이메일이 일치하는 아이디가 있을 때 true
	 */
	public boolean idFind(Member member);
	
	/**
	 * 	찾은 아이디 조회
	 * @param member
	 * @return 찾은 아이디 조회
	 */
	public Member getIdfind(Member member);

}
