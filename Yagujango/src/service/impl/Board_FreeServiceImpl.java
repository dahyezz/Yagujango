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

import dao.face.Board_FreeDao;
import dao.impl.Board_FreeDaoImpl;
import dto.Board_Free;
import dto.Board_file;
import dto.Comment;
import service.face.Board_FreeService;
import util.Paging;

public class Board_FreeServiceImpl implements Board_FreeService{
	Board_FreeDao board_FreeDao = new Board_FreeDaoImpl();
	@Override
	public Paging getCurPage(HttpServletRequest req) {
		//검색어 기능
		String name = req.getParameter("name");
		String keyword = req.getParameter("keyword");
		String param = req.getParameter("curPage");
		
		int curPage = 0;
		if (param != null && !"".equals(param)) {
			curPage = Integer.parseInt(param);
		} 
		Paging paging = new Paging();
		paging.setName(name);
		paging.setKeyword(keyword);
		int totalCount = board_FreeDao.selectCntAll(paging);
		if (name == null && keyword == null) {
			totalCount = totalCount+3;
		}if ("tag".equals(name) && "공지".equals(keyword)) {
			totalCount = board_FreeDao.selectCntNotice();
		}
			
		paging = new Paging(totalCount, curPage);
		
		paging.setName(name);
		paging.setKeyword(keyword);
		//		System.out.println(paging);
		
		return paging;
		
	}
	@Override
	public List<Board_Free> getList(Paging paging) {
		return board_FreeDao.selectAll(paging);
	}
	@Override
	public List<Board_Free> getListwithNotice(Paging paging) {
		return board_FreeDao.selectAllwithNotice(paging);
	}
	@Override
	public Board_Free getBoardno(HttpServletRequest req) {
		String param = req.getParameter("boardno");
		int boardno = Integer.parseInt(param);
		Board_Free board = new Board_Free();
		board.setBoardno(boardno);
		return board;
	}
	@Override
	public Board_Free view(Board_Free viewboard) {
		
		return board_FreeDao.selectBoardByBoardno(viewboard);
	}
	@Override
	public void addHit(Board_Free viewboard) {
		board_FreeDao.upHit(viewboard);
		
	}
	@Override
	public void noticeaddhit(Board_Free viewboard) {
		board_FreeDao.NoticeupHit(viewboard);
	}
	@Override
	public Board_Free noticeview(Board_Free viewboard) {
		return board_FreeDao.selectNoticeByBoardno(viewboard);
	}
	@Override
	public void uploadfile(HttpServletRequest req,HttpServletResponse resp) {
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
										boardno = board_FreeDao.getboardno();
										
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
		obj.addProperty("url", url);
		if(board_file.getOriginname() != null && 
		board_file.getOriginname() != null &&
		board_file.getFilesize() != 0) {
			System.out.println(board_file);
			board_FreeDao.insertFile(board_file);
		}
		
		try {
			resp.getWriter().print(obj);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	@Override
	public void write(HttpServletRequest req) {
		try {
			req.setCharacterEncoding("utf-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		Board_Free board_free = new Board_Free();
		HttpSession session = req.getSession();
		board_free.setTag(req.getParameter("tag"));
		board_free.setTitle(req.getParameter("title"));
		board_free.setContent(req.getParameter("content"));
		board_free.setWriter((String)session.getAttribute("usernick"));
		
		String param = req.getParameter("boardno");
		int boardno = Integer.parseInt(param);
		//테스트
//		System.out.println(board_free);
		if(boardno == 0) {
			if("공지".equals(board_free.getTag())) {
				board_FreeDao.InsertNotice(board_free);
			}else {
				board_FreeDao.Insert(board_free);
			}
		}else {
			board_free.setBoardno(boardno);
			if("공지".equals(board_free.getTag())) {
				board_FreeDao.InsertNoticewithFile(board_free);
			}else {
				board_FreeDao.InsertwithFile(board_free);
			}
			
		}
		
		
	}
	@Override
	public void deleteboard_free(Board_Free board) {
		if("공지".equals(board.getTag())) {
			board_FreeDao.deletenoticeBoardbyboardno(board);
		}else {
		board_FreeDao.deleteBoardbyboardno(board);
		}
	}
	@Override
	public void update(HttpServletRequest req) {
		Board_Free board = new Board_Free();
		String param = req.getParameter("boardno");
		int boardno = Integer.parseInt(param);
		board.setBoardno(boardno);
		board.setTag(req.getParameter("tag"));
		board.setTitle(req.getParameter("title"));
		board.setContent(req.getParameter("content"));
		
		if("공지".equals(board.getTag())) {
			board_FreeDao.updateBoard_Free_Notice(board);
		}else {
			board_FreeDao.updateBoard_Free(board);
		}
		
	}
	@Override
	public List<Comment> commentlist(Board_Free viewboard) {
		return board_FreeDao.selectCommentbyboardno(viewboard);
	}
	@Override
	public void insertcomment(Comment comment) {
		board_FreeDao.CommentInsert(comment);
		
	}
	@Override
	public void deletecomment(Comment comment) {
		board_FreeDao.CommentDelete(comment);
	}
	@Override
	public List<Board_Free> getNoticeList(Paging paging) {
		
		return board_FreeDao.selectNoticeAll(paging);
	}

}
