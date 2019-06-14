package dto;

import java.util.Date;

public class Reserve {
	private String reserve_code;
	private int ticket_code;
	private int userno;
	private String payment;
	private Date payment_date;
	private String how_receive;
	private String barcode;
	
	
	@Override
	public String toString() {
		return "Reserve [reserve_code=" + reserve_code + ", ticket_code=" + ticket_code + ", userno=" + userno
				+ ", payment=" + payment + ", payment_date=" + payment_date + ", how_receive=" + how_receive + 
				",barcode=" + barcode + "]";
	}
	
	public String getReserve_code() {
		return reserve_code;
	}

	public void setReserve_code(String reserve_code) {
		this.reserve_code = reserve_code;
	}

	public int getTicket_code() {
		return ticket_code;
	}

	public void setTicket_code(int ticket_code2) {
		this.ticket_code = ticket_code2;
	}

	public int getUserno() {
		return userno;
	}

	public void setUserno(int userno) {
		this.userno = userno;
	}

	public String getPayment() {
		return payment;
	}

	public void setPayment(String payment) {
		this.payment = payment;
	}

	public Date getPayment_date() {
		return payment_date;
	}

	public void setPayment_date(Date payment_date) {
		this.payment_date = payment_date;
	}
	
	public String getHow_receive() {
		return how_receive;
	}

	public void setHow_receive(String how_receive) {
		this.how_receive = how_receive;
	}
	
	public String getBarcode() {
		return barcode;
	}

	public void setBarcode(String barcode) {
		this.barcode = barcode;
	}

}