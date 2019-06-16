package controller.board;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.face.Board_1to1Service;
import service.impl.Board_1to1ServiceImpl;


@WebServlet("/board/1:1write")
public class OneToOneWriteController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	Board_1to1Service board_1to1Service = new Board_1to1ServiceImpl();
	
	@Override 
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	
		if( req.getSession().getAttribute("login") == null ) {
			resp.sendRedirect("/member/login");
			return;
		}
		
		req.getRequestDispatcher("/WEB-INF/views/board/1to1/write.jsp").forward(req, resp);
	
	}

	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		
		//작성글 삽입
		board_1to1Service.write(req);
		
		//목록으로 리다이렉션
		resp.sendRedirect("/member/my1to1");

	}
}
