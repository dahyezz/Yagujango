package dao.face;

import java.util.List;

import dto.Board_1to1;
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
	
	/**
	 * 1:1문의 상세보기
	 * @param viewBoard - 조회 대상
	 * @return Board_1to1 - 상세보기할 게시글 조회 결과
	 */
	public Board_1to1 selectBoard_1to1ByBoardno(Board_1to1 viewBoard);

}
