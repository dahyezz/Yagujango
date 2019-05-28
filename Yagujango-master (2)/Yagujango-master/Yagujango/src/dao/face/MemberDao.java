package dao.face;

import dto.Member;

public interface MemberDao {
	
	/**
	 * 	로그인한 아이디와 비밀번호 일치하는 회원 count
	 * @param member
	 * @return count
	 */
	public int selectCntMemberByUserid(Member member);
	
	/**
	 * 	사용자의 정보 가져오기
	 * @param member
	 * @return 사용자의 정보 조회
	 */
	public Member selectMemberByUserid(Member member);
}
