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
	 * ��û�Ķ���Ϳ��� boardno�� �Ľ��Ѵ�.
	 * @param req - ��û������ü
	 * @return Board_1to1 - boardno�� �Է��� ��ü
	 */
	public Board_1to1 getBoardno(HttpServletRequest req);
	/**
	 * 1:1���� �󼼺���
	 * @param viewBoard - �󼼺����� boardno�� ���� ��ü
	 * @return Board_1to1 - �󼼺����� �Խñ� ��ȸ ���
	 */
	public Board_1to1 view(Board_1to1 viewBoard);
	

	
	

}
