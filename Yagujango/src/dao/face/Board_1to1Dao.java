package dao.face;

import java.util.List;
import util.Paging;

public interface Board_1to1Dao {

	public List faqSelectAll(Paging paging);

	public int selectCntAll();

}

