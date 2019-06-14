package service.impl;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.Iterator;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.google.gson.JsonObject;

import dao.face.Board_SeatDao;
import dao.impl.Board_SeatDaoImpl;
import dto.Board_Seat;
import dto.Board_file;
import service.face.Board_SeatService;
import util.Paging;

public class Board_SeatServiceImpl implements Board_SeatService{
	Board_SeatDao board_SeatDao = new Board_SeatDaoImpl();
	@Override
	public Paging getCurPage(HttpServletRequest req) {
		
		
		
		String param = req.getParameter("curPage");
		int curPage = 0;
		if (param != null && !"".equals(param)) {
			curPage = Integer.parseInt(param);
		} 
		Paging paging = new Paging();
		
		
		int totalCount = board_SeatDao.selectCntAll(paging);
			
		int listCount = 7;
		int pageCount = 10;
		paging = new Paging(totalCount, curPage, listCount,pageCount);
		paging.setName(req.getParameter("name"));
		paging.setKeyword(req.getParameter("keyword"));
		
		//		System.out.println(paging);
		
		return paging;
	}
	@Override
	public List<Board_Seat> getList(Paging paging) {
		return board_SeatDao.selectAll(paging);
	}
	@Override
	public void write(HttpServletRequest req) {
		Board_Seat board_seat = new Board_Seat();
		HttpSession session = req.getSession();
	
		
		board_seat.setStadium_name(req.getParameter("stadium_name"));
		board_seat.setSeat_block(req.getParameter("seat_block"));
		String seat_param = req.getParameter("seat_number");
		int seat_number = Integer.parseInt(seat_param);
		board_seat.setSeat_number(seat_number);
		board_seat.setContent(req.getParameter("content"));
		board_seat.setWriter((String)session.getAttribute("usernick"));
		board_seat.setFileurl(req.getParameter("fileurl"));
		
		
		if(req.getParameter("boardno") == null) {
			board_SeatDao.Insert(board_seat);
		}else {
			String boardno_param = req.getParameter("boardno");
			int boardno = Integer.parseInt(boardno_param);
			board_seat.setBoardno(boardno);
			
			board_SeatDao.InsertwithFile(board_seat);
		}
		
		
	}
	@Override
	public void uploadfile(HttpServletRequest req, HttpServletResponse resp) {
		Board_file board_file = new Board_file();
		String url = "http://localhost:8088/upload/";
		resp.setCharacterEncoding("utf-8");
		JsonObject obj = new JsonObject();
		int boardno = 0;

				DiskFileItemFactory factory = null;
				factory = new DiskFileItemFactory();

				// 3. 업로드된 아이템이 용량이 적당히 작으면 메모리에서 처리
				int maxMem = 1 * 1024 * 1024; // 1MB
				factory.setSizeThreshold(maxMem);
				// 4. 용량이 적당히 크면 임시파일 만들어서 처리(디스크)
				ServletContext context = req.getServletContext();

				File repository = new File(context.getRealPath("tmp"));
//				System.out.println(repository);
//				System.out.println(repository.exists());

				factory.setRepository(repository);
				// 5. 업로드 허용 기준을 넘지 않을 경우에만 파일 업로드 처리
				int maxFile = 10 * 1024 * 1024; // 10MB
				ServletFileUpload upload = null;
				upload = new ServletFileUpload(factory);

				upload.setFileSizeMax(maxFile);

				// --업로드 준비 완료--

				// 6. 업로드된 데이터 추출(파싱)
				List<FileItem> items = null;
				try {
					items = upload.parseRequest(req);
				} catch (FileUploadException e) {
					e.printStackTrace();
				}

				Iterator<FileItem> iter = items.iterator();

			
				File up = new File(context.getRealPath("upload"));
				while (iter.hasNext()) {

			
					FileItem item = iter.next();


					if (item.getSize() <= 0)
						continue;

					if (item.isFormField()) {
						String key = item.getFieldName();
						if ("boardno".equals(key)) {
								String param;
								try {
									param = item.getString("utf-8");
									boardno = Integer.parseInt(param);
									if(boardno == 0) {
//										boardno = board_FreeDao.getboardno();
										boardno = board_SeatDao.getboardno();
										
										obj.addProperty("boardno", boardno);
//										System.out.println(boardno);
										board_file.setBoardno(boardno);
//										System.out.println(board_file);
										
									}else {
										obj.addProperty("boardno", boardno);
//										System.out.println(boardno);
										board_file.setBoardno(boardno);
//										System.out.println(board_file);
									}
								} catch (UnsupportedEncodingException e) {
									e.printStackTrace();
								} 
								
								
					}
		

					} else {
						UUID uuid = UUID.randomUUID();

						String u = uuid.toString().split("-")[4];

						
						up = new File(context.getRealPath("upload"), item.getName() + "_" + u);
						url += item.getName() + "_" + u;
				

						board_file.setOriginname(item.getName());
						board_file.setStoredname(up.getName());
						board_file.setFilesize((int) item.getSize());
						
						// --------------------------
						try {
							item.write(up);
							item.delete();
						} catch (Exception e) {
							e.printStackTrace();
						}
					}
				}
	
//		System.out.println(url);
		obj.addProperty("url", url);
		
		if(board_file.getOriginname() != null && 
		board_file.getOriginname() != null &&
		board_file.getFilesize() != 0) {
//			System.out.println(board_file);
			board_SeatDao.insertFile(board_file);
		}
		try {
			resp.getWriter().print(obj);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	@Override
	public Board_Seat getBoardno(HttpServletRequest req) {
		Board_Seat board_seat = new Board_Seat();
		String param = req.getParameter("boardno");
		int boardno = Integer.parseInt(param);
		board_seat.setBoardno(boardno);
		
		return board_seat;
	}
	@Override
	public void addHit(Board_Seat board_seat) {
		board_SeatDao.upHit(board_seat);
		
	}
	@Override
	public Board_Seat view(Board_Seat board_seat) {
		
		return board_SeatDao.selectbyboardno(board_seat);
		
	}
	@Override
	public void delete(Board_Seat board_seat) {
		board_SeatDao.deletebyboardno(board_seat);
		
	}
	@Override
	public void update(HttpServletRequest req) {
		Board_Seat board_seat = new Board_Seat();
		HttpSession session = req.getSession();
		board_seat.setStadium_name(req.getParameter("stadium_name"));
		board_seat.setSeat_block(req.getParameter("seat_block"));
		String seat_param = req.getParameter("seat_number");
		int seat_number = Integer.parseInt(seat_param);
		board_seat.setSeat_number(seat_number);
		board_seat.setContent(req.getParameter("content"));
		board_seat.setWriter((String)session.getAttribute("usernick"));
		board_seat.setFileurl(req.getParameter("fileurl"));
		board_SeatDao.update(board_seat);
		
	}

}
