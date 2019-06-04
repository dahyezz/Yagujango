package service.face;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import dto.Board_1to1;
import dto.Mem_blacklist;
import util.Paging;

public interface AdminService {
	
	/**
	 * @param
	 * @return ȸ�������ȸ
	 */
	public List getList(Paging paging);
	
	/**
	 * ��û�Ķ���Ϳ��� curPage�� �Ľ��Ѵ�.
	 * 
	 * @param req - ��û������ü
	 * @return Paging - ����¡ ����� �Ϸ�� ��ü
	 */
	public Paging getCurPage(HttpServletRequest req);
	
	/**
	 * @param
	 * @return �Խ��Ǹ���Ʈ��ȸ
	 */

	public List bgetList(Paging paging);
	
	/**
	 * @param
	 * @return ������Ʈ��ȸ
	 */

	public List blackgetList(Paging paging);
	
	/**
	 * 요청파라미터에서 boardno를 파싱한다.
	 * @param req -요청정보객체
	 * @return Board_1to1 - boardno를 입력한 객체
	 */
	public Board_1to1 getBoardno(HttpServletRequest req);
	/**
	 * 1:1게시글 조회
	 * @param viewBoard - �󼼺����� boardno�� ���� ��ü
	 * @return Board_1to1 - �󼼺����� �Խñ� ��ȸ ���
	 */
	public Board_1to1 view(Board_1to1 viewBoard);
	
	/**
	 * 게시글 작성
	 * @param req - 요청 정보 객체
	 */
	public void write(HttpServletRequest req);
	

	
	

}
