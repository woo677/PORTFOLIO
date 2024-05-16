package com.back.teammate.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.back.teammate.dto.TeammateDTO;
import com.back.teammate.service.TeammateService;

@Controller
public class TeammateController {

	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired
	TeammateService teammateService;

	// 팀원 모집 게시판 입장
	@RequestMapping(value = "/teammate")
	public String teammate() {
		logger.info("팀메이트 접속");
		return "redirect:/teammate/join_list.go";
	}

	@RequestMapping(value = "/teammate/join_list.go")
	public String teammateGo(HttpSession session, Model model) {
		logger.info("teammate_join_list.go /");

		if (session.getAttribute("loginId") != null) {
			model.addAttribute("chk", "on");
		} else {
			model.addAttribute("chk", "notOn");
		}
		return "teammate/join_list";
	}

	// 팀원 리스트 페이징 처리
	@RequestMapping(value = "/teammate/teammatePage.ajax", method = RequestMethod.POST)
	@ResponseBody // response 객체로 반환
	public Map<String, Object> callList(String currentPage, String address, String position, String level) {
		logger.info("페이징컨트롤");
		int page = Integer.parseInt(currentPage);
		Map<String, Object> map = teammateService.pageList(page, address, position, level);

		return map;

	}

	@RequestMapping(value = "/teammate/teammateSearchList.ajax", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> searchList(String currentPage, String teammateSearchCategory, String teammateSearchWord,
			String searchFlag, String address, String id, String teamName) {
		logger.info("listCall / currentPage = {} / address = {} / ", currentPage, address);
		logger.info("서치리스트");
		int page = Integer.parseInt(currentPage);
		Map<String, Object> map = teammateService.searchList(teammateSearchCategory, teammateSearchWord, page, address,
				id, teamName);

		return map;
	}

	// 팀원모집 상세보기
	@RequestMapping(value = "/teammate/join_info.go")
	public String detail(HttpSession session, Model model, String join_team_idx) {
		logger.info("팀원모집상세보기입장이요");
		logger.info("join_team_idx : {}", join_team_idx);
		String page = "../login";
		page = "teammate/join_info";
		if (session.getAttribute("loginId") != null) {
			page = "teammate/join_info";
			teammateService.teammateDetail(join_team_idx, model);
		} else {
			model.addAttribute("msg", "로그인이 필요한 서비스입니다.");
		}
		model.addAttribute("join_team_idx", join_team_idx);
		return page;
	}

	@RequestMapping(value = "/teammate/teammateJoin.ajax", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> teammateJoin(HttpSession session, String joinTeamIdx) {
		logger.info("팀원가입신청할게요" + session.getAttribute("loginId"));
		logger.info("join_team_idx : {}", joinTeamIdx);
		String id = (String) session.getAttribute("loginId");
		return teammateService.teammateJoin(joinTeamIdx, id, "대기중");
	}

	// 팀원모집글 작성페이지
	@RequestMapping(value = "/teammate/join_write.go")
	public String guestWriteGo(Model model, int team_idx) {
		logger.info("팀원 모집글 작성페이지 접속");

		TeammateDTO dto = teammateService.teammateWriteInfo(team_idx);
		logger.info("teammateWrite확인");
		model.addAttribute("info", dto);

		return "/teammate/join_write";
	}

	// 팀원 모집 작성란 폼
	@RequestMapping(value = "/teammate/join_write.do", method = RequestMethod.POST)
	public String teammateWrite(HttpSession session, String teammate_info, String teammateTO, String teammateLevel,
			String teammateGender, String teammatePosition, String teammateState) {
		// 로거 확인
		// 리스트페이지로 바꿔야함
		String page = "/teammate/join_write";
		String id = (String) session.getAttribute("loginId");
//		String id = "mit";
		int team_idx = teammateService.callMyteamInfo(id);
		logger.info("팀원모집글 올리는 team_idx={}" + team_idx + " id={} " + id);

		logger.info(" teammateWrite 값 확인 = {}" + team_idx);
		logger.info(" teammateWrite 값 확인 = {}" + teammate_info);
		logger.info(" teammateWrite 값 확인 = {}" + teammateLevel);
		logger.info(" teammateWrite 값 확인 = {}" + teammateGender);
		logger.info(" teammateWrite 값 확인 = {}" + teammatePosition);

		TeammateDTO dto = new TeammateDTO();
		dto.setTeam_idx(team_idx);
		dto.setJoin_team_content(teammate_info);
		dto.setJoin_team_level(teammateLevel);
		dto.setJoin_team_gender(teammateGender);
		dto.setJoin_team_position(teammatePosition);
//		
//		Map<String, Object> map = new HashMap<>();
//		map.put("id", id);
//		map.put("team_idx", team_idx);
//		map.put("teammateTO", teammateTO);
//		map.put("teammateContent", teammate_info);
//		map.put("teammateLevel", teammateLevel);
//		map.put("teammateGender", teammateGender);
//		map.put("teammatePosition", teammatePosition);
//		map.put("teammateState", teammateState);

		int row = teammateService.teammateWrite(dto);
		logger.info("insert 후 idx : " + dto.getJoin_team_idx());
		if (row >= 1) {
			page = "redirect:/teammate/join_info.go?join_team_idx=" + dto.getJoin_team_idx();
		}

		return page;
	}
	
	// 팀원모집 수정페이지 접속
	@RequestMapping(value = "/teammate/join_modify")
	public String teammateModify(int idx, Model model) {
		logger.info("팀원 모집글 수정페이지 접속");
		
		TeammateDTO dto = teammateService.modifyDetail(idx);
		model.addAttribute("modiDto",dto);
		model.addAttribute("idx", idx);
		
		return "/teammate/join_modify";
	}

	// 팀원모집 수정페이지 불러오기
	@RequestMapping(value = "/teammate/teammateModify.ajax", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, TeammateDTO> teammateModify(int join_team_idx) {

		logger.info("수정페이지 join_team_Idx : " + join_team_idx);

		return teammateService.teammateModify(join_team_idx);
	}

	// 수정페이지 작성완료
	@RequestMapping(value = "/teammate/teammateUpdate.ajax", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> writeUpdate(String teammate_info, String teammate_gender, String teammate_level,
			String teammate_position, int join_team_idx) {
		logger.info("teammateUpdate " + teammate_info + " " + teammate_gender);
		logger.info("teammateUpdate " + teammate_level + " " + teammate_position);
		logger.info("teammateUpdate " + join_team_idx);
		return teammateService.writeUpdate(teammate_info, teammate_gender, teammate_level, teammate_position,join_team_idx);
	}
	
}