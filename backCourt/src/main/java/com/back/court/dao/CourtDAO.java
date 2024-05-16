package com.back.court.dao;

import java.util.List;
import java.util.Map;

import com.back.court.dto.CourtDTO;

public interface CourtDAO {

	void jjim(String id, int courtIdx);

	void jjimRemove(String id, int courtIdx);

	List<CourtDTO> detail(String courtIdx);

	List<String> fileNameList(String courtIdx);

	List<String> bookingStartTimeList(String courtIdx, String selectDate);

	int duplicateCheckBooking(String courtDate, String courtStartTime, String courtIdx);

	int myPoint(String id);

	void insertBooking(Map<String, Object> insertMap);

	void insertPointHistory(Map<String, Object> insertMap);

	List<String> addressList();

	int totalPage(Map<String, Object> param);

	List<CourtDTO> list(Map<String, Object> param);

	void updateUserPoint(Map<String, Object> insertMap);
}
