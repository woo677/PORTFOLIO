package com.back.admin.dao;

import java.util.List;
import java.util.Map;

import com.back.admin.dto.AdminTeamDTO;

public interface AdminTeamDAO {

	List<AdminTeamDTO> list(Map<String, Object> param);

	int totalPage(Map<String, Object> param);

	List<AdminTeamDTO> teammateList(String teamIdx, int i);

	AdminTeamDTO teamInfo(String teamIdx);

	int teammateTotal(String teamIdx);

	Boolean teamUpdate(Map<String, Object> param);

	String teamLogoName(Map<String, Object> param);

	Boolean teamLogoUpdate(Map<String, Object> param);

	AdminTeamDTO teamMemberDetail(String join_team_idx);

	int teamMemberUpdate(String join_team_idx, String requInfo, String level, String teamIsDisabled);

}
