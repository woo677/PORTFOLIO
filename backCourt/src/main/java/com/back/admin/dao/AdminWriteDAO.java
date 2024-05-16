package com.back.admin.dao;

import java.util.List;
import java.util.Map;

import com.back.admin.dto.AdminCourtDTO;
import com.back.admin.dto.AdminWriteDTO;

public interface AdminWriteDAO {

	List<AdminCourtDTO> callCourtList();

	List<AdminWriteDTO> officialList();

	AdminCourtDTO callCourtInfo(String courtIdx);

	List<String> fileNameList(String courtIdx);

	List<String> bookingStartTime(String courtIdx, String selectDate);

	Boolean officialWrite(Map<String, Object> param);

	AdminWriteDTO officialUpdateGo(String officialIdx);

	Boolean officialUpdate(Map<String, Object> param);

	List<AdminWriteDTO> teamList(Map<String, Object> param);

	List<String> addressList();

	int totalPage(Map<String, Object> param);

	List<AdminWriteDTO> guestList(Map<String, Object> param);

	List<String> addressListGuest();

	int totalPageGuest(Map<String, Object> param);
	
	// 게스트 모집글 수정
	AdminWriteDTO guestUpdateGo(String guestIdx);

	List<AdminCourtDTO> callGuestCourtList();

	AdminCourtDTO callGuestCourtInfo(String courtIdx);

	List<String> bookingStartTimeGuest(String courtIdx, String selectDate);

	Boolean guestUpdate(Map<String, Object> param);

	Boolean guestUpdateCourt(Map<String, Object> param);


}








