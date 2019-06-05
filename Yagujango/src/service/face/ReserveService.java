package service.face;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import dto.Match;
import dto.Member;
import dto.Reserve;
import dto.Seat;
import dto.Stadium;
import dto.Ticket;

public interface ReserveService {

	/**
	 * 구단 이름 가져오기
	 *   헤더-상단 메뉴바에 마우스 오버시 구장 이름 목록 뜨게 함
	 * 
	 * @return
	 */
	public List<Stadium> getList();
	
	/**
	 * 요청파라미터에서 stadium_code 파싱
	 * 
	 * @param request - 요청 파라미터
	 * @return Stadium - 구장코드가 담긴 객체
	 */
	public Stadium getStadiumcode(HttpServletRequest request);
	
	
	/**
	 * 해당 구장의 경기 일정 가져오기 
	 * 		
	 * 
	 * @param stadium - hoemteam_code 가 담겨 있음
	 * @return Match - 해당 팀의 경기 일정 리스트
	 */
	public List<Match> getMatchList(Stadium stadium);

	/**
	 * 요청파라미터에서 match_code 파싱
	 * 		예매 목록에서 '예매하기' 버튼 클릭시 넘겨줌
	 * 
	 * @param request - 요청 파라미터
	 * @return Match - match_code
	 */
	public Match getMatchCode(HttpServletRequest request);

	/**
	 * match_code에 해당하는 경기 정보 가져오기
	 * 
	 * @param match - 알아오려는 경기의 match_code
	 * @return Match - 모든 경기 정보
	 */
	public Match getMatchInfo(Match match);

	/**
	 * 해당 경기의 구장 정보 얻어오기
	 * 		예매- 좌석선택페이지에서 보여줘야함
	 * 
	 * @param match
	 * @return
	 */
	public Stadium getStadiumInfo(Match match);

	/**
	 * 해당 경기의 잔여좌석 리스트 얻어오기
	 * 
	 * @param match - match_code
	 * @return Seat - 해당 경기의 잔여좌석
	 */
	public List<Seat> getSeatInfo(Match match);

	/**
	 * 해당 경기의 예매 현황 리스트
	 * 
	 * @param match
	 * @return Tiket - 해당 경기의 티켓 리스트
	 */
	public List<Ticket> getReserveStatus(Match match);

	public List<String> getSeatBlock();

	public List<Integer> getSeatNumber();

	public List<Ticket> getSeatInfoByTicket(Match match);


	/**
	 * 예매 가능한 좌석을 블럭별로 카운트
	 * 
	 * @param match
	 * @return
	 */
	public List<Integer> getSeatCount(Match match);



	public void insertReserve(Reserve receive);
	
	public Member getUserNo(String userid);

	public Date StringToDate(String payment_date);

	/**
	 * 선택한 티켓 ticket Table에 insert
	 * 
	 * @param match - 해당 경기의 match_code
	 * @param selectseat - 선택한 좌석들(문자열)
	 * @return Integer - 예매 완료한 티켓들의 리스트
	 */
	public List<Integer>  addTicket(Match match, String selectseat);

	public List<Seat> getResevedSeatList(Match match);

}