package com.back.guest.dto;

public class GuestDTO {
	
	// 게스트 글작성
	private int guest_idx;
	private String id;
	private int court_booking_idx;
	private int team_idx;
	private String guest_position;
	private String guest_level;
	private String guest_gender;
	private int guest_to;
	private String guest_info;
	private int guest_fee;
	private String guest_state;
	// 구장찾기
	private int court_idx;
	private String booking_date;
	private String booking_start_time;
	private String booking_end_time;
	private String booking_state;
	private String bookingDate;
	private String court_name;
	private String court_address;
	// 게스트 모집리스트
	private String team_name;
	// 게스트 상세페이지 구장사진
	private String file_name;
	
	
	public int getGuest_idx() {
		return guest_idx;
	}
	public void setGuest_idx(int guest_idx) {
		this.guest_idx = guest_idx;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public int getCourt_booking_idx() {
		return court_booking_idx;
	}
	public void setCourt_booking_idx(int court_booking_idx) {
		this.court_booking_idx = court_booking_idx;
	}
	public int getTeam_idx() {
		return team_idx;
	}
	public void setTeam_idx(int team_idx) {
		this.team_idx = team_idx;
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
	
	
	
	public String getCourt_name() {
		return court_name;
	}
	public void setCourt_name(String court_name) {
		this.court_name = court_name;
	}
	public String getCourt_address() {
		return court_address;
	}
	public void setCourt_address(String court_address) {
		this.court_address = court_address;
	}
	public String getBookingDate() {
		return bookingDate;
	}
	public void setBookingDate(String bookingDate) {
		this.bookingDate = bookingDate;
	}
	public int getCourt_idx() {
		return court_idx;
	}
	public void setCourt_idx(int court_idx) {
		this.court_idx = court_idx;
	}
	public String getBooking_date() {
		return booking_date;
	}
	public void setBooking_date(String booking_date) {
		this.booking_date = booking_date;
	}
	public String getBooking_start_time() {
		return booking_start_time;
	}
	public void setBooking_start_time(String booking_start_time) {
		this.booking_start_time = booking_start_time;
	}
	public String getBooking_end_time() {
		return booking_end_time;
	}
	public void setBooking_end_time(String booking_end_time) {
		this.booking_end_time = booking_end_time;
	}
	public String getBooking_state() {
		return booking_state;
	}
	public void setBooking_state(String booking_state) {
		this.booking_state = booking_state;
	}
	public String getTeam_name() {
		return team_name;
	}
	public void setTeam_name(String team_name) {
		this.team_name = team_name;
	}
	public String getFile_name() {
		return file_name;
	}
	public void setFile_name(String file_name) {
		this.file_name = file_name;
	}
	
}
