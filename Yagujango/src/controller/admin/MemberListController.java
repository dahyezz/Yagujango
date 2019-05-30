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

@WebServlet("/admin/list")
public class MemberListController extends HttpServlet {
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
		
		//회원목록조회
		List mlist = adminService.getList(paging);
		
		//model로 결과 넣기
		req.setAttribute("mlist", mlist);
		
		//view지정
		req.getRequestDispatcher("/WEB-INF/views/admin/list.jsp").forward(req, resp);
		
	}

}
