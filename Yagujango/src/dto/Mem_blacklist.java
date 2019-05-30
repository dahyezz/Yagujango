package dto;

public class Mem_blacklist {
	
	private String userid;
	private String username;
	private String email;
	private String phone;
		
	@Override
	public String toString() {
		return "Mem_blacklist [userid=" + userid + ", username=" + username + ", email=" + email + ", phone=" + phone
				+ "]";
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	
	

}
