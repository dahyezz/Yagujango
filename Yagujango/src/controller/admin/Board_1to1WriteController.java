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

		List<Stadium> list = reserveService.getList();
		
		//�씠嫄� �닔�젙
		req.setAttribute("list", list);
		
		//요청파라미터에서 curPage 얻어오기
		Paging paging = adminService.getCurPage(req);
		
		//Model로 Paging 객체 넣기
		req.setAttribute("paging", paging);
		
//		//로그인 되어있지 않으면 리다이렉트 
//		if( req.getSession().getAttribute("login") == null ) {
//			resp.sendRedirect("/admin/list");
//			return;
//		}
		
		//VIEW 지정
		req.getRequestDispatcher("/WEB-INF/views/admin/board_1to1_write.jsp").forward(req, resp);
			
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		// 작성글 삽입
		adminService.write(req);
		
		resp.sendRedirect("/admin/board_1to1");
		
	}

}
