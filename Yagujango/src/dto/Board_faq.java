package dto;
 
import java.util.Date;

public class Board_faq {

	private int faq_boardno;
	private String faq_title;
	private String faq_content;
	private Date faq_writtendate;
	
	@Override
	public String toString() {
		return "Board_faq [faq_boardno=" + faq_boardno + ", faq_title=" + faq_title + ", faq_content=" + faq_content
				+ ", faq_writtendate=" + faq_writtendate + "]";
	}
	
	public int getFaq_boardno() {
		return faq_boardno;
	}
	public void setFaq_boardno(int faq_boardno) {
		this.faq_boardno = faq_boardno;
	}
	public String getFaq_title() {
		return faq_title;
	}
	public void setFaq_title(String faq_title) {
		this.faq_title = faq_title;
	}
	public String getFaq_content() {
		return faq_content;
	}
	public void setFaq_content(String faq_content) {
		this.faq_content = faq_content;
	}
	public Date getFaq_writtendate() {
		return faq_writtendate;
	}
	public void setFaq_writtendate(Date faq_writtendate) {
		this.faq_writtendate = faq_writtendate;
	}
	
	
	
}
