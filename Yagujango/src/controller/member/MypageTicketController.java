package controller.member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.face.MemberService;
import service.impl.MemberServiceImpl;

@WebServlet("/mypage/ticket")
public class MypageTicketController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private MemberService memberService = new MemberServiceImpl();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	
		req.getRequestDispatcher("/WEB-INF/views/member/myticket.jsp").forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		// - - - reserve_code 파라미터 파싱 - - - 
		
		String reserve_code = req.getParameter("reserve_code");
//		System.out.println(reserve_code);
		// - - - - - - - - - - - - - - - - - - - -
		
		memberService.cancleMyTicket(reserve_code);
		
		resp.sendRedirect("/mypage/ticket");
		
	}
}
