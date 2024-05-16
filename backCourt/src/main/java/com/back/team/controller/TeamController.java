package com.back.team.controller;

import java.util.HashMap;
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
import org.springframework.web.multipart.MultipartFile;

import com.back.team.dto.TeamDTO;
import com.back.team.service.TeamService;

@Controller
public class TeamController {

	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired TeamService teamService;
	
	@RequestMapping(value = "/team")
	public String official() {
		return "redirect:/team/info_list.go";
	}
	
	@RequestMapping(value = "/team/info_list.go")
	public String listGo(HttpSession session, Model model, int team_idx) {
		logger.info("info_list.go /");
		String id = (String) session.getAttribute("loginId");
		
		TeamDTO dto = teamService.teamDetail(team_idx);
		model.addAttribute("info", dto);
		model.addAttribute("id", id);
		
		logger.info(dto.getId());
		logger.info(id);
		
		return "team/info_list";
	}
	
	// 리스트
	@RequestMapping(value = "/team/info_list.ajax", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> callList(HttpSession session, String currentPage, int team_idx) {
		logger.info("listCall / currentPage = {} / team_idx = {} / ", currentPage, team_idx);
		int page = Integer.parseInt(currentPage);
		String id = (String) session.getAttribute("loginId");
		Map<String, Object> map = teamService.list(page, team_idx, id);

		return map;
	}
	
	// 유저 상세 팝업
	@RequestMapping(value = "/team/user_pop.ajax", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> userPop(String userId) {
		logger.info("listCall / userId = {} / ", userId);
		
		TeamDTO list = teamService.userPop(userId);
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("list", list);
		
		return map;
	}
	
	// 회원 추방
	@RequestMapping(value = "/team/drop_member.ajax", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> dropMember(int team_idx, String userId) {
		logger.info("listCall / team_idx = {} / ", team_idx);
		logger.info("listCall / userId = {} / ", userId);
		int row = teamService.dropMember(team_idx, userId);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("list", row);
		
		return map;
	}
	
	// 신청 수락, 거부
	@RequestMapping(value = "/team/appli_member.ajax", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> appliMember(int team_idx, String userId, int idx, int num) {
		logger.info("listCall / team_idx = {} / ", team_idx);
		logger.info("listCall / userId = {} / ", userId);
		logger.info("listCall / idx = {} / ", idx);
		logger.info("listCall / num = {} / ", num);
		
		int row = teamService.appliMember(team_idx, userId, idx, num);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("row", row);
		
		return map;
	}
	
	// 팀, 게스트 모집글 삭제
	@RequestMapping(value = "/team/delete_write.ajax", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> delteWrite(int idx, int num) {
		logger.info("listCall / idx = {} / ", idx);
		logger.info("listCall / num = {} / ", num);
		
		int row = teamService.delteWrite(idx, num);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("row", row);
		
		return map;
	}
	
	// 팀 삭제
	@RequestMapping(value = "/team/destroy_team.ajax", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> destroyTeam(HttpSession session, int team_idx) {
		logger.info("listCall / team_idx = {} / ", team_idx);
		String id = (String) session.getAttribute("loginId");
		int row = teamService.destroyTeam(team_idx, id);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("row", row);
		
		return map;
	}
	
	@RequestMapping(value = "/team/create.go")
	public String createTeam(HttpSession session, Model model) {
		logger.info("create.go /");
		return "team/create";
	}
	
	@RequestMapping(value = "/team/create.do", method = RequestMethod.POST)
	public String createComplete(MultipartFile photo, HttpSession session, @RequestParam Map<String, String> param) {
		logger.info("팀 만들기 요청");
		String page = "login";
		String id = (String) session.getAttribute("loginId");
		int idx = 0;
		
		if(id != null) {
			idx = teamService.createComplete(photo, param, id);
			page = "redirect:/team/info_list.go?team_idx=" + idx;
		}
		
		return page;
	}
	
}



























