package service.face;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import dto.Board_Free;
import util.Paging;

public interface Board_FreeService {

	public Paging getCurPage(HttpServletRequest req);

	public List<Board_Free> getList(Paging paging);

	public List<Board_Free> getListwithNotice(Paging paging);

	public Board_Free getBoardno(HttpServletRequest req);

	public Board_Free view(Board_Free viewboard);

	public void addHit(Board_Free viewboard);

	public void noticeaddhit(Board_Free viewboard);

	public Board_Free noticeview(Board_Free viewboard);
	
	public String uploadfile(HttpServletRequest req);

}
