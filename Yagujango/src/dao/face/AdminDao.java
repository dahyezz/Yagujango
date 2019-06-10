package dao.face;

import java.util.List;

import dto.Board_1to1;
import dto.Board_1to1_answer;
import dto.Mem_blacklist;
import util.Paging;

public interface AdminDao {
	
	//������ - ȸ����ü��ȸ
	public List selectAll(Paging paging);

	//������ -ȸ�� ���̺� ��ü count��ȸ
	public int selectCntAll(String keyword);
	
	//1:1������� ��ȸ
	public List bselectAll(Paging paging);

	public List blackselectAll(Paging paging);
	
	/**
	 * 1:1���� �󼼺���
	 * @param viewBoard - ��ȸ ���
	 * @return Board_1to1 - �󼼺����� �Խñ� ��ȸ ���
	 */
	public Board_1to1 selectBoard_1to1ByBoardno(Board_1to1 viewBoard);

	/**
	 * 다음 게시글 번호 반환
	 * 	게시글 테이블과 첨부파일 테이블에 들어갈 게시글 번호를 미리 추출
	 * 
	 * @return int
	 */
	public int selectBoardno();
	/**
	 * 게시글 입력
	 * 
	 * @param board - 삽입될 게시글 내용
	 */
	public void insert(Board_1to1_answer board_1to1_answer);

	//답변완료목록리스트
	public List aselectAll(Paging paging);

	//답변완료 view
	public Board_1to1_answer selectBoard_answerByBoardno(Board_1to1_answer answerBoard);
	/**
	 * 게시글 삭제
	 * 
	 * @param board_1to1 - 삭제할 게시글번호를 담은 객체
	 */
	public void delete(Board_1to1 board_1to1);

	public void Adelete(Board_1to1_answer board_1to1_answer);

	public void update(Board_1to1_answer board_1to1_answer);

	public void deleteMemberList(String names);

	public void updatePenalty(String names);

}
