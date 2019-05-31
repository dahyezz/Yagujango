package dao.face;

import java.util.List;

import dto.Board_1to1;
import dto.Mem_blacklist;
import util.Paging;

public interface AdminDao {
	
	//������ - ȸ����ü��ȸ
	public List selectAll(Paging paging);

	//������ -ȸ�� ���̺� ��ü count��ȸ
	public int selectCntAll(String keyword);
	
	//1:1������� ��ȸ
	public List bselectAll(Paging paging);

	public List blackselectAll(Paging paging);
	
	/**
	 * 1:1���� �󼼺���
	 * @param viewBoard - ��ȸ ���
	 * @return Board_1to1 - �󼼺����� �Խñ� ��ȸ ���
	 */
	public Board_1to1 selectBoard_1to1ByBoardno(Board_1to1 viewBoard);

}
