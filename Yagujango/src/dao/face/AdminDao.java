package dao.face;

import java.util.List;

import util.Paging;

public interface AdminDao {
	
	//������ - ȸ����ü��ȸ
	public List selectAll(Paging paging);

	//������ -ȸ�� ���̺� ��ü count��ȸ
	public int selectCntAll();
	
	//1:1������� ��ȸ
	public List bselectAll(Paging paging);

}
