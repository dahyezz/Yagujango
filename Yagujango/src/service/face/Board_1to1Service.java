package service.face;

import java.util.List;
import javax.servlet.http.HttpServletRequest;

import util.Paging;

public interface Board_1to1Service {

	Paging getCurPage(HttpServletRequest req);

	List getFaqList(Paging paging);

	void write(HttpServletRequest req);

}

