package com.back.admin.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.back.admin.dao.AdminMemberDAO;
import com.back.admin.dto.AdminMemberDTO;

@Service
public class AdminMemberService {

	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired
	AdminMemberDAO memberDAO;

	public Map<String, Object> list(int page, String state) {
		Map<String, Object> result = new HashMap<String, Object>();
		List<AdminMemberDTO> list;
		List<AdminMemberDTO> allList = memberDAO.allList();

		int start = (page - 1) * 10;

		if (state.equals("") == true) {
			logger.info("1");
			list = memberDAO.list(start);
			result.put("totalPage", memberDAO.allStateCount() % 10 > 0 ? memberDAO.allStateCount() / 10 + 1
					: memberDAO.allStateCount() / 10);
		} else {
			logger.info("2");
			list = memberDAO.listFilterState(start, state);
			result.put("totalPage",
					memberDAO.filteringStateCount(state) % 10 > 0 ? memberDAO.filteringStateCount(state) / 10 + 1
							: memberDAO.filteringStateCount(state) / 10);
		}

		result.put("list", list);
		result.put("allList", allList);
		return result;

	}

	public Map<String, Object> searchList(int page, String state, String memberSearchWord) {

		Map<String, Object> result = new HashMap<String, Object>();
		List<AdminMemberDTO> list;
		List<AdminMemberDTO> allList = memberDAO.allList();

		int start = (page - 1) * 10;

		list = memberDAO.idSearchList(memberSearchWord, start);
		logger.info("멤버 아이디 서치리스트 ");
		result.put("totalPage", memberDAO.searchMemberIdCount(memberSearchWord));

		result.put("list", list);
		result.put("allList", allList);
		return result;
	}

	public void detailLoad(String memberId, Model model) {
		logger.info("memberDetailLoad Service in ---------------------------------");
		model.addAttribute("memberDetail", memberDAO.detailLoad(memberId));
		model.addAttribute("memberId", memberId);
		logger.info("memberDetailLoad Service out --------------------------------");
	}

	public Map<String, AdminMemberDTO> memberDetail(String memberId) {
		Map<String, AdminMemberDTO> map = new HashMap<String, AdminMemberDTO>();
		AdminMemberDTO dto = memberDAO.memberDetail(memberId);
		map.put("m", dto);
		return map;
	}

	public Map<String, Object> writeUpdate(String memberName, String memberPass, String memberLevel,
			String memberAddress, String memberGender, String memberPosition, String memberState, String memberId) {
		logger.info("writeUpdate service memberId=" + memberId);
		memberDAO.writeUpdate(memberName, memberPass, memberLevel, memberAddress, memberGender, memberPosition,
				memberState, memberId);
		Map<String, Object> map = new HashMap<String, Object>();

		map.put("result", true);
		return map;
	}

	public void pointDetail(Model model, String id) {
		logger.info("포인트내역 Service in --------------------------------- id = " + id);
		List<AdminMemberDTO> list = memberDAO.pointDetail(id);
		for (AdminMemberDTO adminMemberDTO : list) {
			logger.info("리스트 포인트 point_idx = " + adminMemberDTO.getPoint_idx());
		}
		model.addAttribute("p", list);
		logger.info("param = {}", memberDAO.pointDetail(id));
		model.addAttribute("m", memberDAO.memberPoint(id));
		model.addAttribute("id", id);
		logger.info("포인트내역 Service out --------------------------------");

	}

	public Map<String, Object> pointPage(int page) {
		Map<String, Object> result = new HashMap<String, Object>();
		List<AdminMemberDTO> pointList;
		List<AdminMemberDTO> pointAllList = memberDAO.pointAllList();

		int start = (page - 1) * 10;

		logger.info("포인트 페이징 서비스 들어감");
		pointList = memberDAO.pointList(start);
		result.put("totalPage", memberDAO.pointAllCount() % 10 > 0 ? memberDAO.pointAllCount() / 10 + 1
				: memberDAO.pointAllCount() / 10);
		result.put("pointList", pointList);
		result.put("pointAllList", pointAllList);
		return result;
	}
	
	public Map<String, Object> pointUpdate(String id, String pointVal, String pointState) {
		logger.info("writeUpdate service pointState=" + pointState);
		if(pointState.equals("충전")) {
			memberDAO.pointPlusUpdate(id, pointVal);
		}else if(pointState.equals("차감")) {
			memberDAO.pointMinusUpdate(id, pointVal);
		}
		
		memberDAO.pointInsert(id, pointVal, pointState);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("result", true);
		return map;
	}

}