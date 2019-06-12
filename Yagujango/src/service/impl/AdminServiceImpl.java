package service.impl;

import java.io.UnsupportedEncodingException;
import java.util.List;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.NoSuchProviderException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;

import dao.face.AdminDao;
import dao.impl.AdminDaoImpl;
import dto.Board_1to1;
import dto.Board_1to1_answer;
import dto.Member;
import service.face.AdminService;
import util.MailAuth;
import util.Paging;


public class AdminServiceImpl implements AdminService{
	
	private AdminDao adminDao = new AdminDaoImpl();

	@Override
	public List<Member> getList(Paging paging) {
		
		return adminDao.selectAll(paging);
		
	}

	@Override
	public Paging getCurPage(HttpServletRequest req) {
		//�����Ķ���� curPage �Ľ�
		String param = req.getParameter("curPage");
		int curPage = 0;
		if(param!=null && !"".equals(param)) {
			curPage = Integer.parseInt(param);
		}
		
		//�˻���
		String keyword = (String)req.getParameter("keyword");
		
		//��ü �Խñ� ��
		int totalCount = adminDao.selectCntAll(keyword);
		
		//����¡ ��ü ����
		Paging paging = new Paging(totalCount, curPage);
		paging.setKeyword(keyword);
		System.out.println(paging);
		
		return paging;	
	}

	//1:1������ϸ���Ʈ
	@Override
	public List<Board_1to1> bgetList(Paging paging) {
			
		return adminDao.bselectAll(paging);

	}

	@Override
	public List<Member> blackgetList(Paging paging) {

		return adminDao.blackselectAll(paging);
	}

	@Override
	public Board_1to1 getBoardno(HttpServletRequest req) {

		//�����Ķ���� boardno �Ľ�
		String param = req.getParameter("boardno");
		int boardno = 0;
		if(param!=null && !"".equals(param)) {
			boardno = Integer.parseInt(param);
		}
		
		//Board_1to1 ��ü ����
		Board_1to1 board_1to1 = new Board_1to1();
		board_1to1.setBoardno(boardno);
		
		return board_1to1;
	}

	@Override
	public Board_1to1 view(Board_1to1 viewBoard) {

		//�Խñ� ��ȸ ��ȯ
		return adminDao.selectBoard_1to1ByBoardno(viewBoard);
	}

