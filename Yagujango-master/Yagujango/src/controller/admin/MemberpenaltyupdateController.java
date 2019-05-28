package controller.admin;
//
//import java.io.IOException;
//import javax.servlet.ServletException;
//import javax.servlet.annotation.WebServlet;
//import javax.servlet.http.HttpServlet;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//
//import service.face.ManagerService;
//import service.impl.ManagerServiceImpl;
//
//@WebServlet("/admin/penaltyupdate")
//public class MemberpenaltyupdateController extends HttpServlet {
//	private static final long serialVersionUID = 1L;
//       
//	//ManagerService °´Ã¼
//	private ManagerService managerService = new ManagerServiceImpl();
//				
//	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

//		String names = req.getParameter("names");
//		
//		if( !"".equals(names) && names != null) {
//			managerService.penaltyUpdate(names);
//		}
//		
//		resp.sendRedirect("/admin/list");
//
//	}

//}
