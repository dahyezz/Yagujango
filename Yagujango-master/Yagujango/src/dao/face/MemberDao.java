package dao.face;

import java.util.List;

import dto.Member;
import util.Paging;

public interface MemberDao {

	public int selectCntMemberByUserid(Member member);

	public Member selectMemberByUserid(Member member);
	
	//전체조회
	public List selectAll(Paging paging);

	//테이블 전체 count조회
	public int selectCntAll();


}
