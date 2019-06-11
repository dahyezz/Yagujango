package service.impl;

import java.io.File;


import java.io.UnsupportedEncodingException;
import java.util.Iterator;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import dao.face.AdminDao;
import dao.impl.AdminDaoImpl;
import dto.Board_1to1;
import dto.Board_1to1_answer;
import dto.Mem_blacklist;
import service.face.AdminService;
import util.Paging;


public class AdminServiceImpl implements AdminService{
	
	private AdminDao adminDao = new AdminDaoImpl();

	@Override
	public List getList(Paging paging) {
		
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
	public List bgetList(Paging paging) {
			
		return adminDao.bselectAll(paging);

	}

	@Override
	public List blackgetList(Paging paging) {

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
		adminDao.updateStatus(board_1to1);
		


	}

	@Override
	public List agetList(Paging paging) {
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
		List<Integer> member = adminDao.selectPenalty(names);
		// update하기전에 select penalty from member where userno=? 이런식으로 불러와서
		//  패널티가 몇인지  확인 후 (1단계)
		// 반복문 돌면서  횟수는 penal.size() 
		
//		for
		// 2단계 -> 조건문
		// penalty == 0 이면  update 쿼리에 SET penalty=1
		//	패널티 == 1 이면 set =2
		//  패널티 == 2 이면 set = 3 처리 하고 블랙리스트에 insert

		adminDao.updatePenalty(names);
		
	}

	@Override
	public void blacklistDelete(String names) {
		
		adminDao.deleteBlackList(names);

	}

	@Override
	public void write(Board_1to1_answer board_1to1_answer, HttpServletRequest req) {
		// TODO Auto-generated method stub
		
	}
	
}
