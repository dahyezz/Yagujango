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

@WebServlet("/member/pwFind")
public class MemberPwfindController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private MemberService memberService = new MemberServiceImpl();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.getRequestDispatcher("/WEB-INF/views/member/pwFind.jsp").forward(req, resp);
	} 
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		//post데이터 한글 인코딩 UTF-8 설정
		req.setCharacterEncoding("utf-8");
		
		Member member = new Member();
		
		member.setUsername(req.getParameter("username"));
		member.setEmail(req.getParameter("email"));
		member.setUserid(req.getParameter("userid"));
		
		boolean pwFind = memberService.pwFind(member);
		
		resp.setContentType("text/html;charset=utf-8");
		PrintWriter out=resp.getWriter();
		
		if(pwFind) {	//비밀번호가 있으면
			
			Member mem = memberService.getPwfind(member);
			
			out.println("사용자의 비밀번호는 ["+mem.getUserpw()+"] 입니다");
		} else {	//비밀번호가 없으면
			out.println("이름과 이메일과 아이디와 일치하는 비밀번호가 없습니다");
		}
	}
}
