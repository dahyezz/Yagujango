package service.face;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import dto.Match;
import dto.Stadium;

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
	
}