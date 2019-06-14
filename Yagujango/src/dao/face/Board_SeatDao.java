package dao.face;

import java.util.List;

import dto.Board_Seat;
import dto.Board_file;
import util.Paging;

public interface Board_SeatDao {

	int selectCntAll(Paging paging);

	List<Board_Seat> selectAll(Paging paging);

	void Insert(Board_Seat board_seat);

	void upHit(Board_Seat board_seat);

	Board_Seat selectbyboardno(Board_Seat board_seat);

	void deletebyboardno(Board_Seat board_seat);

	void update(Board_Seat board_seat);

	int getboardno();

	void insertFile(Board_file board_file);

	void InsertwithFile(Board_Seat board_seat);

}
