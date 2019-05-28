package service.face;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import dto.Match;
import dto.Stadium;

public interface ReserveService {
	public List<Stadium> getList();
	
	public List<Match> getMatchList();
	
	public Stadium getStadiumcode(HttpServletRequest request);
}