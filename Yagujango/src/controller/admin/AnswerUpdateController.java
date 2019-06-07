package controller.admin;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.Board_1to1;
import dto.Board_1to1_answer;
import service.face.AdminService;
import service.impl.AdminServiceImpl;

@WebServlet("/answer/update")
public class AnswerUpdateController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	private AdminService adminService = new AdminServiceImpl();

	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		
		//로그인한 사람이 아니면 목록으로
		if( req.getSession().getAttribute("login") == null ) {
			resp.sendRedirect("/main");
			return;
		}
		
		resp.setCharacterEncoding("utf-8");
		
		//게시글 번호 파싱
		Board_1to1_answer answerBoard =adminService.AgetBoardno(req);
		
		//게시글 조회
		answerBoard = adminService.Aview(answerBoard);

		// viewboard 객체 만들어서
		Board_1to1 viewBoard = new Board_1to1();
		viewBoard.setBoardno(answerBoard.getBoardno());
		// 문의 내용조회
		viewBoard = adminService.view(viewBoard);
		req.setAttribute("viewcontent", viewBoard.getContent());
		req.setAttribute("viewdate", viewBoard.getWrittendate());

		resp.setCharacterEncoding("utf-8");
		
		//model로 게시글 전달
		req.setAttribute("answerBoard", answerBoard);
		
		//view지정
		req.getRequestDispatcher("/WEB-INF/views/admin/answerupdate.jsp").forward(req, resp);
		
	}
		
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		req.setCharacterEncoding("utf-8");
		resp.setCharacterEncoding("UTF-8");

		//게시글 번호 파싱
		Board_1to1 viewBoard = adminService.getBoardno(req);
		
		//게시글 조회
		viewBoard = adminService.view(viewBoard);
		
		Board_1to1_answer board_1to1_answer = new Board_1to1_answer();
		board_1to1_answer.setWriter_userid(viewBoard.getWriter_userid());
		
		adminService.update(board_1to1_answer, req);
		
		resp.sendRedirect("/answer/list");		
		
	}

}
