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
		
		//Service를 통한 요청파라미터처리
		Member member = memberService.getLoginMember(req);
		
		//Service를 통한 회원가입(데이터베이스 삽입)
		memberService.join(member);
		
		//메인화면으로 리다이렉트
		resp.sendRedirect("/main");
	}
}
