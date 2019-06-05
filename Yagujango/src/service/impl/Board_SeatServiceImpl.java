package service.impl;

import java.io.File;
import java.util.Iterator;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

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
		
			
		paging = new Paging(totalCount, curPage);
		
		
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
		board_SeatDao.Insert(board_seat);
		
		
	}
	@Override
	public String uploadfile(HttpServletRequest req) {
		Board_file board_file = new Board_file();
		String url = "";
	

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

				// 7. 파싱된 데이터 처리
				Iterator<FileItem> iter = items.iterator();
				// 모든 요청정보 처리 루틴
			
				File up = new File(context.getRealPath("upload"));
				while (iter.hasNext()) {

					// ------요청정보 처리형태 3가지
					// 1. 빈 파일(용량이 0인파일)
					// 2. form data(일반적인 요청파라미터)
					// 3. 파일
					// -----------------------------
					// 요청 정보 하나씩 얻어오기
					FileItem item = iter.next();

					// 1)빈 파일 처리
					if (item.getSize() <= 0)
						continue;

					if (item.isFormField()) {// 2)일반적인 요청 데이터 처리
						// form-data일 경우

						// key:value 쌍으로 전달된 요청 파라미터
						// getFieldName():키
						// getString() : 값
						

					} else {// 3)파일 처리
						// 웹서버의 로컬디스크에 저장
						// 다른방법으로 는 DB에 저장하는방법이 있
						// UUID 생성하기
						UUID uuid = UUID.randomUUID();

						String u = uuid.toString().split("-")[4];

						// 로컬 파일 저장소의 파일 객체
//						up = new File(context.getRealPath("upload"), item.getName());
						up = new File(context.getRealPath("upload"), item.getName() + "_" + u);
						url = item.getName() + "_" + u;
						// 파일업로드 기록 DB에 저장하기
						// ex) 게시글의 첨부파일 처리

						// 업로드 파일 PK(fileno)
						// 게시글 테이블의 FK(boardno)

						// 업로드 파일의 원본 이름(originname)
						// 업로드 파일의 저장된 이름(storedname)

						// 업로드한사람의 FK(userid)

						// 업로드한 시간(uploaddate)
						// 업로드한 파일은 ContrentType(contenttype)
						// 업로드한 파일의 크기(size)(filesize)
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
						// 파일이 존재한다면 업로드 파일 DB 기록하기
						
					}
				}
		
		return url;
	}

}
