package com.back.admin.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.back.admin.service.AdminWriteService;

@Controller
public class AdminWriteController {

	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired
	AdminWriteService adminWriteService;

	@RequestMapping(value = "/admin/officialWrite.go")
	public String officialWriteGo(HttpSession session) {
//		String isAdmin = (String) session.getAttribute("isAdmin");
//		if (isAdmin == null ||isAdmin.isEmpty()) {
//			return "redirect:/login.go";
//		}
		return "/admin/official_write";
	}

	@RequestMapping(value = "/admin/callCourtList.ajax", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> callCourtList(String currentPage, String searchWord) {
		logger.info("::::::::::::callCourtList in:::::::::::::");
		logger.info("param currentPage = " + currentPage);
		logger.info("param searchWord = " + searchWord);

		Map<String, Object> map = adminWriteService.callCourtList(Integer.parseInt(currentPage), searchWord);

		logger.info("::::::::::::callCourtList out:::::::::::::");
		return map;
	}

//	@RequestMapping(value = "/admin/callCourtInfo.ajax")
//	public Map<String, Object> callCourtInfo(String courtIdx) {
//		return adminWriteService.callCourtInfo(courtIdx);
//	}
	
	// 공식 경기 리스트 접속
	@RequestMapping(value = "/admin/writing_official_list.go")
	public String listGo() {
		logger.info("공식 경기 리스트 접속");
		return "/admin/writing_official_list";
	}
	
	// 게스트 리스트 가져오기
	@RequestMapping(value = "/admin/writing_official_list/list.ajax", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> guestList(String address, String currentPage,
			String level, String searchWord, String searchFlag) {
		logger.info("공식경기 리스트 아작스 요청");
		
		return adminWriteService.officialList(Integer.parseInt(currentPage), searchFlag, searchWord, address, level);

	}
	
	// 팀 리스트 접속
	@RequestMapping(value = "/admin/writing_team_list.go")
	public String teamListGo() {
		logger.info("공식 경기 리스트 접속");
		return "/admin/writing_team_list";
	}
	
	@RequestMapping(value = "/admin/writing_team_list/list.ajax", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> callTeamList(@RequestParam Map<String, Object> param) {
		logger.info("listCall / param = {} / ", param);

		return adminWriteService.teamList(param);

	}
	
	// 게스트 리스트 접속
	@RequestMapping(value = "/admin/writing_guest_list.go")
	public String guestListGo() {
		logger.info("공식 경기 리스트 접속");
		return "/admin/writing_guest_list";
	}
	
	@RequestMapping(value = "/admin/writing_guest_list/list.ajax", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> callGuestList(@RequestParam Map<String, Object> param) {
		logger.info("listCall / param = {} / ", param);

		return adminWriteService.guestList(param);

	}
	
	@RequestMapping(value = "/admin/callCourtInfo.ajax", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> callCourtInfo(String courtIdx, String selectDate) {
		return adminWriteService.callCourtInfo(courtIdx, selectDate);
	}

	@RequestMapping(value = "/admin/officialWrite.ajax")
	@ResponseBody
	public Map<String, Boolean> officialWrite(@RequestParam Map<String, Object> param) {
		return adminWriteService.officialWrite(param);
	}

	@RequestMapping(value = "/admin/officialUpdate.go")
	public String officialUpdateGo(HttpSession session, Model model, String officialIdx) {
//		String isAdmin = (String) session.getAttribute("isAdmin");
//		if (isAdmin == null ||isAdmin.isEmpty()) {
//			return "redirect:/login.go";
//		}
		adminWriteService.officialUpdateGo(model, officialIdx);
		model.addAttribute("officialIdx", officialIdx);
		return "/admin/official_update";
	}

	@RequestMapping(value = "/admin/officialUpdate.ajax", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Boolean> officialUpdate(@RequestParam Map<String, Object> param) {
		logger.info("officialUpdate Controller param = {}", param);
		return adminWriteService.officialUpdate(param);

	}
	
	// 게스트 모집 글 수정 이동
	@RequestMapping(value = "/admin/guestUpdate.go")
	public String guestUpdateGo(HttpSession session, Model model, String guestIdx) {
//		String isAdmin = (String) session.getAttribute("isAdmin");
//		if (isAdmin == null ||isAdmin.isEmpty()) {
//			return "redirect:/login.go";
//		}
		adminWriteService.guestUpdateGo(model, guestIdx);
		model.addAttribute("guestIdx", guestIdx);
		return "/admin/guest_update";
	}
	
	// 게스트 모집 글 수정 - 코트 리스트 부르기
	@RequestMapping(value = "/admin/callGuestCourtList.ajax", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> callGuestCourtList(String currentPage, String searchWord) {
		logger.info("::::::::::::callCourtList in:::::::::::::");
		logger.info("param currentPage = " + currentPage);
		logger.info("param searchWord = " + searchWord);

		Map<String, Object> map = adminWriteService.callGuestCourtList(Integer.parseInt(currentPage), searchWord);

		logger.info("::::::::::::callCourtList out:::::::::::::");
		return map;
	}
	
	// 게스트 모집 글 수정 - 코트 정보
	@RequestMapping(value = "/admin/callGuestCourtInfo.ajax", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> callGuestCourtInfo(String courtIdx, String selectDate) {
		return adminWriteService.callGuestCourtInfo(courtIdx, selectDate);
	}

	// 게스트 모집 글 수정 완료시
	@RequestMapping(value = "/admin/guestUpdate.ajax", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Boolean> guestUpdate(@RequestParam Map<String, Object> param) {
		logger.info("officialUpdate Contoroller param = {}", param);
		return adminWriteService.guestUpdate(param);

	}
}
























