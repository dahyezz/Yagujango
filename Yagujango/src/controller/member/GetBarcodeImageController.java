package controller.member;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/mypage/barcode")
public class GetBarcodeImageController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String barcode = req.getParameter("barcode");
		
		resp.setContentType("image/png");
		PrintWriter out = resp.getWriter();
		
		out.println("<p><img src=/barcode/"+barcode+".png' width='100px'></p>");
	}
}
