package dto;

import java.util.Date;

public class Board_Free {
	private int boardno;
	private String tag;
	private String title;
	private String content;
	private String writer;
	private int hit;
	private Date writtendate;
	@Override
	public String toString() {
		return "Board_Free [boardno=" + boardno + ", tag=" + tag + ", title=" + title + ", content=" + content
				+ ", writer=" + writer + ", hit=" + hit + ", writtendate=" + writtendate + "]";
	}
	public int getBoardno() {
		return boardno;
	}
	public void setBoardno(int boardno) {
		this.boardno = boardno;
	}
	public String getTag() {
		return tag;
	}
	public void setTag(String tag) {
		this.tag = tag;
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
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public int getHit() {
		return hit;
	}
	public void setHit(int hit) {
		this.hit = hit;
	}
	public Date getWrittendate() {
		return writtendate;
	}
	public void setWrittendate(Date writtendate) {
		this.writtendate = writtendate;
	}
	

}
