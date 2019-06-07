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

@WebServlet("/member/idOverlap")
public class MemberIdoverlapController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	MemberService memberService=new MemberServiceImpl();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//View JSP 지정
		req.getRequestDispatcher("/WEB-INF/views/member/idOverlap.jsp").forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		Member member=new Member();
		member.setUserid(req.getParameter("userid"));
		
		//아이디 중복 확인
		boolean idOverlap=memberService.idOverlap(member);
		
		resp.setContentType("text/html;charset=utf-8");
		PrintWriter out=resp.getWriter();
		
		if(idOverlap)	out.println("0");	//아이디 중복이면
		else			out.println("1");	//아이디 중복이 아니면
		
		out.close();
	}
}
