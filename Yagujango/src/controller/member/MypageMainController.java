package controller.member;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.Member;
import service.face.MemberService;
import service.impl.MemberServiceImpl;
import util.Paging;

@WebServlet("/mypage/main")
public class MypageMainController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private MemberService memberService=new MemberServiceImpl();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		req.setCharacterEncoding("utf-8");
		
		Member member=new Member();
		member.setUserid((String)req.getSession().getAttribute("userid"));
		
		//세션에서 요청한 userid로 사용자 정보 조회
		memberService.getMemberByUserid(member);
		
		//view에 모델값 전달
		req.setAttribute("userid", (String)member.getUserid());
		req.setAttribute("usernick", (String)member.getUsernick());
		req.setAttribute("myteam", (String)member.getMyteam());
		
//		//요청 파라미터에서 curPage 얻어오기
//		Paging paging=boardService.getCurPage(req);
//		
//		//MODEL로 paging 객체 넣기
//		req.setAttribute("paging", paging);
//		
//		//board 테이블 전체 조회 결과 얻기
//		List list=boardService.getList(paging);
//		
//		//View에 모델값 전달하기, Model로 조회결과 넣기
//		req.setAttribute("boardList",list);
		
		//View JSP 지정하기
		req.getRequestDispatcher("/WEB-INF/views/member/myPage.jsp").forward(req, resp);
	}
}
