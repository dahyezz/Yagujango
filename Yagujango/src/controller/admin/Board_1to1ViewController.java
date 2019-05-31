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

@WebServlet("/admin/board_1to1view")
public class Board_1to1ViewController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	private AdminService adminService = new AdminServiceImpl();
	private ReserveService reserveService = new ReserveServiceImpl();

	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		List<Stadium> list = reserveService.getList();
		
		//�씠嫄� �닔�젙
		req.setAttribute("list", list);
		
		//요청파라미터에서 curPage 얻어오기
		Paging paging = adminService.getCurPage(req);
		
		//Model로 Paging 객체 넣기
		req.setAttribute("paging", paging);
		
		//게시글 번호 파싱
		Board_1to1 viewBoard = adminService.getBoardno(req);
		
		//게시글 조회
		viewBoard = adminService.view(viewBoard);
		
		//model로 게시글 전달
		req.setAttribute("viewBoard", viewBoard);
		
		//view지정
		req.getRequestDispatcher("/WEB-INF/views/admin/board_1to1_view.jsp").forward(req, resp);
		
	}

}
