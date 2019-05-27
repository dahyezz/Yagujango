package dto;

import java.util.Date;

public class Board_faq {

	private int boardno;
	private String title;
	private String content;
	private Date writtendate;
	
	@Override
	public String toString() {
		return "Board_faq [boardno=" + boardno + ", title=" + title + ", content=" + content + ", writtendate="
				+ writtendate + "]";
	}
	
	public int getBoardno() {
		return boardno;
	}
	public void setBoardno(int boardno) {
		this.boardno = boardno;
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
	public Date getWrittendate() {
		return writtendate;
	}
	public void setWrittendate(Date writtendate) {
		this.writtendate = writtendate;
	}
	
}