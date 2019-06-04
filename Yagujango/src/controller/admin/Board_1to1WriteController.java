package controller.admin;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.Board_1to1;
import dto.Stadium;
import service.face.AdminService;
import service.face.ReserveService;
import service.impl.AdminServiceImpl;
import service.impl.ReserveServiceImpl;
import util.Paging;

@WebServlet("/admin/board_1to1_write")
public class Board_1to1WriteController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private AdminService adminService = new AdminServiceImpl();
	private ReserveService reserveService = new ReserveServiceImpl();
	
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		if( req.getSession().getAttribute("login") == null ) {
			resp.sendRedirect("/main");
			return;
		}
		
		//게시글 번호 파싱
		Board_1to1 viewBoard = adminService.getBoardno(req);
		
		//게시글 조회
		viewBoard = adminService.view(viewBoard);
		
		//model로 게시글 전달
		req.setAttribute("viewBoard", viewBoard);
		
		//VIEW 지정
		req.getRequestDispatcher("/WEB-INF/views/admin/board_1to1_write.jsp").forward(req, resp);
			
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		// 작성글 삽입
		adminService.write(req);
		
		//목록으로 리다이렉션
		resp.sendRedirect("/admin/board_1to1");
		
	}

}
