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

@WebServlet("/member/modify")
public class MemberModifyController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private MemberService memberService = new MemberServiceImpl();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		Member member = new Member();
		member.setUserid((String)req.getSession().getAttribute("userid"));
		member = memberService.getMemberByUserid(member);
//		System.out.println(member);
		
		req.setAttribute("member", member);
		
		req.getRequestDispatcher("/WEB-INF/views/member/modify.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");;
			
		//요청 파라미터 정보 삽입
		Member member = new Member();
		
		member.setUserid(req.getParameter("userid"));
		member.setUserpw(req.getParameter("userpw"));
		member.setUsernick(req.getParameter("usernick"));
		member.setPhone(req.getParameter("phone"));
		member.setEmail(req.getParameter("email"));
		member.setMyteam(req.getParameter("myteam"));
		
//		System.out.println(member);
		
		memberService.modifyMemberInfo(member);
		
		resp.sendRedirect("/mypage/main");
	}
}
