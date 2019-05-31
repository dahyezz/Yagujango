package controller.admin;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.Stadium;
import service.face.AdminService;
import service.face.ReserveService;
import service.impl.AdminServiceImpl;
import service.impl.ReserveServiceImpl;
import util.Paging;

//1:1 질문목록보기

@WebServlet("/admin/board_1to1")
public class Board_1to1ListController extends HttpServlet {
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
		
		//1:1 답변목록조회
		List blist = adminService.bgetList(paging);
		
		//model로 결과 넣기
		req.setAttribute("blist", blist);
		
		//view지정
		req.getRequestDispatcher("/WEB-INF/views/admin/board_1to1_list.jsp").forward(req, resp);
		
		
	}

}
