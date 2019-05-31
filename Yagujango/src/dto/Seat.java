package dto;

public class Seat {

	private int seat_code;
	private String seat_block;
	private int seat_number;
	private int price;
	
	@Override
	public String toString() {
		return "Seat [seat_code=" + seat_code + ", seat_block=" + seat_block + ", seat_number=" + seat_number
				+ ", price=" + price + "]";
	}

	public int getSeat_code() {
		return seat_code;
	}

	public void setSeat_code(int seat_code) {
		this.seat_code = seat_code;
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

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}
	
	
	
	

}
