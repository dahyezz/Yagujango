package controller.admin;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.face.AdminService;
import service.face.ReserveService;
import service.impl.AdminServiceImpl;
import service.impl.ReserveServiceImpl;


@WebServlet("/admin/penalty")
public class PenaltyController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	private AdminService adminService = new AdminServiceImpl();
	private ReserveService reserveService = new ReserveServiceImpl();

	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		resp.setCharacterEncoding("UTF-8");
		
		String names = req.getParameter("names");
		
		if( !"".equals(names) && names != null) {
			adminService.memberPenalty(names);
		}
	
		resp.sendRedirect("/admin/list");	}

}
