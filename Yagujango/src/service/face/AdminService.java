package service.face;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

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

	public List blackgetList(Paging paging);

	
	

}
