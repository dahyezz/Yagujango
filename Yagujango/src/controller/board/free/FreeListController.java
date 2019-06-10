package controller.board.free;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.Board_Free;
import service.face.Board_FreeService;
import service.impl.Board_FreeServiceImpl;
import util.Paging;

/**
 * Servlet implementation class FreeListController
 */
@WebServlet("/board/free/list")
public class FreeListController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Board_FreeService board_FreeService = new Board_FreeServiceImpl();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//요청파라미터에서 현재페이지 얻어오기
		Paging paging = board_FreeService.getCurPage(req);
	
		List<Board_Free> list = new ArrayList<Board_Free>();
		
		
		if(paging.getKeyword() == null && paging.getName() == null ) {
			list = board_FreeService.getListwithNotice(paging);
		}else if("공지".equals(paging.getKeyword()) && "tag".equals(paging.getName())) {
			list = board_FreeService.getNoticeList(paging);
		}else{
			list = board_FreeService.getList(paging);
		}
		

		req.setAttribute("name", paging.getName());
		req.setAttribute("keyword", paging.getKeyword());
		//MODEL로 Paging 객체 넣기
		req.setAttribute("paging", paging);
		//MODEL로 조회 결과 넣기
		req.setAttribute("board_freelist", list);
		
		//VIEW지정
		req.getRequestDispatcher("/WEB-INF/views/board/free/list.jsp").forward(req, resp);
				
		
	}
}
