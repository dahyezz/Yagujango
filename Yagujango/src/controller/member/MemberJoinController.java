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
		
		//요청 파라미터 정보 삽입
		Member member = new Member();
		
		member.setUserid(req.getParameter("userid"));
		member.setUserpw(req.getParameter("userpw"));
		member.setUsernick(req.getParameter("usernick"));
		member.setUsername(req.getParameter("username"));
		member.setBirth(memberService.StringToDate(req.getParameter("birth")));
		member.setGender(req.getParameter("gender"));
		member.setPhone(req.getParameter("phone"));
		member.setEmail(req.getParameter("email"));
		member.setMyteam(req.getParameter("myteam"));
		
		//블랙리스트 체크
		boolean blacklistCheck=memberService.blacklistCheck(member);
		
		resp.setContentType("text/html;charset=utf-8");
		PrintWriter out=resp.getWriter();
		
		if(blacklistCheck){	//블랙리스트가 아니면
			//회원가입
			memberService.join(member);
			
			resp.sendRedirect("/main");
			
		}else {	//블랙리스트 이면
			 out.println("<script type='text/javascript'>");
		     out.println("alert('가입자는 블랙리스트로 등록되어 회원가입을 할 수 없습니다!');");
		     out.println("location.href='/main';");
		     out.println("</script>");
		     out.flush();
		     
		     return;
		}
	}
}
