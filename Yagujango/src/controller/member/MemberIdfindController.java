package controller.member;

import java.io.IOException;

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
		
		//post데이터 한글 인코딩 UTF-8 설정
		req.setCharacterEncoding("utf-8");
		
		Member member = new Member();
		
		member.setUsername(req.getParameter("username"));
		member.setEmail(req.getParameter("email"));
		
		boolean idFind = memberService.idFind(member);
		
		if(idFind) {
			
			Member mem = memberService.getIdfind(member);
			
			req.setAttribute("idFind", true);
			req.setAttribute("userid", mem.getUserid());
			
			req.getRequestDispatcher("/WEB-INF/views/member/idFind_ok.jsp").forward(req, resp);	//뷰 지정
		}
	}
}
