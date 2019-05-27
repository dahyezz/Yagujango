package dao.face;

import java.util.List;

import dto.Member;

public interface MemberDao {

	public int selectCntMemberByUserid(Member member);

	public Member selectMemberByUserid(Member member);
	
	public List selectAll();

}
