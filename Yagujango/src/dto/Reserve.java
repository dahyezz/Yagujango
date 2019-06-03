package dto;

import java.util.Date;

public class Reserve {
	private int reserve_code;
	private int ticket_code;
	private int userno;
	private String payment;
	private Date payment_date;
	private int ticket_quantity;
	private String how_receive;
	
	@Override
	public String toString() {
		return "Reserve [reserve_code=" + reserve_code + ", ticket_code=" + ticket_code + ", userno=" + userno
				+ ", payment=" + payment + ", payment_date=" + payment_date + ", ticket_quantity=" + ticket_quantity
				+ ", how_receive=" + how_receive + "]";
	}

	public int getReserve_code() {
		return reserve_code;
	}

	public void setReserve_code(int reserve_code) {
		this.reserve_code = reserve_code;
	}

	public int getTicket_code() {
		return ticket_code;
	}

	public void setTicket_code(int ticket_code) {
		this.ticket_code = ticket_code;
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

	public int getTicket_quantity() {
		return ticket_quantity;
	}

	public void setTicket_quantity(int ticket_quantity) {
		this.ticket_quantity = ticket_quantity;
	}

	public String getHow_receive() {
		return how_receive;
	}

	public void setHow_receive(String how_receive) {
		this.how_receive = how_receive;
	}
}