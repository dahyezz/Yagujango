package controller.admin;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.Board_1to1_answer;
import service.face.AdminService;
import service.impl.AdminServiceImpl;
import util.Paging;

//답변완료목록조회
@WebServlet("/answer/list")
public class AnswerListController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	private AdminService adminService = new AdminServiceImpl();
	
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		resp.setCharacterEncoding("utf-8");

		//요청파라미터에서 curPage 얻어오기
		Paging paging = adminService.getCurPage(req);
		
		//Model로 Paging 객체 넣기
		req.setAttribute("paging", paging);
		
		resp.setCharacterEncoding("utf-8");

		//답변완료목록조회
		List<Board_1to1_answer> alist = adminService.agetList(paging);
		
		//model로 결과 넣기
		req.setAttribute("alist", alist);
		
		//view지정
		req.getRequestDispatcher("/WEB-INF/views/admin/answerlist.jsp").forward(req, resp);
	}

}
