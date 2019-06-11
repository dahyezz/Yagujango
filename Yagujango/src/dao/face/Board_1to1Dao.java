package dao.face;

import java.util.List;

import dto.Board_1to1;
import dto.Board_faq;
import dto.Member;
import util.Paging;

public interface Board_1to1Dao {

	public List<Board_faq> faqSelectAll(Paging paging);

	public int selectCntAll(Paging paging);
	
	public void Insert(Board_1to1 board_1to1);



}

