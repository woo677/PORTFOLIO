package com.back.header.dto;

import java.sql.Date;

public class HeaderDTO {

	// team popup
	private int team_idx;
	private String id;
	private String logo;
	private String team_name;
	private String team_address;
	private String team_level;
	private String team_info;
	
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
	
	// notice
	private int notice_idx;
	private String notice_content;
	private Date notice_time;
	private int notice_count;

	public int getNotice_idx() {
		return notice_idx;
	}
	public void setNotice_idx(int notice_idx) {
		this.notice_idx = notice_idx;
	}
	public String getNotice_content() {
		return notice_content;
	}
	public void setNotice_content(String notice_content) {
		this.notice_content = notice_content;
	}
	public Date getNotice_time() {
		return notice_time;
	}
	public void setNotice_time(Date notice_time) {
		this.notice_time = notice_time;
	}
	public int getNotice_count() {
		return notice_count;
	}
	public void setNotice_count(int notice_count) {
		this.notice_count = notice_count;
	}
	
	
}
























