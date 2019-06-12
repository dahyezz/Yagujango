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

@WebServlet("/admin/board_1to1view")
public class Board_1to1ViewController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	private AdminService adminService = new AdminServiceImpl();
	
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	
		req.setCharacterEncoding("UTF-8");
		
		//게시글 번호 파싱
		Board_1to1 viewBoard = adminService.getBoardno(req);
		
		//게시글 조회
		viewBoard = adminService.view(viewBoard);
		
		//model로 게시글 전달
		req.setAttribute("viewBoard", viewBoard);
		
		//1:1문의 미처리된 게시글
		List<Board_1to1> untreatedList = adminService.getUntreatedList();
		req.setAttribute("untreatedList", untreatedList);
		
		//view지정
		req.getRequestDispatcher("/WEB-INF/views/admin/board_1to1_view.jsp").forward(req, resp);
		
	}

}
