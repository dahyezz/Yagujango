package service.face;

import java.util.List;
import javax.servlet.http.HttpServletRequest;

import dto.Board_faq;
import dto.Member;
import util.Paging;

public interface Board_1to1Service {

	Paging getCurPage(HttpServletRequest req);

	List<Board_faq> getFaqList(Paging paging);

	void write(HttpServletRequest req);



}

