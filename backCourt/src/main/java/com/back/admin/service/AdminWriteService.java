package com.back.admin.service;

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
import org.springframework.ui.Model;

import com.back.admin.dao.AdminWriteDAO;
import com.back.admin.dto.AdminCourtDTO;
import com.back.admin.dto.AdminWriteDTO;

@Service
public class AdminWriteService {

	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired
	AdminWriteDAO adminWriteDAO;

	public Map<String, Object> callCourtList(int currentPage, String searchWord) {
		int start = (currentPage - 1) * 10;
		logger.info("::::::::::::callCourtList service in:::::::::::::");
		logger.info("searchWord = " + searchWord);
		Map<String, Object> result = new HashMap<String, Object>();

		List<AdminCourtDTO> list = adminWriteDAO.callCourtList();
		List<AdminCourtDTO> processedList = new ArrayList<AdminCourtDTO>();

		processedList = list;

		if (searchWord.isEmpty() == false) {
			processedList = addressProcessedList(processedList, searchWord);
		}
		for (AdminCourtDTO adminCourtDTO : processedList) {
			logger.info("processedList Address = " + adminCourtDTO.getCourtAddress());
		}
		int totalPage = processedList.size() % 10 > 0 ? processedList.size() / 10 + 1 : processedList.size() / 10;
		result.put("totalPage", totalPage);

		processedList = pagingList2(processedList, start);
		result.put("list", processedList);

		logger.info("::::::::::::callCourtList service out:::::::::::::");
		return result;
	}

	// official 리스트
	public Map<String, Object> officialList(int page, String searchFlag, String searchWord, String address, String level) {

		// 시작 페이지
		int start = (page - 1) * 10;

		Map<String, Object> map = new HashMap<String, Object>();
		
		// 모든 리스트
		List<AdminWriteDTO> list = adminWriteDAO.officialList();
		// 가공될 리스트
		List<AdminWriteDTO> processedList = new ArrayList<AdminWriteDTO>();
		
		// 주소 리스트
		map.put("addressList", addressDeduplication(list));
		
		// 검색
		if (searchFlag.equals("true")) { // 지역명 검색
			processedList = addressProcessedListing(list, searchWord);
		} else if (address.isEmpty() == false || level.isEmpty() == false) { // 필터
			processedList = list;
			if (address.isEmpty() == false) {
				processedList = addressProcessedListing(processedList, address);
			}
			if (level.isEmpty() == false) {
				processedList = levelProcessedListing(processedList, level);
			}
		} else { // 기본
			processedList = list;
		}
		
		// 리스트에 추가
		map.put("list", pagingList(processedList, start));
		
		int totalPage = processedList.size() % 10 > 0 ? processedList.size() / 10 + 1 : processedList.size() / 10;
		// 총 페이지
		map.put("totalPage", totalPage);
		
		return map;
	}
	
	// 주소 구 단위로 자르고 가나다순 정렬
	public List<String> addressDeduplication(List<AdminWriteDTO> list) {
		Set<String> set = new HashSet<String>();

		for (AdminWriteDTO dto : list) {
			set.add(dto.getCourt_address().split(" ")[1]);
		}
		List<String> DeduplicationList = new ArrayList<String>(set);
		Collections.sort(DeduplicationList);
		return DeduplicationList;
	}
	
	// 주소 필터 메서드
	public List<AdminWriteDTO> addressProcessedListing(List<AdminWriteDTO> list, String address) {
		List<AdminWriteDTO> processedList = new ArrayList<AdminWriteDTO>();
		for (AdminWriteDTO dto : list) {
			if (dto.getCourt_address().contains(address)) {
				processedList.add(dto);
			}
		}
		return processedList;
	}
	
