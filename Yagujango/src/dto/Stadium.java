package dto;

public class Stadium {
	private int stadium_code;
	private String stadium_name;
	private String stadium_logo;
	private String team_name;

	@Override
	public String toString() {
		return "Stadium [stadium_code=" + stadium_code + ", stadium_name=" + stadium_name + ", stadium_logo="
				+ stadium_logo + ", team_name=" + team_name + "]";
	}

	public int getStadium_code() {
		return stadium_code;
	}

	public void setStadium_code(int stadium_code) {
		this.stadium_code = stadium_code;
	}

	public String getStadium_name() {
		return stadium_name;
	}

	public void setStadium_name(String stadium_name) {
		this.stadium_name = stadium_name;
	}

	public String getStadium_logo() {
		return stadium_logo;
	}

	public void setStadium_logo(String stadium_logo) {
		this.stadium_logo = stadium_logo;
	}

	public String getTeam_name() {
		return team_name;
	}

	public void setTeam_name(String team_name) {
		this.team_name = team_name;
	}
	
	
}