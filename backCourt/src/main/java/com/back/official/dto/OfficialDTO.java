package com.back.official.dto;

import java.sql.Date;

public class OfficialDTO {

	// 공식 경기 리스트
	private int official_match_idx;
	private int court_idx;
	private String official_match_gender;
	private String official_match_level;
	private int official_match_to;
	private String official_match_to_state;
	private String official_match_info;
	private int official_match_fee;
	private String official_match_date;
	private String official_match_start_time;
	private String official_match_end_time;
	private String official_match_state;
	private String official_match_post_state;
	
	private String court_address;
	private int currentCount;
	private String court_name;
	private String file_name;
	
	public int getOfficial_match_idx() {
		return official_match_idx;
	}
	public void setOfficial_match_idx(int official_match_idx) {
		this.official_match_idx = official_match_idx;
	}
	public int getCourt_idx() {
		return court_idx;
	}
	public void setCourt_idx(int court_idx) {
		this.court_idx = court_idx;
	}
	public String getOfficial_match_gender() {
		return official_match_gender;
	}
	public void setOfficial_match_gender(String official_match_gender) {
		this.official_match_gender = official_match_gender;
	}
	public String getOfficial_match_level() {
		return official_match_level;
	}
	public void setOfficial_match_level(String official_match_level) {
		this.official_match_level = official_match_level;
	}
	public int getOfficial_match_to() {
		return official_match_to;
	}
	public void setOfficial_match_to(int official_match_to) {
		this.official_match_to = official_match_to;
	}
	public String getOfficial_match_to_state() {
		return official_match_to_state;
	}
	public void setOfficial_match_to_state(String official_match_to_state) {
		this.official_match_to_state = official_match_to_state;
	}
	public String getOfficial_match_info() {
		return official_match_info;
	}
	public void setOfficial_match_info(String official_match_info) {
		this.official_match_info = official_match_info;
	}
	public int getOfficial_match_fee() {
		return official_match_fee;
	}
	public void setOfficial_match_fee(int official_match_fee) {
		this.official_match_fee = official_match_fee;
	}
	public String getOfficial_match_date() {
		return official_match_date;
	}
	public void setOfficial_match_date(String official_match_date) {
		this.official_match_date = official_match_date;
	}
	public String getOfficial_match_start_time() {
		return official_match_start_time;
	}
	public void setOfficial_match_start_time(String official_match_start_time) {
		this.official_match_start_time = official_match_start_time;
	}
	public String getOfficial_match_end_time() {
		return official_match_end_time;
	}
	public void setOfficial_match_end_time(String official_match_end_time) {
		this.official_match_end_time = official_match_end_time;
	}
	public String getOfficial_match_state() {
		return official_match_state;
	}
	public void setOfficial_match_state(String official_match_state) {
		this.official_match_state = official_match_state;
	}
	public String getOfficial_match_post_state() {
		return official_match_post_state;
	}
	public void setOfficial_match_post_state(String official_match_post_state) {
		this.official_match_post_state = official_match_post_state;
	}
	public String getCourt_address() {
		return court_address;
	}
	public void setCourt_address(String court_address) {
		this.court_address = court_address;
	}
	public int getCurrentCount() {
		return currentCount;
	}
	public void setCurrentCount(int currentCount) {
		this.currentCount = currentCount;
	}
	public String getCourt_name() {
		return court_name;
	}
	public void setCourt_name(String court_name) {
		this.court_name = court_name;
	}
	public String getFile_name() {
		return file_name;
	}
	public void setFile_name(String file_name) {
		this.file_name = file_name;
	}
	
	
//	========== 공식 경기 신청 리스트 ==========
	
	private int official_match_ask_idx;
	private String id;
	private String official_match_ask_state;
	private Date official_match_ask_date;
	
	private String time;

	public int getOfficial_match_ask_idx() {
		return official_match_ask_idx;
	}
	public void setOfficial_match_ask_idx(int official_match_ask_idx) {
		this.official_match_ask_idx = official_match_ask_idx;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getOfficial_match_ask_state() {
		return official_match_ask_state;
	}
	public void setOfficial_match_ask_state(String official_match_ask_state) {
		this.official_match_ask_state = official_match_ask_state;
	}
	public Date getOfficial_match_ask_date() {
		return official_match_ask_date;
	}
	public void setOfficial_match_ask_date(Date official_match_ask_date) {
		this.official_match_ask_date = official_match_ask_date;
	}
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	
	
}















