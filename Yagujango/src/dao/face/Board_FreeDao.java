package dao.face;

import java.util.List;

import dto.Board_Free;
import dto.Comment;
import util.Paging;



public interface Board_FreeDao {

	public int selectCntAll(Paging paging);
	
	public int selectCntNotice();
	
	public List<Board_Free> selectAll(Paging paging);
	
	public List<Board_Free> selectNoticeAll(Paging paging);
	
	public List<Board_Free> selectAllwithNotice(Paging paging);

	public Board_Free selectBoardByBoardno(Board_Free viewboard);

	public void upHit(Board_Free viewboard);

	public void NoticeupHit(Board_Free viewboard);

	public Board_Free selectNoticeByBoardno(Board_Free viewboard);

	public void InsertNotice(Board_Free board_free);

	public void Insert(Board_Free board_free);

	public void deleteBoardbyboardno(Board_Free board);

	public void updateBoard_Free(Board_Free board);

	public List<Comment> selectCommentbyboardno(Board_Free viewboard);

	public void CommentInsert(Comment comment);

	public void CommentDelete(Comment comment);




}
