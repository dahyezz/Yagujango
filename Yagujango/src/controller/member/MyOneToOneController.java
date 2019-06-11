package controller.member;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.Member;
import service.face.Board_1to1Service;
import service.face.MemberService;
import service.impl.Board_1to1ServiceImpl;
import service.impl.MemberServiceImpl;


@WebServlet("/member/my1to1")
public class MyOneToOneController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private MemberService memberService = new MemberServiceImpl();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		List<Member> OneToOneList = new ArrayList<Member>();
		
		String userid = req.getParameter("userid");
		String content = req.getParameter("content");
		
		
		
		if( req.getSession().getAttribute("login") != null ) {
			
			OneToOneList = memberService.getOneToOneList();
		}
		
		req.setAttribute("OneToOneList", OneToOneList);
		
		req.getRequestDispatcher("/WEB-INF/views/member/my1to1.jsp").forward(req, resp);
	 
	}

} 
