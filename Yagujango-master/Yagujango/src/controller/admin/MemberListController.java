package controller.admin;

import java.io.IOException;

import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.face.ManagerService;
import service.impl.ManagerServiceImpl;


@WebServlet("/member/list")
public class MemberListController extends HttpServlet {
	private static final long serialVersionUID = 1L;
      
	//MemberService객체
	private ManagerService managerService = new ManagerServiceImpl();
	
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		//회원 목록 조회
		List list = managerService.getList();
		
		//MODEL로 조회결과 넣기
		req.setAttribute("list", list);
		
		//VIEW지정
		req.getRequestDispatcher("/WEB-INF/views/member/list.jsp").forward(req, resp);
		
	}

}
