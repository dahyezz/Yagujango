package controller.member;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.Member;
import service.face.MemberService;
import service.impl.MemberServiceImpl;

@WebServlet("/member/join")
public class MemberJoinController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	MemberService memberService=new MemberServiceImpl();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//View JSP 지정
		req.getRequestDispatcher("/WEB-INF/views/member/join.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//요청파라미터 한글 처리 인코딩 설정 (UTF-8)
		req.setCharacterEncoding("utf-8");
		
		Member member = new Member();
		
		member.setUserid(req.getParameter("userid"));
		member.setUserpw(req.getParameter("userpw"));
		member.setUsernick(req.getParameter("usernick"));
		member.setUsername(req.getParameter("username"));
		try {
			member.setBirth(new SimpleDateFormat("yyyy-MM-dd").parse(req.getParameter("birth")));
		} catch (ParseException e) {
			e.printStackTrace();
		}
//		member.setBirth(req.getParameter("birth"));
		member.setGender(req.getParameter("gender"));
		member.setPhone(req.getParameter("phone"));
		member.setEmail(req.getParameter("email"));
		member.setMyteam(req.getParameter("myteam"));
		
		boolean idOverlap=memberService.idOverlap(member);
		boolean blacklistCheck=memberService.blacklistCheck(member);
		
		if(idOverlap) {
			req.setAttribute("idOverlap", true);
			
			if(blacklistCheck){
				memberService.join(member);
			}
			
			resp.sendRedirect("/main");
		}
	}
}
