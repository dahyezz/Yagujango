package dto;

import java.util.Date;

public class Member {
	
	private int userno;
	private String userid;
	private String userpw;
	private String username;
	private String usernick;
	private Date birth;
	private String gender;
	private String phone;
	private String email;
	private int penalty;
	private String myteam;
	
	@Override
	public String toString() {
		return "Member [userno=" + userno + ", userid=" + userid + ", userpw=" + userpw + ", username=" + username
				+ ", usernick=" + usernick + ", birth=" + birth + ", gender=" + gender + ", phone=" + phone + ", email="
				+ email + ", penalty=" + penalty + ", myteam=" + myteam + "]";
	}

	public int getUserno() {
		return userno;
	}

	public void setUserno(int userno) {
		this.userno = userno;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getUserpw() {
		return userpw;
	}

	public void setUserpw(String userpw) {
		this.userpw = userpw;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getUsernick() {
		return usernick;
	}

	public void setUsernick(String usernick) {
		this.usernick = usernick;
	}

	public Date getBirth() {
		return birth;
	}

	public void setBirth(Date birth) {
		this.birth = birth;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public int getPenalty() {
		return penalty;
	}

	public void setPenalty(int penalty) {
		this.penalty = penalty;
	}

	public String getMyteam() {
		return myteam;
	}

	public void setMyteam(String myteam) {
		this.myteam = myteam;
	}
}
