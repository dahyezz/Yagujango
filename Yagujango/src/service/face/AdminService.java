package service.face;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import dto.Board_1to1;
import dto.Board_1to1_answer;
import dto.Mem_blacklist;
import util.Paging;

public interface AdminService {
	
	/**
	 * @param
	 * @return ȸ�������ȸ
	 */
	public List getList(Paging paging);
	
	/**
	 * ��û�Ķ���Ϳ��� curPage�� �Ľ��Ѵ�.
	 * 
	 * @param req - ��û������ü
	 * @return Paging - ����¡ ����� �Ϸ�� ��ü
	 */
	public Paging getCurPage(HttpServletRequest req);
	
	/**
	 * @param
	 * @return �Խ��Ǹ���Ʈ��ȸ
	 */

	public List bgetList(Paging paging);
	
	/**
	 * @param
	 * @return ������Ʈ��ȸ
	 */

	public List blackgetList(Paging paging);
	
	/**
	 * 요청파라미터에서 boardno를 파싱한다.
	 * @param req -요청정보객체
	 * @return Board_1to1 - boardno를 입력한 객체
	 */
	public Board_1to1 getBoardno(HttpServletRequest req);
	/**
	 * 1:1게시글 조회
	 * @param viewBoard - �󼼺����� boardno�� ���� ��ü
	 * @return Board_1to1 - �󼼺����� �Խñ� ��ȸ ���
	 */
	public Board_1to1 view(Board_1to1 viewBoard);
	
	/**
	 * 게시글 작성
	 * @param req - 요청 정보 객체
	 */
	public void write(Board_1to1_answer board_1to1_answer,HttpServletRequest req);
	
	//답변완료목록리스트
	public List agetList(Paging paging);
	
	/**
	 * 요청파라미터에서 answerno를 파싱한다.
	 * @param req -요청정보객체
	 * @return Board_1to1_answer - answerno를 입력한 객체
	 */
	public Board_1to1_answer AgetBoardno(HttpServletRequest req);

	public Board_1to1_answer Aview(Board_1to1_answer answerBoard);
	/**
	 * 게시글 삭제
	 * 
	 * @param board_1to1- 삭제할 게시글 번호를 가진 객체
	 */
	public void delete(Board_1to1 board_1to1);

	public void Adelete(Board_1to1_answer board_1to1_answer);

	public void update(Board_1to1_answer board_1to1_answer, HttpServletRequest req);

	public void memberListDelete(String names);

	public void memberPenalty(String names);

	void write(Board_1to1_answer board_1to1_answer, Board_1to1 board_1to1, HttpServletRequest req);

	public void blacklistDelete(String names);

	
	

}
