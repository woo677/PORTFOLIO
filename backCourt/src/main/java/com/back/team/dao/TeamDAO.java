package com.back.team.dao;

import java.util.List;

import com.back.team.dto.TeamDTO;

public interface TeamDAO {

	TeamDTO teamDetail(int team_idx);

	List<TeamDTO> listTeam(int start, int team_idx);

	int teamTotal(int team_idx);

	List<TeamDTO> listAppli(int start, int team_idx);

	int appliTotal(int team_idx);

	List<TeamDTO> listWriteTeam(int team_idx, String id);

	List<TeamDTO> listWriteGuest(int start, int team_idx, String id, int limitNum);

	int writeTotal(int team_idx, String id);

	List<TeamDTO> listDrop(int start, int team_idx);

	int dropTotal(int team_idx);

	TeamDTO userPop(String userId);

	String teamName(int team_idx);
	
	void dropList(int team_idx, String userId);
	
	int dropMember(int team_idx, String userId);

	void sendNotice(String msg, String userId);

	void intoTeam(int team_idx, String userId);

//	int delJoinList(int idx);

	int delTeamWrite(int idx);

	int delGuestWrite(int idx);

	List<String> searchTeam(int team_idx);
	
	int destroyTeam(int team_idx, String id);

	int createComplete(TeamDTO dto);

	int insertTeamList(String id, int idx);
	
	void updateLogo(String newFileName, int idx);

	void updateStateYes(int idx);

	void updateStateNo(int idx);

	List<TeamDTO> listAppliGuest(int start, int team_idx);

	int appliGuestTotal(int team_idx);


}












