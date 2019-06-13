package controller.member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.Member;
import service.face.MemberService;
import service.impl.MemberServiceImpl;


@WebServlet("/member/leave")
public class MemberLeaveController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private MemberService memberService = new MemberServiceImpl();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		Member member = new Member();
		member.setUserid((String)req.getSession().getAttribute("userid"));
//		System.out.println(member);
		
	
		memberService.leaveMember(member);
		
		//세션 객체 얻기
		HttpSession session = req.getSession();
				
		//세션 삭제
		session.invalidate();
		
		resp.sendRedirect("/main");
	
	}

}
