package dao.face;

import java.util.List;

import dto.Match;
import dto.Member;
import dto.Reserve;
import dto.Seat;
import dto.Stadium;
import dto.Ticket;

public interface ReserveDao {

	/**
	 * 전체 구장의 정보 select
	 * 
	 * @return Stadium - 전체 구장 
	 */
	List<Stadium> selectAllStaidum();
	
	/**
	 * 해당 구장의 코드로 경기 일정 리스트 받아옴 
	 * 
	 * @param stadium
	 * @return
	 */
	List<Match> selectAllByStadiumcode(Stadium stadium);

	Match selectMatchByMatchCode(Match match);

	Stadium selectStadiumByHometeamCode(Match match);

	/**
	 * 해당 경기의 잔여좌석 정보 리턴
	 * 
	 * @param match - 해당 경기의 match_code
	 * @return Seat - 잔여 좌석 정보
	 */
	List<Seat> selectEmptySeatByMatchCode(Match match);

	/**
	 * 해당 경기의 모든 티켓 가져오기
	 * 
	 * @param match
	 * @return
	 */
	List<Ticket> selectAllTicketByMatchCode(Match match);


	Member getUserNo(String userid);

	int selectSeatcodeBySeatInfo(String seat_block, int seat_number);

	void insertTicket(Match match, int seat_code);

	int selectNewTicketCode(Match match, int seat_code);


	void deletetSeatInfoByTicket(int ticketcode);

	List<Seat> getReservedSeatListByMatchCode(Match match);

	void insertReserve(Reserve reserve, String stringdate, String match, int userno);

	List<Seat> selectAllSeat();


	Member getMember(int memno);

	void updateBarcode(Reserve reserve, String barcode);

	List<Match> selectThreeMatchList(int i);

	List<Ticket> selectTicketInfo(Match match, int count);
	Seat selectSeatInfo(int seat_code);

	//reserve테이블에는 없는데 ticket테이블에 있는 좌석 삭제하는 코드 (좌석 최적화)
	// 예매 진행하다가 중단하면 reserve에 insert안되는데 ticket에는 됨
	void optimizeSeat();



}