	// 레벨 필터 메서드
	public List<AdminWriteDTO> levelProcessedListing(List<AdminWriteDTO> list, String level) {
		List<AdminWriteDTO> processedList = new ArrayList<AdminWriteDTO>();
		for (AdminWriteDTO dto : list) {
			if (dto.getOfficial_match_level().contains(level)) {
				processedList.add(dto);
			}
		}
		return processedList;
	}
	
	// 페이징 처리위해 10개씩만
	public List<AdminWriteDTO> pagingList(List<AdminWriteDTO> processedList, int start) {
		List<AdminWriteDTO> list = new ArrayList<AdminWriteDTO>();
		for (int i = start; i < Math.min(start + 10, processedList.size()); i++) {
			list.add(processedList.get(i));
		}
		return list;
	}

	private List<AdminCourtDTO> pagingList2(List<AdminCourtDTO> processedList, int start) {
		List<AdminCourtDTO> list = new ArrayList<AdminCourtDTO>();

		for (int i = start; i < Math.min(start + 10, processedList.size()); i++) {
			list.add(processedList.get(i));
		}
		return list;
	}

	public List<AdminCourtDTO> addressProcessedList(List<AdminCourtDTO> processedList, String searchWord) {
		List<AdminCourtDTO> list = new ArrayList<AdminCourtDTO>();
		logger.info("addressProcessedList searchWord = " + searchWord);
		for (AdminCourtDTO dto : processedList) {
			if (dto.getCourtAddress().contains(searchWord)) {
				list.add(dto);
			}
		}
		for (AdminCourtDTO adminCourtDTO : list) {
			logger.info("list address = " + adminCourtDTO.getCourtAddress());
		}
		return list;
	}

	public Map<String, Object> callCourtInfo(String courtIdx, String selectDate) {
		logger.info("callCourtInfo service in :::::::::::::::::");
		logger.info("courtIdx = " + courtIdx);
		logger.info("selectDate = " + selectDate);
		logger.info("callCourtInfo service in :::::::::::::::::");
		Map<String, Object> result = new HashMap<String, Object>();
		AdminCourtDTO dto = adminWriteDAO.callCourtInfo(courtIdx);

		List<String> fileName = adminWriteDAO.fileNameList(courtIdx);
		List<String> bookingStartTime = adminWriteDAO.bookingStartTime(courtIdx, selectDate);
		result.put("fileName", fileName);
		result.put("courtInfo", dto);
		for (String string : bookingStartTime) {
			logger.info("bookingStartTime = " + string);
		}
		result.put("bookingStartTime", bookingStartTime);
		return result;
	}

	public Map<String, Boolean> officialWrite(Map<String, Object> param) {
		int startTime = Integer.parseInt((String) param.get("officialStartTime"));

		param.put("officialEndTime", startTime + 2);
		logger.info("params: {}", param);
		Map<String, Boolean> result = new HashMap<String, Boolean>();
		result.put("result", adminWriteDAO.officialWrite(param));
		return result;
	}

	public void officialUpdateGo(Model model, String officialIdx) {

		AdminWriteDTO dto = adminWriteDAO.officialUpdateGo(officialIdx);
		model.addAttribute("officialInfo", dto);
	}

	public Map<String, Boolean> officialUpdate(Map<String, Object> param) {
		Map<String, Boolean> result = new HashMap<String, Boolean>();
		result.put("result", adminWriteDAO.officialUpdate(param));
		return result;
	}

	// 팀 리스트
	public Map<String, Object> teamList(Map<String, Object> param) {
		// 시작 페이지
		int start = (Integer.parseInt((String) param.get("currentPage")) - 1) * 10;
		
		param.put("start", start);		
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		// 리스트
		map.put("list", adminWriteDAO.teamList(param));
		// 주소 리스트
		map.put("addressList", processedAddress(adminWriteDAO.addressList()));
		// 총 페이지
		int totalPage = adminWriteDAO.totalPage(param);
		map.put("totalPage", totalPage % 10 > 0 ? totalPage / 10 + 1 : totalPage / 10);
		
		return map;
	}

