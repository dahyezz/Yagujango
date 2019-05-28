package service.face;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import dto.Match;
import dto.Stadium;

public interface ReserveService {
	
	/**
	 * 요청파라미터에서 stadium_code 파싱하기
	 * 이 staidum_code가 홈팀임
	 * 
	 * @param request
	 * @return Stadium - stadium_code정보가 있는 Stadium 객체 
	 */
	public Stadium getStadiumcode(HttpServletRequest request);
	
	public List<Stadium> getList();
	
	/**
	 * 해당팀의 경기 일정 리스트 가져오기
	 * 
	 * 
	 * @param stadium - stadium_code = Match테이블의 hometeam_code
	 * @return Match - 경기일정리스트
	 */
	public List<Match> getMatchList(Stadium stadium);
	
	
}