package dao.face;

import java.util.List;

import dto.Member;
import util.Paging;

public interface MemberDao {

	public int selectCntMemberByUserid(Member member);

	public Member selectMemberByUserid(Member member);
	
	//��ü��ȸ
	public List selectAll(Paging paging);

	//���̺� ��ü count��ȸ
	public int selectCntAll();


}
