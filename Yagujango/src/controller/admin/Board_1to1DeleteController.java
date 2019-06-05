package controller.admin;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.Board_1to1;
import service.face.AdminService;
import service.impl.AdminServiceImpl;

@WebServlet("/board_1to1/delete")
public class Board_1to1DeleteController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	private AdminService adminService = new AdminServiceImpl();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		Board_1to1 board_1to1 = adminService.getBoardno(req);
		
		adminService.delete(board_1to1);
		
		//목록으로 리다이렉트
		resp.sendRedirect("/admin/board_1to1");
		
		
	}

}
