package service.face;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import dto.Board_1to1;
import dto.Match;
import dto.Member;
import dto.Reserve;
import dto.Seat;
import dto.Stadium;
import dto.Ticket;
import util.Paging;

public interface MemberService {

	/**
	 * 요청 파라미터에서 id, pw 파싱
	 * 
	 * @param req - 요청 파라미터
	 * @return Member - 로그인 요청한 아이디와 비밀번호
	 */
	public Member getLoginMember(HttpServletRequest req);

	/**
	 * 로그인 체크
	 * 
	 * @param member - 로그인 하려는 아이디, 비밀번호가 담긴 객체
	 * @return 로그인 성공 시 true
	 */
	public boolean login(Member member);

	/**
	 * 로그인 성공한 회원의 정보를 가져옴
	 * 
	 * @param member - 로그인 성공한 회원의 아이디, 비밀번호 정보만 담겨있음
	 * @return Member - 로그인 성공한 회원의 모든 정보
	 */
	public Member getMemberByUserid(Member member);
	
	/**
	 * 	이름과 이메일이 일치하는 아이디 가져옴
	 * @param member
	 * @return 조회한 이름과 이메일이 일치하는 아이디가 있을 때 true
	 */
	public boolean idFind(Member member);
	 
	/**
	 * 	찾은 아이디 조회
	 * @param member
	 * @return 찾은 아이디 조회
	 */
	public Member getIdfind(Member member);
	
	/**
	 * 	이름과 이메일과 아이디가 일치하는 비밀번호 가져옴
	 * @param member
	 * @return 조회한 이름과 이메일과 아이디가 일치하는 비밀번호가 있을 때 true
	 */
	public boolean pwFind(Member member);
	 
	/**
	 * 	찾은 비밀번호 조회
	 * @param member
	 * @return 찾은 비밀번호 조회
	 */
	public Member getPwfind(Member member);

	/**
	 * 	회원가입
	 * @param member
	 * @return true/false
	 */
	public boolean join(Member member);
	
	public Date StringToDate(String payment_date);
	
	/**
	 * 	아이디 중복 체크
	 * @param member
	 * @return 아이디 중복 시 true
	 */
	public boolean idOverlap(Member member);
	
	/**
	 * 	회원가입 시 블랙리스트였는지 체크
	 * @param mem_blacklist
	 * @return 블랙리스트 DB에 있을 시 true
	 */
	public boolean blacklistCheck(Member member);
	
	List<Board_1to1> getOneToOneList(String userid);
	
	/**
	 * 	reservo_code를 리스트에 삽입
	 * @param mypagepaging
	 * @return 조회 결과
	 */
	public List<Reserve> getReservecodeList(Paging mypagepaging,Reserve reserve);
	
	/**
	 * 	curPage 파싱
	 * @param req
	 * @return paging
	 */

	public Paging getCurPage(HttpServletRequest req,Reserve reserve);
	
	/**
	 * 	reserve 조회
	 * @param reserve
	 * @return reserve list
	 */
	public List<Reserve> getReserveList(Reserve reserve);
	
	/**
	 * 	ticket 조회
	 * @param reserveList
	 * @return ticket list
	 */
	public List<Ticket> getTicketList(List<Reserve> reserveList);
	
	/**
	 * 	match 조회
	 * @param ticketList
	 * @return match list
	 */
	public List<Match> getMatchList(List<Ticket> ticketList);
	
	/**
	 * 	seat 리스트 조회
	 * @param ticketList
	 * @return seat list
	 */
	public List<Seat> getSeatList(List<Ticket> ticketList);
	
	/**
	 * 	reserve_code별 매수 count 리스트
	 * @param reserve
	 * @return 매수 리스트
	 */
	public List<Integer> getCntSeatList(List<Reserve> reserveList);
	
	/**
	 * 	stadium 조회
	 * @param matchList
	 * @return stadium list
	 */
	public List<Stadium> getStadiumList(List<Match> matchList);
	
	/**
	 * 회원 정보 수정
	 * @param member - 바뀐 정보
	 */
	public void modifyMemberInfo(Member member);

	/**
	 * 회원 탈퇴 
	 * @param member
	 */
	public void leaveMember(Member member);

	
	
	public Board_1to1 getBoardno(HttpServletRequest req);

	
	// 요청파라미터에서 boardno를 파싱
	public Board_1to1 view(Board_1to1 viewBoard);

	/**
	 * 예매한 티켓 취소처리
	 * 
	 * @param reserve_code - 취소하려는 예매의 예매코드
	 */
	public void cancleMyTicket(String reserve_code);

	public List<Reserve> getReservecodeListnotpaging(Reserve reserve);


}
