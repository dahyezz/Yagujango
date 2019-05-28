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
	public List<Stadium> getList() {
		return reserveDao.selectName();
	}
	
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
	public List<Match> getMatchList() {
		return reserveDao.selectAllByStadiumcode();
	}
}
