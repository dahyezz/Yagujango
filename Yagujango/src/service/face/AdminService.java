package service.face;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import dto.Board_1to1;
import dto.Mem_blacklist;
import util.Paging;

public interface AdminService {
	
	/**
	 * @param
	 * @return 회원목록조회
	 */
	public List getList(Paging paging);
	
	/**
	 * 요청파라미터에서 curPage를 파싱한다.
	 * 
	 * @param req - 요청정보객체
	 * @return Paging - 페이징 계산이 완료된 객체
	 */
	public Paging getCurPage(HttpServletRequest req);
	
	/**
	 * @param
	 * @return 게시판리스트조회
	 */

	public List bgetList(Paging paging);
	
	/**
	 * @param
	 * @return 블랙리스트조회
	 */

	public List blackgetList(Paging paging);
	
	/**
	 * 요청파라미터에서 boardno를 파싱한다.
	 * @param req - 요청정보객체
	 * @return Board_1to1 - boardno를 입력한 객체
	 */
	public Board_1to1 getBoardno(HttpServletRequest req);
	/**
	 * 1:1문의 상세보기
	 * @param viewBoard - 상세보기할 boardno를 가진 객체
	 * @return Board_1to1 - 상세보기할 게시글 조회 결과
	 */
	public Board_1to1 view(Board_1to1 viewBoard);
	

	
	

}
