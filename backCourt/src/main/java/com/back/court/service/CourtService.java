package com.back.court.service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.back.court.dao.CourtDAO;
import com.back.court.dto.CourtDTO;

@Service
public class CourtService {

	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired
	CourtDAO courtDAO;

	public Map<String, Object> list(Map<String, Object> param) {
		// 시작 페이지
		int start = (Integer.parseInt((String) param.get("currentPage")) - 1) * 10;
		
		param.put("start", start);

		Map<String, Object> map = new HashMap<String, Object>();

		// 리스트
		map.put("list", courtDAO.list(param));
		// 주소 리스트
		map.put("addressList", processedAddress(courtDAO.addressList()));
		// 총 페이지
		int totalPage = courtDAO.totalPage(param);
		
		if (totalPage / 10 == 0) {
			totalPage = 1;
		} else if (totalPage % 10 > 0) {
			totalPage = totalPage / 10 + 1;
		} else {
			totalPage = totalPage / 10;
		}
		
		map.put("totalPage", totalPage);

		return map;
	}

	// 주소 구 단위로 자르고 가나다순 정렬
	public List<String> processedAddress(List<String> list) {
		List<String> processedList = new ArrayList<String>();
		for (String address : list) {
			if (address.contains(" ")) {
				processedList.add(address.split(" ")[1]);
			}
		}
		return processedList;
	}

	public boolean jjim(String id, int courtIdx) {
		try {
			courtDAO.jjim(id, courtIdx);
		} catch (Exception e) {
			return false;
		}
		return true;
	}

	public Boolean jjimRemove(String id, int courtIdx) {
		try {
			courtDAO.jjimRemove(id, courtIdx);
		} catch (Exception e) {
			return false;
		}
		return true;
	}

	public Map<String, Object> detail(String courtIdx, String selectDate) {
		Map<String, Object> map = new HashMap<String, Object>();
		logger.info("선택된 날짜 = " + selectDate);
		logger.info("courtIdx = " + courtIdx);
		List<CourtDTO> detail = courtDAO.detail(courtIdx);
		List<String> fileName = courtDAO.fileNameList(courtIdx);
		List<String> bookingStartTime = courtDAO.bookingStartTimeList(courtIdx, selectDate);
		for (String string : bookingStartTime) {
			logger.info(string);
		}
		map.put("detail", detail);
		map.put("fileName", fileName);
		map.put("bookingStartTime", bookingStartTime);

		return map;
	}

	public Map<String, Boolean> booking(String courtStartTime, String courtIdx, String courtPrice, String id,
			String courtDate) {
		Map<String, Boolean> map = new HashMap<String, Boolean>();
		int courtBookingPrice = Integer.parseInt(courtPrice);
		int myPoint = courtDAO.myPoint(id);
		logger.info(myPoint + " " + courtBookingPrice);

		map.put("money", true);
		map.put("result", true);
		if (courtBookingPrice > myPoint) {
			map.put("money", false);
			return map;
		}
		logger.info(courtDAO.duplicateCheckBooking(courtDate, courtStartTime, courtIdx) + "일정체크 courtDate =" + courtDate
				+ " courtStartTime" + courtStartTime);
		if (courtDAO.duplicateCheckBooking(courtDate, courtStartTime, courtIdx) > 0) {
			map.put("result", false);
			return map;
		}

		int courtEndTime = Integer.parseInt(courtStartTime) + 2;
		Map<String, Object> insertMap = new HashMap<String, Object>();

		insertMap.put("id", id);
		insertMap.put("court_idx", Integer.parseInt(courtIdx));
		insertMap.put("booking_date", courtDate);
		insertMap.put("booking_start_time", Integer.parseInt(courtStartTime));
		insertMap.put("booking_end_time", courtEndTime);
		insertMap.put("booking_state", "true");
		insertMap.put("point_change", courtBookingPrice);
		insertMap.put("point_state", "예약");
		insertMap.put("write_idx", courtIdx);
		insertMap.put("write_type", "구장예약");

		bookingAndPaying(insertMap);

		return map;
	}
	
	public void bookingAndPaying(Map<String, Object> insertMap) {
		try {
			courtDAO.insertBooking(insertMap);
			courtDAO.insertPointHistory(insertMap);
			courtDAO.updateUserPoint(insertMap);
		} catch (Exception e) {
			logger.error("insert 실패", e);
			throw new RuntimeException("insert 실패");
		}
	}

}
