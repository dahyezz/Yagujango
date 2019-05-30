package dto;

import java.util.Date;

public class Board_1to1 {
	private int boardno;
	private int writer_userid;
	private String writer_email;
	private String title;
	private String content;
	private String writer_comment;
	private Date writtendate;

	
	@Override
	public String toString() {
		return "Board_1to1 [boardno=" + boardno + ", writer_userid=" + writer_userid + ", writer_email=" + writer_email
				+ ", title=" + title + ", content=" + content + ", writer_comment=" + writer_comment + ", writtendate="
				+ writtendate + "]";
	}
	
	public int getBoardno() {
		return boardno;
	}
	public void setBoardno(int boardno) {
		this.boardno = boardno;
	}
	public int getWriter_userid() {
		return writer_userid;
	}
	public void setWriter_userid(int writer_userid) {
		this.writer_userid = writer_userid;
	}
	public String getWriter_email() {
		return writer_email;
	}
	public void setWriter_email(String writer_email) {
		this.writer_email = writer_email;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}

	public String getWriter_comment() {
		return writer_comment;
	}
	public void setWriter_comment(String writer_comment) {
		this.writer_comment = writer_comment;
	}
	public Date getWrittendate() {
		return writtendate;
	}
	public void setWrittendate(Date writtendate) {
		this.writtendate = writtendate;

	}
	


}
