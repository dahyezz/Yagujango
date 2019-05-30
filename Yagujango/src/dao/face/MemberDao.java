package dao.face;

import dto.Member;

public interface MemberDao {

	public int selectCntMemberByUserid(Member member);

	public Member selectMemberByUserid(Member member);

	public int selectCntMemberIdfind(Member member);
	
	public Member selectMemberIdfind(Member member); 
}
