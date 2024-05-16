package com.back.admin.dto;

public class AdminTeamDTO {
	private String logo;
	private String team_name;
	private String team_address;
	private String id;
	private int team_idx;

	private String team_level;
	private String team_info;

	private String teamjang;

	public String getLogo() {
		return logo;
	}

	public void setLogo(String logo) {
		this.logo = logo;
	}

	public String getTeam_name() {
		return team_name;
	}

	public void setTeam_name(String team_name) {
		this.team_name = team_name;
	}

	public String getTeam_address() {
		return team_address;
	}

	public void setTeam_address(String team_address) {
		this.team_address = team_address;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public int getTeam_idx() {
		return team_idx;
	}

	public void setTeam_idx(int team_idx) {
		this.team_idx = team_idx;
	}

	public String getTeam_level() {
		return team_level;
	}

	public void setTeam_level(String team_level) {
		this.team_level = team_level;
	}

	public String getTeam_info() {
		return team_info;
	}

	public void setTeam_info(String team_info) {
		this.team_info = team_info;
	}

	public String getTeamjang() {
		return teamjang;
	}

	public void setTeamjang(String teamjang) {
		this.teamjang = teamjang;
	}

	// team_join
	private int join_team_idx;
	private int join_team_to;
	private String join_team_content;
	private String join_team_level;
	private String join_team_gender;
	private String join_team_position;
	private String join_team_state;

	public int getJoin_team_idx() {
		return join_team_idx;
	}

	public void setJoin_team_idx(int join_team_idx) {
		this.join_team_idx = join_team_idx;
	}

	public int getJoin_team_to() {
		return join_team_to;
	}

	public void setJoin_team_to(int join_team_to) {
		this.join_team_to = join_team_to;
	}

	public String getJoin_team_content() {
		return join_team_content;
	}

	public void setJoin_team_content(String join_team_content) {
		this.join_team_content = join_team_content;
	}

	public String getJoin_team_level() {
		return join_team_level;
	}

	public void setJoin_team_level(String join_team_level) {
		this.join_team_level = join_team_level;
	}

	public String getJoin_team_gender() {
		return join_team_gender;
	}

	public void setJoin_team_gender(String join_team_gender) {
		this.join_team_gender = join_team_gender;
	}

	public String getJoin_team_position() {
		return join_team_position;
	}

	public void setJoin_team_position(String join_team_position) {
		this.join_team_position = join_team_position;
	}

	public String getJoin_team_state() {
		return join_team_state;
	}

	public void setJoin_team_state(String join_team_state) {
		this.join_team_state = join_team_state;
	}
	
}






















