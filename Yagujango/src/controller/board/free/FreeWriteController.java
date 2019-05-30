package controller.board.free;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.face.Board_FreeService;
import service.impl.Board_FreeServiceImpl;

/**
 * Servlet implementation class FreeWriteController
 */
@WebServlet("/board/free/write")
public class FreeWriteController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Board_FreeService board_FreeService = new Board_FreeServiceImpl();
	@Override
		protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
			//로그인 되어있지 않으면 리다이렉트 
//			if( req.getSession().getAttribute("login") == null ) {
//				resp.sendRedirect("/main");
//				return;
//			}
			req.getRequestDispatcher("/WEB-INF/views/board/free/write.jsp").forward(req, resp);
		}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		board_FreeService.write(req);
		
		resp.sendRedirect("/board/free/list");
	}
}
