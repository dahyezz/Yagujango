package dto;

import java.util.Date;

public class Board_Seat {
	private int boardno;
	private String stadium_name;
	private String seat_block;
	private int seat_number;
	private String content;
	private String writer;
	private int hit;
	private Date writtendate;
	private String fileurl;
	@Override
	public String toString() {
		return "Board_Seat [boardno=" + boardno + ", stadium_name=" + stadium_name + ", seat_block=" + seat_block
				+ ", seat_number=" + seat_number + ", content=" + content + ", writer=" + writer + ", hit=" + hit
				+ ", writtendate=" + writtendate + ", fileurl=" + fileurl + "]";
	}
	public int getBoardno() {
		return boardno;
	}
	public void setBoardno(int boardno) {
		this.boardno = boardno;
	}
	public String getStadium_name() {
		return stadium_name;
	}
	public void setStadium_name(String stadium_name) {
		this.stadium_name = stadium_name;
	}
	public String getSeat_block() {
		return seat_block;
	}
	public void setSeat_block(String seat_block) {
		this.seat_block = seat_block;
	}
	public int getSeat_number() {
		return seat_number;
	}
	public void setSeat_number(int seat_number) {
		this.seat_number = seat_number;
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
	public String getFileurl() {
		return fileurl;
	}
	public void setFileurl(String fileurl) {
		this.fileurl = fileurl;
	}

}
