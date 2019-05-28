package service.face;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import util.Paging;

public interface ManagerService {
	
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
	
	
	
//	/**
//	 * ȸ�� �г�Ƽ
//	 * 
//	 * @param names - �߰��� userno�� ���ڿ��� ��ģ ��
//	 */
//	public void penaltyUpdate(String names);
//	

}
