package com.back.admin.dto;

import java.sql.Date;

public class AdminMemberDTO {
	
	private String id;
	private String pw;
	private String address;
	private String gender;
	private String position;
	private String level;
	private String perm;
	private int point;
	private String state;
	private String name;

	private int point_idx;
	private Date point_date;
	private int point_change;
	private String point_state;
	private int write_idx;
	private String write_type;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
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
	public String getPosition() {
		return position;
	}
	public void setPosition(String position) {
		this.position = position;
	}
	public String getLevel() {
		return level;
	}
	public void setLevel(String level) {
		this.level = level;
	}
	public String getPerm() {
		return perm;
	}
	public void setPerm(String perm) {
		this.perm = perm;
	}
	public int getPoint() {
		return point;
	}
	public void setPoint(int point) {
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
	public int getPoint_idx() {
		return point_idx;
	}
	public void setPoint_idx(int point_idx) {
		this.point_idx = point_idx;
	}
	public Date getPoint_date() {
		return point_date;
	}
	public void setPoint_date(Date point_date) {
		this.point_date = point_date;
	}
	public int getPoint_change() {
		return point_change;
	}
	public void setPoint_change(int point_change) {
		this.point_change = point_change;
	}
	public String getPoint_state() {
		return point_state;
	}
	public void setPoint_state(String point_state) {
		this.point_state = point_state;
	}
	public int getWrite_idx() {
		return write_idx;
	}
	public void setWrite_idx(int write_idx) {
		this.write_idx = write_idx;
	}
	public String getWrite_type() {
		return write_type;
	}
	public void setWrite_type(String write_type) {
		this.write_type = write_type;
	}
	
	

}