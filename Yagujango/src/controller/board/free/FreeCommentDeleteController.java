package controller.board.free;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.Board_Free;
import dto.Comment;
import service.face.Board_FreeService;
import service.impl.Board_FreeServiceImpl;

/**
 * Servlet implementation class FreeCommentDeleteController
 */
@WebServlet("/board/free/comment/delete")
public class FreeCommentDeleteController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Board_FreeService board_FreeService = new Board_FreeServiceImpl();

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		Board_Free board_free = board_FreeService.getBoardno(req);

		String commentparam = req.getParameter("commentno");
		int boardno = board_free.getBoardno();
		int commentno = Integer.parseInt(commentparam);
		Comment comment = new Comment();
		comment.setBoardno(boardno);
		comment.setCommentno(commentno);
		
		board_FreeService.deletecomment(comment);
		
		List<Comment> commentlist = board_FreeService.commentlist(board_free);
		
		resp.setCharacterEncoding("utf-8");

		//MODEL
		req.setAttribute("comment", commentlist);
		req.getRequestDispatcher("/WEB-INF/views/layout/comment.jsp").forward(req, resp);
	}
}
