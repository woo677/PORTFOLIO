package com.back.teammate.dao;

import java.util.List;

import com.back.teammate.dto.TeammateDTO;

public interface TeammateDAO {

	List<TeammateDTO> list(int start);

	List<TeammateDTO> listFilterLevel(int start, String level);

	List<TeammateDTO> listFilterPosition(int start, String position);

	List<TeammateDTO> listFilterPosotionLevel(int start, String position, String level);

	List<TeammateDTO> listFilterAddress(int start, String address);

	List<TeammateDTO> listFilterAddressLevel(int start, String address, String level);

	List<TeammateDTO> listFilterAddressPosition(int start, String address, String position);

	List<TeammateDTO> listFilterAddressPositionLevel(int start, String address, String position, String level);

	List<TeammateDTO> allList();

	int allTeammateCount();

	int levelFilteringTeammateCount(String level);

	int positionFilteringTeammateCount(String position);

	int positionLevelFilteringTeammateCount(String position, String level);

	int addressFilteringTeammateCount(String address);

	int addressLevelFilteringTeammateCount(String address, String level);

	int addressPositionFilteringTeammateCount(String address, String position);

	int allFilteringTeammateCount(String address, String position, String level);

	
	
	int addressFilteringCount(String teammateSearchWord);

	int teamnameFilteringCount(String teammateSearchWord);

	int representFilteringCount(String teammateSearchWord);

	List<TeammateDTO> addressSearchList(String teammateSearchWord, int start);

	List<TeammateDTO> teamnameSearchList(String teammateSearchWord, int start);

	List<TeammateDTO> representSearchList(String teammateSearchWord, int start);

	TeammateDTO teammateDetail(String join_team_idx);

	boolean teammateJoin(String joinTeamIdx, String id, String join_state);

	int duplicateChk(String joinTeamIdx, String id);

	int callMyteamInfo(String id);

	int teammateWrite(TeammateDTO dto);

	TeammateDTO teammateWriteInfo(int team_idx);

	TeammateDTO teammateModify(int join_team_idx);

	void writeUpdate(String teammate_info, String teammate_gender, String teammate_level, String teammate_position,
			int join_team_idx);

	TeammateDTO modifyDetail(int idx);

	String teamName(String joinTeamIdx);

	void sendNotice(String msg, String id);

	String teamId(String joinTeamIdx);


}