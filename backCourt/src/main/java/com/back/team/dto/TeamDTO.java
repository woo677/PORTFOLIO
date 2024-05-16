package com.back.team.dto;

import java.sql.Date;

public class TeamDTO {

	// team
	private int team_idx;
	private String id;
	private String logo;
	private String team_name;
	private String team_address;
	private String team_level;
	private String team_info;
	
	private int teamCount;
	
	public int getTeam_idx() {
		return team_idx;
	}
	public void setTeam_idx(int team_idx) {
		this.team_idx = team_idx;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
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
	public int getTeamCount() {
		return teamCount;
	}
	public void setTeamCount(int teamCount) {
		this.teamCount = teamCount;
	}
	
	// team_list
	private Date team_date;

	public Date getTeam_date() {
		return team_date;
	}
	public void setTeam_date(Date team_date) {
		this.team_date = team_date;
	}
	
	// team_join_list
	private int applicant_idx;
	private int join_team_idx;
	private String join_state;
	private Date join_date;
	
	private String level;
	private String position;

	public int getApplicant_idx() {
		return applicant_idx;
	}
	public void setApplicant_idx(int applicant_idx) {
		this.applicant_idx = applicant_idx;
	}
	public int getJoin_team_idx() {
		return join_team_idx;
	}
	public void setJoin_team_idx(int join_team_idx) {
		this.join_team_idx = join_team_idx;
	}
	public String getJoin_state() {
		return join_state;
	}
	public void setJoin_state(String join_state) {
		this.join_state = join_state;
	}
	public Date getJoin_date() {
		return join_date;
	}
	public void setJoin_date(Date join_date) {
		this.join_date = join_date;
	}
	public String getLevel() {
		return level;
	}
	public void setLevel(String level) {
		this.level = level;
	}
	public String getPosition() {
		return position;
	}
	public void setPosition(String position) {
		this.position = position;
	}
	
	// team_join
	private int join_team_to;
	private String join_team_content;
	private String join_team_level;
	private String join_team_gender;
	private String join_team_position;
	private String join_team_state;

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
	
	// guest_join
	private int guest_idx;
	private int court_booking_idx;
	private String guest_position;
	private String guest_level;
	private String guest_gender;
	private int guest_to;
	private String guest_info;
	private int guest_fee;
	private String guest_state;

	public int getGuest_idx() {
		return guest_idx;
	}
	public void setGuest_idx(int guest_idx) {
		this.guest_idx = guest_idx;
	}
	public int getCourt_booking_idx() {
		return court_booking_idx;
	}
	public void setCourt_booking_idx(int court_booking_idx) {
		this.court_booking_idx = court_booking_idx;
	}
	public String getGuest_position() {
		return guest_position;
	}
	public void setGuest_position(String guest_position) {
		this.guest_position = guest_position;
	}
	public String getGuest_level() {
		return guest_level;
	}
	public void setGuest_level(String guest_level) {
		this.guest_level = guest_level;
	}
	public String getGuest_gender() {
		return guest_gender;
	}
	public void setGuest_gender(String guest_gender) {
		this.guest_gender = guest_gender;
	}
	public int getGuest_to() {
		return guest_to;
	}
	public void setGuest_to(int guest_to) {
		this.guest_to = guest_to;
	}
	public String getGuest_info() {
		return guest_info;
	}
	public void setGuest_info(String guest_info) {
		this.guest_info = guest_info;
	}
	public int getGuest_fee() {
		return guest_fee;
	}
	public void setGuest_fee(int guest_fee) {
		this.guest_fee = guest_fee;
	}
	public String getGuest_state() {
		return guest_state;
	}
	public void setGuest_state(String guest_state) {
		this.guest_state = guest_state;
	}
	
	// team_quit
	private String team_ban;

	public String getTeam_ban() {
		return team_ban;
	}
	public void setTeam_ban(String team_ban) {
		this.team_ban = team_ban;
	}
	
	// member
	private String pw;
	private String address;
	private String gender;
	private String perm;
	private String point;
	private String state;
	private String name;

	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getPerm() {
		return perm;
	}
	public void setPerm(String perm) {
		this.perm = perm;
	}
	public String getPoint() {
		return point;
	}
	public void setPoint(String point) {
		this.point = point;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	
	
}





















