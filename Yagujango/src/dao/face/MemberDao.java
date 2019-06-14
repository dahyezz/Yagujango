package dao.face;

import java.util.List;

import dto.Board_1to1;
import dto.Match;
import dto.Member;
import dto.Reserve;
import dto.Seat;
import dto.Stadium;
import dto.Ticket;
import util.Paging;

public interface MemberDao {

	//로그인 - 아이디와 비밀번호가 일치하는 유저 count
	public int selectCntMemberByUserid(Member member);

	//로그인 - 아이디가 일치하는 유저의 정보 조회
	public Member selectMemberByUserid(Member member);

	//아이디 찾기 - 이름과 이메일이 일치하는 유저 count
	public int selectCntMemberIdfind(Member member);
	
	//아이디 찾기 - 이름과 이메일이 일치하는 유저 아이디 조회
	public Member selectMemberIdfind(Member member); 
	
	//비밀번호 찾기 - 이름과 이메일과 아이디가 일치하는 유저 count
	public int selectCntMemberPwfind(Member member);
	
	//비밀번호 찾기 - 이름과 이메일과 아이디가 일치하는 유저 비밀번호 조회
	public Member selectMemberPwfind(Member member);
	
	//회원가입 - 유저 정보 삽입
	public void insert(Member member);
	
	//회원가입 - 아이디 중복 확인
	public int selectCntMemberIdOverlap(Member member);
	
	//회원가입 - 회원가입 시 블랙리스트였는지 count
	public int selectCntByBlacklist(Member member);
	
	//나의 1:1 문의 내역 조회 
	public List<Board_1to1> OneToOneSelectAll(String userid);
	
	//userno로 reserve_code를 리스트에 중복없이 저장
	public List selectReservecodeByUserno(Paging mypagepaging,Reserve reserve);
	
	//중복없는 reserve_code의 개수
	public int selectCntReservecode(Reserve reserve);

	//reserve 테이블 조회
	public List<Reserve> selectReserveByUserno(Reserve reserve);
	
	//ticket 테이블 조회
	public List<Ticket> selectTicketByTicketcode(Reserve reserve);
	
	//match 테이블 조회
	public List<Match> selectMatchByMatchcode(Ticket ticket);
	
	//seat 테이블 조회
	public List<Seat> selectSeatBySeatcode(Ticket ticket);
	
	//reserve_code별 매수 count
	public int selectCntSeatByReservecode(Reserve reserve);
		
	//stadium 테이블 조회
	public List<Stadium> selectStadiumByStadiumcode(Match match);

	//회원 정보 업데이트
	public void updateMemberByUserid(Member member);

	//회원 삭제
	public void deleteMemberByUserid(Member member);

	
	public Board_1to1 selectBoardByBoardno(Board_1to1 my1to1view);

	public List<Ticket> selectTicketCodeByReservecode(String reserve_code);

	public void deleteTicket(Ticket e);

	public void deleteReserveByReserveCode(String reserve_code);

}
