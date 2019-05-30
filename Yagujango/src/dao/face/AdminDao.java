package dao.face;

import java.util.List;

import dto.Mem_blacklist;
import util.Paging;

public interface AdminDao {
	
	//관리자 - 회원전체조회
	public List selectAll(Paging paging);

	//관리자 -회원 테이블 전체 count조회
	public int selectCntAll(String keyword);
	
	//1:1질문목록 조회
	public List bselectAll(Paging paging);

	public List blackselectAll(Paging paging);

}
