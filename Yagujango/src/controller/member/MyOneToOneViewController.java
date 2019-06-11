package controller.member;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.Member;
import service.face.Board_1to1Service;
import service.face.MemberService;
import service.impl.Board_1to1ServiceImpl;
import service.impl.MemberServiceImpl;


@WebServlet("/member/my1to1/view")
public class MyOneToOneViewController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private Board_1to1Service board_1to1Service = new Board_1to1ServiceImpl();
	private MemberService memberService = new MemberServiceImpl();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
			
		req.getRequestDispatcher("/WEB-INF/views/member/my1to1view.jsp").forward(req, resp);
	
	}

}
