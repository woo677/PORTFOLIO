package com.back.guest.dao;

import java.util.List;
import java.util.Map;

import com.back.guest.dto.GuestDTO;

public interface GuestDAO {

	int guestWrite(Map<String, Object> map);

	List<GuestDTO> courtList(String id);

	int callmyteam(String id);

	GuestDTO guestModify(int guest_idx); 

	void writeUpdate(String guest_info, String guest_level, String guest_position, String guest_gender,
			String guest_to, int guest_fee, String guest_idx);

	List<GuestDTO> guestList();

	GuestDTO detail(String guest_idx);

	List<String> fileNameList(String guest_idx);

	void guestJoinListInsert(String guest_idx, String id);

	void guestNoticeInsert(String guest_idx);


}
