package dao.face;

import java.util.List;

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

}
