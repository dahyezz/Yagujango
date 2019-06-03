package controller.board.free;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.Board_Free;
import dto.Comment;
import service.face.Board_FreeService;
import service.impl.Board_FreeServiceImpl;



/**
 * Servlet implementation class FreeCommentInsertController
 */
@WebServlet("/board/free/comment/insert")
public class FreeCommentInsertController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Board_FreeService board_FreeService = new Board_FreeServiceImpl();
	@Override
		protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
			req.setCharacterEncoding("utf-8");
			HttpSession session = req.getSession();
			Board_Free board_free = board_FreeService.getBoardno(req);
			int boardno = board_free.getBoardno();
			Comment comment = new Comment();
			comment.setBoardno(boardno);
			comment.setWriter((String)session.getAttribute("usernick"));
			comment.setContent(req.getParameter("content"));
			
			board_FreeService.insertcomment(comment);
			
			List<Comment> commentlist = board_FreeService.commentlist(board_free);
			
			resp.setCharacterEncoding("utf-8");

			//MODEL
			req.setAttribute("comment", commentlist);
			req.getRequestDispatcher("/WEB-INF/views/board/free/comment.jsp").forward(req, resp);
			
		}
}
