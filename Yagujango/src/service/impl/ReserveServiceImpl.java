package service.impl;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import dao.face.ReserveDao;
import dao.impl.ReserveDaoImpl;
import dto.Match;
import dto.Stadium;
import service.face.ReserveService;

public class ReserveServiceImpl implements ReserveService{
	private ReserveDao reserveDao = new ReserveDaoImpl();
	
	@Override
	public Stadium getStadiumcode(HttpServletRequest request) {
		String param = request.getParameter("stadium_code");
		int stadiumcode = 0;
		if( param != null && !"".equals(param)) {
			stadiumcode = Integer.parseInt(param);
		}
		
		Stadium stadium =  new Stadium();
		stadium.setStadium_code(stadiumcode);
		
		return stadium;
	}
	
	@Override
	public List<Stadium> getList() {
		return reserveDao.selectAllStaidum();
	}
	
	@Override
	public List<Match> getMatchList(Stadium stadium) {
		return reserveDao.selectAllByStadiumcode(stadium);
	}

	@Override
	public Match getMatchCode(HttpServletRequest request) {
		String param = request.getParameter("match_code");
		int match_code = 0;
		if( param != null && !"".equals(param)) {
			match_code = Integer.parseInt(param);
		}
		
		Match match = new Match();
		match.setMatch_code(match_code);
		
		return match;
	}

	@Override
	public Match getMatchInfo(Match match) {
		return reserveDao.selectMatchByMatchCode(match);
	}

	@Override
	public Stadium getStadiumInfo(Match match) {
		return reserveDao.selectStadiumByHometeamCode(match);
	}
}
