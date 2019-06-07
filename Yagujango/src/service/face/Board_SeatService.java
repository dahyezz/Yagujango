package service.face;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import dto.Board_Seat;
import util.Paging;

public interface Board_SeatService {

	public Paging getCurPage(HttpServletRequest req);

	public List<Board_Seat> getList(Paging paging);

	public void write(HttpServletRequest req);

	public String uploadfile(HttpServletRequest req);

	public Board_Seat getBoardno(HttpServletRequest req);

	public void addHit(Board_Seat board_seat);

	public Board_Seat view(Board_Seat board_seat);

}
