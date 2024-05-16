package com.back.guest.service;

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

import com.back.guest.dao.GuestDAO;
import com.back.guest.dto.GuestDTO;

@Service
public class GuestService {
	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired
	GuestDAO guestDAO;

	// 글쓰기
	public int guestWrite(Map<String, Object> map) {
		logger.info("guest-service map={}", map);
		return guestDAO.guestWrite(map);
	}

	// 구장리스트 불러오기
	public List<GuestDTO> courtList(String id) {
		return guestDAO.courtList(id);
	}

	// 아이디에 팀여부 찾기
	public int callmyteam(String id) {
		return guestDAO.callmyteam(id);
	}

	// 수정불러오기
	public Map<String, GuestDTO> guestModify(int guest_idx) {
		Map<String, GuestDTO> map = new HashMap<String, GuestDTO>();
		GuestDTO dto = guestDAO.guestModify(guest_idx);
		logger.info(dto.getCourt_name() + " ");
		map.put("guestInfo", dto);
		return map;
	}

	// 수정하기
	public Map<String, Object> writeUpdate(String guest_info, String guest_level, String guest_position,
			String guest_gender, String guest_to, int guest_fee, String guest_idx) {
		guestDAO.writeUpdate(guest_info, guest_level, guest_position, guest_gender, guest_to, guest_fee, guest_idx);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("result", true);
		return map;
	}

	// 게스트 모집글 리스트 페이지
	public Map<String, Object> guestList(int page, String searchFlag, String searchCategory, String searchWord,
			String address, String gender, String position, String level) {
		// 시작 페이지
		int start = (page - 1) * 10;

		Map<String, Object> map = new HashMap<String, Object>();

		// 모든 리스트
		List<GuestDTO> list = guestDAO.guestList();
		// 가공될 리스트
		List<GuestDTO> processedList = new ArrayList<GuestDTO>();

		// 주소 리스트
		map.put("addressList", addressDeduplication(list));

		// 검색
		if (searchFlag.equals("true") && searchCategory.equals("Address")) { // 지역명 검색
			processedList = addressProcessedListing(list, searchWord);
		} else if (searchFlag.equals("true") && searchCategory.equals("courtName")) {// 구장명 검색
			processedList = nameProcessedListing(list, searchWord);
		} else if (searchFlag.equals("true") && searchCategory.equals("teamName")) {// 팀명 검색
			processedList = teamNameProcessedListing(list, searchWord);
		} else if (address.isEmpty() == false || gender.isEmpty() == false || position.isEmpty() == false
				|| level.isEmpty() == false) { // 필터
			processedList = list;
			if (address.isEmpty() == false) {
				processedList = addressProcessedListing(processedList, address);
			}
			if (gender.isEmpty() == false) {
				processedList = genderProcessedListing(processedList, gender);
			}
			if (position.isEmpty() == false) {
				processedList = positionProcessedListing(processedList, position);
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

	// 구장명 필터 메서드
	public List<GuestDTO> nameProcessedListing(List<GuestDTO> list, String courtName) {
		List<GuestDTO> processedList = new ArrayList<GuestDTO>();
		for (GuestDTO dto : list) {
			if (dto.getCourt_name().contains(courtName)) {
				processedList.add(dto);
			}
		}
		return processedList;
	}

	// 주소 구 단위로 자르고 가나다순 정렬
	public List<String> addressDeduplication(List<GuestDTO> list) {
		Set<String> set = new HashSet<String>();

		for (GuestDTO dto : list) {
			set.add(dto.getCourt_address().split(" ")[1]);
		}
		List<String> DeduplicationList = new ArrayList<String>(set);
		Collections.sort(DeduplicationList);
		return DeduplicationList;
	}

	// 주소 필터 메서드
	public List<GuestDTO> addressProcessedListing(List<GuestDTO> list, String address) {
		List<GuestDTO> processedList = new ArrayList<GuestDTO>();
		for (GuestDTO dto : list) {
			if (dto.getCourt_address().contains(address)) {
				processedList.add(dto);
			}
		}
		return processedList;
	}

	// 팀명 필터 메서드
	public List<GuestDTO> teamNameProcessedListing(List<GuestDTO> list, String teamName) {
		List<GuestDTO> processedList = new ArrayList<GuestDTO>();
		for (GuestDTO dto : list) {
			if (dto.getTeam_name().contains(teamName)) {
				processedList.add(dto);
			}
		}
		return processedList;
	}

	// 성별 필터 메서드
	public List<GuestDTO> genderProcessedListing(List<GuestDTO> list, String gender) {
		List<GuestDTO> processedList = new ArrayList<GuestDTO>();
		for (GuestDTO dto : list) {
			if (dto.getGuest_gender().contains(gender)) {
				processedList.add(dto);
			}
		}
		return processedList;
	}

	// 포지션 필터 메서드
	public List<GuestDTO> positionProcessedListing(List<GuestDTO> list, String position) {
		List<GuestDTO> processedList = new ArrayList<GuestDTO>();
		for (GuestDTO dto : list) {
			if (dto.getGuest_position().contains(position)) {
				processedList.add(dto);
			}
		}
		return processedList;
	}

	// 레벨 필터 메서드
	public List<GuestDTO> levelProcessedListing(List<GuestDTO> list, String level) {
		List<GuestDTO> processedList = new ArrayList<GuestDTO>();
		for (GuestDTO dto : list) {
			if (dto.getGuest_level().contains(level)) {
				processedList.add(dto);
			}
		}
		return processedList;
	}

	// 페이징 처리위해 10개씩만
	public List<GuestDTO> pagingList(List<GuestDTO> processedList, int start) {
		List<GuestDTO> list = new ArrayList<GuestDTO>();
		for (int i = start; i < Math.min(start + 10, processedList.size()); i++) {
			list.add(processedList.get(i));
		}
		return list;
	}

	// 게스트 모집글 상세보기
	public Map<String, Object> detail(String guest_idx) {
		Map<String, Object> map = new HashMap<String, Object>();
		logger.info("guestIdx = "+guest_idx);
		GuestDTO detail = guestDAO.detail(guest_idx);
		List<String> fileName = guestDAO.fileNameList(guest_idx);
		
		map.put("detail", detail);
		map.put("fileName", fileName);
		return map;
	}

	public Map<String, Object> guestJoin(String guest_idx, String id) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			guestDAO.guestJoinListInsert(guest_idx, id);
			guestDAO.guestNoticeInsert(guest_idx);
			map.put("result", true);
		} catch (Exception e) {
			map.put("result", false);			
		}
		return map;
	}
	
	
}



















