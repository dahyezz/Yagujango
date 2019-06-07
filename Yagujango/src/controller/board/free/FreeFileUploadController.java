package controller.board.free;


import java.io.IOException;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.JsonObject;

import service.face.Board_FreeService;
import service.impl.Board_FreeServiceImpl;

/**
 * Servlet implementation class FileUploadController
 */
@WebServlet("/board/free/fileupload")
public class FreeFileUploadController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Board_FreeService board_FreeService = new Board_FreeServiceImpl();
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		 board_FreeService.uploadfile(req,resp);
		

	}
}
