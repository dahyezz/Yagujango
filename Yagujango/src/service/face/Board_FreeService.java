package service.face;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import dto.Board_Free;
import util.Paging;

public interface Board_FreeService {

	Paging getCurPage(HttpServletRequest req);

	List<Board_Free> getList(Paging paging);

	List<Board_Free> getListwithNotice(Paging paging);

	Board_Free getBoardno(HttpServletRequest req);

	Board_Free view(Board_Free viewboard);

	void addHit(Board_Free viewboard);

}
