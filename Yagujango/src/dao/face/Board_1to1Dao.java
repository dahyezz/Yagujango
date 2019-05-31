package dao.face;

import java.util.List;

import dto.Board_1to1;
import dto.Board_faq;
import util.Paging;

public interface Board_1to1Dao {

	public List<Board_faq> faqSelectAll(Paging paging);

	public int selectCntAll();


	public int selectBoardno();

	public void insert(Board_1to1 board_1to1);

}

