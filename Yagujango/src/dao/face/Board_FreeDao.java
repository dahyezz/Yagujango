package dao.face;

import java.util.List;

import dto.Board_Free;
import util.Paging;



public interface Board_FreeDao {

	public int selectCntAll(Paging paging);
	
	public List<Board_Free> selectAll(Paging paging);
	
	public List<Board_Free> selectAllwithNotice(Paging paging);

	public Board_Free selectBoardByBoardno(Board_Free viewboard);

	public void upHit(Board_Free viewboard);
}
