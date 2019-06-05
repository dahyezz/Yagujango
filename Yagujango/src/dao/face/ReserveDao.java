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


	List<String> selectSeatBlock();

	List<Integer> selectSeatNumber();

	List<Ticket> selectSeatInfo(Match match);


	void insertReserve(Reserve receive);

	Member getUserNo(String userid);

	int selectSeatcodeBySeatInfo(String seat_block, int seat_number);

	void insertTicket(Match match, int seat_code);

	int selectNewTicketCode(Match match, int seat_code);


	void deletetSeatInfoByTicket(int ticketcode);

	List<Seat> getReservedSeatListByMatchCode(Match match);



}
