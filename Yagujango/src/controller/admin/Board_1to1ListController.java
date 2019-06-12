package controller.admin;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.Board_1to1;
import service.face.AdminService;
import service.impl.AdminServiceImpl;
import util.Paging;

//1:1 질문목록보기

@WebServlet("/admin/board_1to1")
public class Board_1to1ListController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	private AdminService adminService = new AdminServiceImpl();
	
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");

		//요청파라미터에서 curPage 얻어오기
		Paging paging = adminService.getCurPage(req);
		
		//Model로 Paging 객체 넣기
		req.setAttribute("paging", paging);
		
		//1:1 답변목록조회
		List<Board_1to1> blist = adminService.bgetList(paging);
		
		//model로 결과 넣기
		req.setAttribute("blist", blist);
		
//		//게시글 번호 파싱
//		Board_1to1_answer answerBoard = adminService.AgetBoardno(req);
//		
//		//게시글 조회
//		answerBoard = adminService.Aview(answerBoard);
//		
//		//model로 게시글 전달
//		req.setAttribute("answerBoard", answerBoard);
		
		//1:1문의 미처리된 게시글리스트
		List<Board_1to1> untreatedList = adminService.getUntreatedList();
		req.setAttribute("untreatedList", untreatedList);

		
		//view지정
		req.getRequestDispatcher("/WEB-INF/views/admin/board_1to1_list.jsp").forward(req, resp);
		
	}
	
}
//	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//		
//		req.setCharacterEncoding("utf-8");
//		resp.setCharacterEncoding("UTF-8");
//
//		//게시글 번호 파싱
//		Board_1to1 viewBoard = adminService.getBoardno(req);
//		
//		//게시글 조회
//		viewBoard = adminService.view(viewBoard);
//		
//		//model로 게시글 전달
//		req.setAttribute("viewBoard", viewBoard);
//		
//		
//		//목록으로 리다이렉션
//		resp.sendRedirect("/admin/board_1to1");
//
//	}	
//
//}


