package service.face;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

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

	public List blackgetList(Paging paging);

	
	

}
