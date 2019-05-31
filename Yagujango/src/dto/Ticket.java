package dto;

public class Ticket {
	
	private int ticket_code;
	private int match_code;
	private int seat_code;
	
	@Override
	public String toString() {
		return "Ticket [ticket_code=" + ticket_code + ", match_code=" + match_code + ", seat_code=" + seat_code + "]";
	}

	public int getTicket_code() {
		return ticket_code;
	}

	public void setTicket_code(int ticket_code) {
		this.ticket_code = ticket_code;
	}

	public int getMatch_code() {
		return match_code;
	}

	public void setMatch_code(int match_code) {
		this.match_code = match_code;
	}

	public int getSeat_code() {
		return seat_code;
	}

	public void setSeat_code(int seat_code) {
		this.seat_code = seat_code;
	}
	
	

}
