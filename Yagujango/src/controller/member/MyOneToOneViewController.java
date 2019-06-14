package controller.member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.Board_1to1;
import service.face.MemberService;
import service.impl.MemberServiceImpl;


@WebServlet("/member/my1to1view")
public class MyOneToOneViewController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private MemberService memberService = new MemberServiceImpl();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	
		Board_1to1 my1to1view = memberService.getBoardno(req);
		
		my1to1view = memberService.view(my1to1view);
		
		req.setAttribute("my1to1view", my1to1view);
		
		req.getRequestDispatcher("/WEB-INF/views/member/my1to1view.jsp").forward(req, resp);
	
	}

}
