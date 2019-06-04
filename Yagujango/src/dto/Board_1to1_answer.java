package dto;

import java.util.Date;

public class Board_1to1_answer {
	
	private int answerno;
	private int boardno;
	private String writer_userid;
	private String content;
	private Date writtendate;

	@Override
	public String toString() {
		return "Board_1to1_answer [answerno=" + answerno + ", boardno=" + boardno + ", writer_userid=" + writer_userid
				+ ", content=" + content + ", writtendate=" + writtendate + "]";
	}

	public int getAnswerno() {
		return answerno;
	}
	public void setAnswerno(int answerno) {
		this.answerno = answerno;
	}
	public int getBoardno() {
		return boardno;
	}
	public void setBoardno(int boardno) {
		this.boardno = boardno;
	}
	public String getWriter_userid() {
		return writer_userid;
	}
	public void setWriter_userid(String writer_userid) {
		this.writer_userid = writer_userid;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Date getWrittendate() {
		return writtendate;
	}
	public void setWrittendate(Date writtendate) {
		this.writtendate = writtendate;
	}

}
