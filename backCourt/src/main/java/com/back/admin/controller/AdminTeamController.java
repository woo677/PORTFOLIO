package com.back.admin.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.back.admin.dto.AdminTeamDTO;
import com.back.admin.service.AdminTeamService;

@Controller
public class AdminTeamController {

	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired
	AdminTeamService adminTeamService;

	@RequestMapping(value = "/admin/team_list.go")
	public String listGo() {
		logger.info("팀관리 리스트 페이지 접속");
		return "/admin/team_list";
	}

	@RequestMapping(value = "/admin/teamList.ajax")
	@ResponseBody
	public Map<String, Object> teamList(@RequestParam Map<String, Object> param) {
		logger.info("팀리스트 in param : {}", param);
		return adminTeamService.teamList(param);
	}

	@RequestMapping(value = "/admin/team_detail.go")
	public String detailGo(HttpSession session, String teamIdx, Model model) {
		logger.info("teamDetailPage Controller 접속");
		adminTeamService.teamInfo(teamIdx, model);
		return "/admin/team_detail";
	}

	@RequestMapping(value = "/admin/teammateList.ajax")
	@ResponseBody
	public Map<String, Object> teammateList(String teamIdx, String currentPage) {
		return adminTeamService.teammateList(teamIdx, currentPage);
	}
	
	
	@RequestMapping(value = "/admin/teamUpdate.ajax")
	@ResponseBody
	public Map<String, Boolean> teamUpdate(@RequestParam Map<String, Object> param){
		logger.info("teamUpdate param : {}",param);
		return adminTeamService.teamUpdate(param);
	}
	
	// 팀원 모집글 상세보기
	@RequestMapping(value = "/admin/team_member_update.go")
	public String teamMemberDetailGo(String join_team_idx, Model model) {
		logger.info("팀원모집 상세 페이지 접속");
		
		AdminTeamDTO dto = adminTeamService.teamMemberDetail(join_team_idx);
		
		model.addAttribute("info", dto);
		
		return "/admin/team_member_update";
	}
	
	// 팀원 모집글 수정
	@RequestMapping(value = "/admin/team_member_update/update.ajax")
	@ResponseBody
	public Map<String, Object> teamMemberUpdateGo(String join_team_idx, String requInfo, String level, String teamIsDisabled) {
		logger.info("팀원모집 수정 요청");
		logger.info("requInfo : {}, level : {}", requInfo, level);
		logger.info("teamIsDisabled : {}, join_team_idx : {}", teamIsDisabled, join_team_idx);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		int row = adminTeamService.teamMemberUpdate(join_team_idx, requInfo, level, teamIsDisabled);
		map.put("row", row);
		logger.info(String.valueOf(row));
		
		return map;
	}
	
	
}
