	public Map<String, Object> guestList(Map<String, Object> param) {
		// 시작 페이지
		int start = (Integer.parseInt((String) param.get("currentPage")) - 1) * 10;
		
		param.put("start", start);		
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		// 리스트
		map.put("list", adminWriteDAO.guestList(param));
		// 주소 리스트
		map.put("addressList", processedAddress(adminWriteDAO.addressListGuest()));
		// 총 페이지
		int totalPage = adminWriteDAO.totalPageGuest(param);
		logger.info(String.valueOf(totalPage));
		map.put("totalPage", totalPage % 10 > 0 ? totalPage / 10 + 1 : totalPage / 10);
		
		return map;
	}
	
	// (팀 리스트, 게스트 리스트) 주소 구 단위로 자르고 가나다순 정렬
	public List<String> processedAddress(List<String> list) {
		List<String> processedList = new ArrayList<String>();
		for (String address : list) {
			if (address.contains(" ")) {
				processedList.add(address.split(" ")[1]);
			}
		}
		Collections.sort(processedList);
		return processedList;
	}

	// 게스트 모집글 수정 이동
	public void guestUpdateGo(Model model, String guestIdx) {
		AdminWriteDTO dto = adminWriteDAO.guestUpdateGo(guestIdx);
		model.addAttribute("officialInfo", dto);
		
	}

	// 게스트 모집글 수정 - 코트 리스트
	public Map<String, Object> callGuestCourtList(int currentPage, String searchWord) {
		int start = (currentPage - 1) * 10;
		logger.info("::::::::::::callCourtList service in:::::::::::::");
		logger.info("searchWord = " + searchWord);
		Map<String, Object> result = new HashMap<String, Object>();

		List<AdminCourtDTO> list = adminWriteDAO.callGuestCourtList();
		List<AdminCourtDTO> processedList = new ArrayList<AdminCourtDTO>();

		processedList = list;

		if (searchWord.isEmpty() == false) {
			processedList = addressProcessedList(processedList, searchWord);
		}
		for (AdminCourtDTO adminCourtDTO : processedList) {
			logger.info("processedList Address = " + adminCourtDTO.getCourtAddress());
		}
		int totalPage = processedList.size() % 10 > 0 ? processedList.size() / 10 + 1 : processedList.size() / 10;
		result.put("totalPage", totalPage);

		processedList = pagingList2(processedList, start);
		result.put("list", processedList);

		logger.info("::::::::::::callCourtList service out:::::::::::::");
		return result;
	}

	// 게스트 모집글 수정 - 코트 정보
	public Map<String, Object> callGuestCourtInfo(String courtIdx, String selectDate) {
		logger.info("callCourtInfo service in :::::::::::::::::");
		logger.info("courtIdx = " + courtIdx);
		logger.info("selectDate = " + selectDate);
		logger.info("callCourtInfo service in :::::::::::::::::");
		Map<String, Object> result = new HashMap<String, Object>();
		AdminCourtDTO dto = adminWriteDAO.callGuestCourtInfo(courtIdx);

		List<String> fileName = adminWriteDAO.fileNameList(courtIdx);
		List<String> bookingStartTime = adminWriteDAO.bookingStartTimeGuest(courtIdx, selectDate);
		result.put("fileName", fileName);
		result.put("courtInfo", dto);
		for (String string : bookingStartTime) {
			logger.info("bookingStartTime = " + string);
		}
		result.put("bookingStartTime", bookingStartTime);
		return result;
	}

	// 게스트 모집글 - 게스트 모집글 - 업데이트 실행
	public Map<String, Boolean> guestUpdate(Map<String, Object> param) {
		Map<String, Boolean> result = new HashMap<String, Boolean>();
		result.put("result", adminWriteDAO.guestUpdate(param));
		result.put("result2", adminWriteDAO.guestUpdateCourt(param));
		return result;
	}

}






















