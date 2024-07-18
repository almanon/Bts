package com.human.bts.vo;


public class GameVO {
	private String game_day, game_time, home, away, stadium, weekday, crowd, startLoc;
	private int rno;
	
	

	public String getStartLoc() {
		return startLoc;
	}

	public void setStartLoc(String startLoc) {
		this.startLoc = startLoc;
	}

	public String getCrowd() {
		return crowd;
	}

	public void setCrowd(String crowd) {
		this.crowd = crowd;
	}

	public int getRno() {
		return rno;
	}

	public void setRno(int rno) {
		this.rno = rno;
	}

	public String getGame_day() {
		return game_day;
	}

	public void setGame_day(String game_day) {
		this.game_day = game_day;
	}

	public String getGame_time() {
		return game_time;
	}

	public void setGame_time(String game_time) {
		this.game_time = game_time;
	}

	public String getHome() {
		return home;
	}

	public void setHome(String home) {
		this.home = home;
	}

	public String getAway() {
		return away;
	}

	public void setAway(String away) {
		this.away = away;
	}

	public String getStadium() {
		return stadium;
	}

	public void setStadium(String stadium) {
		this.stadium = stadium;
	}

	public String getWeekday() {
		return weekday;
	}

	public void setWeekday(String weekday) {
		this.weekday = weekday;
	}

	@Override
	public String toString() {
		return "GameVO [game_day=" + game_day + ", game_time=" + game_time + ", home=" + home + ", away=" + away
				+ ", stadium=" + stadium + ", weekday=" + weekday + ", rno=" + rno + "]";
	}


	
	
	
	
}