	//답변작성
	@Override
	public void write(Board_1to1_answer board_1to1_answer, Board_1to1 board_1to1, HttpServletRequest req) {

		try {
			req.setCharacterEncoding("utf-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		//Board_1to1_answer board_1to1_answer = new Board_1to1_answer();
		//HttpSession session = req.getSession();
				
		//write 폼 전달 값
		board_1to1_answer.setBoardno(Integer.parseInt(req.getParameter("boardno")));
		board_1to1_answer.setContent(req.getParameter("content"));
		//board_1to1_answer.setWriter_userid(req.getParameter("writer_userid"));

		//session 값
	//	board_1to1_answer.setWriter_userid((String)session.getAttribute("userid"));
		
		System.out.println(board_1to1_answer);

		adminDao.insert(board_1to1_answer);
//		adminDao.updateStatus(board_1to1);
		


	}

	@Override
	public List<Board_1to1_answer> agetList(Paging paging) {
		//답변완료목록리스트
				
		return adminDao.aselectAll(paging);

	}

	//답변완료 VIEW
	@Override
	public Board_1to1_answer AgetBoardno(HttpServletRequest req) {
		String param = req.getParameter("answerno");
		int answerno = 0;
		if(param!=null && !"".equals(param)) {
			answerno = Integer.parseInt(param);
		}
		
		//Board_1to1 ��ü ����
		Board_1to1_answer board_1to1_answer = new Board_1to1_answer();
		board_1to1_answer.setAnswerno(answerno);
		
		return board_1to1_answer;
	}

	//답변완료 VIEW
	@Override
	public Board_1to1_answer Aview(Board_1to1_answer answerBoard) {
	
		return adminDao.selectBoard_answerByBoardno(answerBoard);

	}

	@Override
	public void delete(Board_1to1 board_1to1) {

		adminDao.delete(board_1to1);
		
	}

	@Override
	public void Adelete(Board_1to1_answer board_1to1_answer) {
		
		adminDao.Adelete(board_1to1_answer);
		
	}

	@Override
	public void update(Board_1to1_answer board_1to1_answer, HttpServletRequest req) {
		try {
			req.setCharacterEncoding("utf-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		//Board_1to1_answer board_1to1_answer = new Board_1to1_answer();
		//HttpSession session = req.getSession();
				
		//write 폼 전달 값
		board_1to1_answer.setAnswerno(Integer.parseInt(req.getParameter("answerno")));
		board_1to1_answer.setContent(req.getParameter("content"));
		//board_1to1_answer.setWriter_userid(req.getParameter("writer_userid"));

		//session 값
	//	board_1to1_answer.setWriter_userid((String)session.getAttribute("userid"));
		
		System.out.println(board_1to1_answer);

		adminDao.update(board_1to1_answer);		
	}

	@Override
	public void memberListDelete(String names) {

		adminDao.deleteMemberList(names);
		
	}

	@Override
	public void memberPenalty(String names) {
		
		// List<Integer> penal  = dao.selectPenalty....(names)
		
		//member테이블 조회
		List<Member> member = adminDao.selectPenalty(names);
		// SELECT * FROM member WHERE userno 
		// update하기전에 select penalty from member where userno=? 이런식으로 불러와서
		//  패널티가 몇인지  확인 후 (1단계)
		// 반복문 돌면서  횟수는 penal.size() 
		System.out.println(member.size());
//		System.out.println(names);
		int penalty=0;
		
	    for(Member m : member) {
//	    	System.out.println(m);
	    	if(m.getPenalty() == 0 ) {
	    		//패널티 1로 업데이트
	    		penalty=1;
	    		adminDao.updatePenalty(m, penalty);
	    	}
	    	if(m.getPenalty() == 1 ) {
	    		//패널티 2로 업데이트
	    		penalty=2;
	    		adminDao.updatePenalty(m, penalty); 	
	    	}
	    	if(m.getPenalty() == 2 ) {
	    		//패널티 3으로 업데이트
	    		penalty=3;
	    		adminDao.updatePenalty(m, penalty);	
	    		adminDao.insertBlackMem(m);
	    	}	    	
	    }	   	
//		for
		// 2단계 -> 조건문
		// penalty == 0 이면  update 쿼리에 SET penalty=1
		//	패널티 == 1 이면 set =2
		//  패널티 == 2 이면 set = 3 처리 하고 블랙리스트에 insert
//		adminDao.updatePenalty(names);	
	}
	
//	@Override
//	public void blackinsert(Mem_blacklist mem) {
//
//		adminDao.insertBlackMem(mem);
//		
//	}
	

	@Override
	public void blacklistDelete(String names) {
		
		adminDao.deleteBlackList(names);

	}

	@Override
	public void write(Board_1to1_answer board_1to1_answer, HttpServletRequest req) {
		// TODO Auto-generated method stub
		
	}
	
	@Override
	public List<Board_1to1> getUntreatedList() {
		return adminDao.selectBoardNotInBoardAnswer();
	}
	
	@Override
	public void sendEmailAnswer(HttpServletRequest req) {
		
		//FROM 
		final String FROM = "yagujango123@gmail.com";
		final String FROMNAME = "야구장고";
		
		//TO
		final String TO = req.getParameter("email");

		Board_1to1 board_1to1 = getBoardno(req); //boardno만 있음
//		System.out.println("mailtest : " + board_1to1);
		
		String content = req.getParameter("content");
//		System.out.println("mataltest : " + content);
		
		final String SUBJECT = "문의주신 '" + req.getParameter("title") + "에 관한 답변작성이 완료되었습니다.";
		
		final String BODY = String.join(
				"<h1>야구장고</h1>",
				"<p>문의주신 내역 : " + req.getParameter("title") + "</p><br>",
				"<p>답변<p><br>",
				"<p>" + req.getParameter("content") + "</p>"
				);
		
		Authenticator auth = new MailAuth("yagujango123@gmail.com", "1q2w3e!!");
		
		Properties props = System.getProperties();
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.smtp.host", "smtp.gmail.com");
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.port", "587");

		Session session = Session.getDefaultInstance(props, auth);
		MimeMessage msg = new MimeMessage(session);
		
		try {
			msg.setFrom(new InternetAddress(FROM, FROMNAME));
			msg.setRecipient(Message.RecipientType.TO, new InternetAddress(TO));
			msg.setSubject(SUBJECT);
			msg.setContent(BODY, "text/html;charset=utf-8");

			System.out.println("Sending...");

			//메시지 보내기
			Transport.send(msg);
			
			System.out.println("Email sent!");

		} catch (NoSuchProviderException e) {
			e.printStackTrace();
			
		} catch (MessagingException e) {
			e.printStackTrace();
			
			System.out.println("The email was not sent.");
			System.out.println("Error message: " + e.getMessage());
			
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
	}


}
