package controller.admin;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.face.AdminService;
import service.impl.AdminServiceImpl;

@WebServlet("/admin/listDelete")
public class MemberDeleteListController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	private AdminService adminService = new AdminServiceImpl();

	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String names = req.getParameter("names");
	
		if( !"".equals(names) && names != null) {
			adminService.memberListDelete(names);
		}
	
		resp.sendRedirect("/admin/list");

	}

}
