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
import util.Paging;


@WebServlet("/admin/list")
public class MemberListController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private ManagerService managerService = new ManagerServiceImpl();
	
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		//��û�Ķ���Ϳ��� curPage ������
		Paging paging = managerService.getCurPage(req);
		
		//Model�� Paging ��ü �ֱ�
		req.setAttribute("paging", paging);
		
		//ȸ�������ȸ
		List list = managerService.getList(paging);
		
		//model�� ��� �ֱ�
		req.setAttribute("list", list);
		
		//view����
		req.getRequestDispatcher("/WEB-INF/views/member/list.jsp").forward(req, resp);
		
		
	}



}
