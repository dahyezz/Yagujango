package dto;

import java.util.Date;

public class Match {
	private int match_code;
	private int hometeam_code;
	private Date match_date;
	private String hometeam_name;
	private String awayteam_name;
	private String highlight;
	
	@Override
	public String toString() {
		return "Match [match_code=" + match_code + ", hometeam_code=" + hometeam_code + ", match_date=" + match_date
				+ ", hometeam_name=" + hometeam_name + ", awayteam_name=" + awayteam_name + ", highlight=" + highlight
				+ "]";
	}

	public int getMatch_code() {
		return match_code;
	}

	public void setMatch_code(int match_code) {
		this.match_code = match_code;
	}

	public int getHometeam_code() {
		return hometeam_code;
	}

	public void setHometeam_code(int hometeam_code) {
		this.hometeam_code = hometeam_code;
	}

	public Date getMatch_date() {
		return match_date;
	}

	public void setMatch_date(Date match_date) {
		this.match_date = match_date;
	}

	public String getHometeam_name() {
		return hometeam_name;
	}

	public void setHometeam_name(String hometeam_name) {
		this.hometeam_name = hometeam_name;
	}

	public String getAwayteam_name() {
		return awayteam_name;
	}

	public void setAwayteam_name(String awayteam_name) {
		this.awayteam_name = awayteam_name;
	}

	public String getHighlight() {
		return highlight;
	}

	public void setHighlight(String highlight) {
		this.highlight = highlight;
	}
	
	
	
	
	
	
}