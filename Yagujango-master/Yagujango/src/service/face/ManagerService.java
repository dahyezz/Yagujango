package service.face;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import util.Paging;

public interface ManagerService {
	
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
	
	
	
//	/**
//	 * 회원 패널티
//	 * 
//	 * @param names - 추가할 userno를 문자열로 합친 것
//	 */
//	public void penaltyUpdate(String names);
//	

}
