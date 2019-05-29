package dao.face;

import java.util.List;

import dto.Match;
import dto.Stadium;

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

}
