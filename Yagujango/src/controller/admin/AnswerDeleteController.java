package controller.admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.Board_1to1_answer;
import service.face.AdminService;
import service.impl.AdminServiceImpl;

@WebServlet("/answer/delete")
public class AnswerDeleteController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	private AdminService adminService = new AdminServiceImpl();
	
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		Board_1to1_answer board_1to1_answer = adminService.AgetBoardno(req);
		
		adminService.Adelete(board_1to1_answer);
		
		//목록으로 리다이렉트
		resp.sendRedirect("/answer/list");
		//asdfadfadfadfa
	}

}
