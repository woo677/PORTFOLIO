package com.back.admin.service;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.back.admin.dao.AdminTeamDAO;
import com.back.admin.dto.AdminTeamDTO;

@Service
public class AdminTeamService {

	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired
	AdminTeamDAO adminTeamDAO;

	String macRoot = "/Users/chaehyeonpark/Documents/gdj78_backcourt/upload/court/";

	String winRoot = "C:/upload/court/";

	public Map<String, Object> teamList(Map<String, Object> param) {
		logger.info("teamList service in");
		Map<String, Object> map = new HashMap<String, Object>();
		int start = (Integer.parseInt((String) param.get("currentPage")) - 1) * 10;
		param.put("start", start);
		map.put("list", adminTeamDAO.list(param));
		int totalPage = adminTeamDAO.totalPage(param);
		map.put("totalPage", totalPage % 10 > 0 ? totalPage / 10 + 1 : totalPage / 10);
		logger.info("param={}", param);

		return map;
	}

	public void teamInfo(String teamIdx, Model model) {
		List<AdminTeamDTO> list = adminTeamDAO.teammateList(teamIdx, 0);
		for (AdminTeamDTO adminTeamDTO : list) {
			logger.info("list id = " + adminTeamDTO.getId());
		}
		AdminTeamDTO adminTeamDTO = adminTeamDAO.teamInfo(teamIdx);
		int totalPage = adminTeamDAO.teammateTotal(teamIdx);
		model.addAttribute("teamInfo", adminTeamDTO);
		model.addAttribute("list", list);
		model.addAttribute("totalPage", totalPage % 10 > 0 ? totalPage / 10 + 1 : totalPage / 10);

	}

	public Map<String, Object> teammateList(String teamIdx, String currentPage) {
		Map<String, Object> map = new HashMap<String, Object>();
		int start = (Integer.parseInt(currentPage) - 1) * 10;
		map.put("list", adminTeamDAO.teammateList(teamIdx, start));
		return map;
	}

	public Map<String, Boolean> teamUpdate(Map<String, Object> param) {
		Map<String, Boolean> result = new HashMap<String, Boolean>();
		result.put("result", adminTeamDAO.teamUpdate(param));
		String logoFlag = (String)param.get("logoFlag");
		
		logger.info("logoFlag = "+ logoFlag);
		if (logoFlag.contains("true")) {
			logger.info("logoFlag = "+ logoFlag);	
			String fileName = adminTeamDAO.teamLogoName(param);
			teamLogoDelete(fileName);
			result.put("result", adminTeamDAO.teamLogoUpdate(param));
		}
		return result;
	}

	public void teamLogoDelete(String fileName) {
		String os = System.getProperty("os.name").toLowerCase();

		logger.info(os);
		String directory = "";
		if (os.contains("mac")) {
			directory = macRoot;
		} else if (os.contains("win")) {
			directory = winRoot;
		}

		File file = new File(directory + fileName);
		if (file.exists()) {
			file.delete();
		}

	}

	public AdminTeamDTO teamMemberDetail(String join_team_idx) {
		
		return adminTeamDAO.teamMemberDetail(join_team_idx);
	}

	public int teamMemberUpdate(String join_team_idx, String requInfo, String level, String teamIsDisabled) {
		return adminTeamDAO.teamMemberUpdate(join_team_idx, requInfo, level, teamIsDisabled);
	}

}




















