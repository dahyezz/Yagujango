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

@WebServlet("/member/login")
public class MemberLoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private MemberService memberService = new MemberServiceImpl();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.getRequestDispatcher("/WEB-INF/views/member/login.jsp").forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	
		//로그인 정보 얻어오기
		Member member = memberService.getLoginMember(req);
		
		//로그인 인증
		boolean login = memberService.login(member);
		
		if(login) {
			
			member = memberService.getMemberByUserid(member);
			
			//세션 정보 저장
			req.getSession().setAttribute("login", true);
			req.getSession().setAttribute("userid", member.getUserid());
			req.getSession().setAttribute("usernick", member.getUsernick());
		}
		
		if(member.getUserid().equals("admin"))
			resp.sendRedirect("/admin/list");
		else
			resp.sendRedirect("/main");
		
	}
}
