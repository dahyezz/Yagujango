package dao.face;

import java.util.List;

import dto.Match;
import dto.Stadium;

public interface ReserveDao {

	List<Stadium> selectName();
	
	List<Match> selectAllByStadiumcode();

}
