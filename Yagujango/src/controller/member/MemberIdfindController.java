package controller.member;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.Member;
import service.face.MemberService;
import service.impl.MemberServiceImpl;

@WebServlet("/member/idFind")
public class MemberIdfindController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private MemberService memberService = new MemberServiceImpl();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.getRequestDispatcher("/WEB-INF/views/member/idFind.jsp").forward(req, resp);
	} 
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		Member member = new Member();
		
		member.setUsername(req.getParameter("username"));
		member.setEmail(req.getParameter("email"));
		
		boolean idFind = memberService.idFind(member);
		
		if(idFind) {
			
			Member mem = memberService.getIdfind(member);
			
			req.setAttribute("idFind", true);
			req.setAttribute("member", mem.getUserid());
		}
		req.getRequestDispatcher("/member/idFind_ok.jsp").forward(req, resp);	//뷰 지정
	}
}
