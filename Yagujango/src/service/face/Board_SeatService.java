package service.face;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import dto.Board_Seat;
import util.Paging;

public interface Board_SeatService {

	public Paging getCurPage(HttpServletRequest req);

	public List<Board_Seat> getList(Paging paging);

	public void write(HttpServletRequest req);

}
