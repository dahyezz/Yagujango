package dto;

import oracle.sql.DATE;

public class Match {
	private int match_code;
	private DATE match_date;
	private int hometeam_code;
	private int awayteam_code;
	private String highlight;
	
	@Override
	public String toString() {
		return "Match [match_code=" + match_code + ", match_date=" + match_date + ", hometeam_code=" + hometeam_code
				+ ", awayteam_code=" + awayteam_code + ", highlight=" + highlight + "]";
	}

	public int getMatch_code() {
		return match_code;
	}

	public void setMatch_code(int match_code) {
		this.match_code = match_code;
	}

	public DATE getMatch_date() {
		return match_date;
	}

	public void setMatch_date(DATE match_date) {
		this.match_date = match_date;
	}

	public int getHometeam_code() {
		return hometeam_code;
	}

	public void setHometeam_code(int hometeam_code) {
		this.hometeam_code = hometeam_code;
	}

	public int getAwayteam_code() {
		return awayteam_code;
	}

	public void setAwayteam_code(int awayteam_code) {
		this.awayteam_code = awayteam_code;
	}

	public String getHighlight() {
		return highlight;
	}

	public void setHighlight(String highlight) {
		this.highlight = highlight;
	}
	
	
}