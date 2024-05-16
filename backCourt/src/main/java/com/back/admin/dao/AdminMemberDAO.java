package com.back.admin.dao;

import java.util.List;

import com.back.admin.dto.AdminMemberDTO;

public interface AdminMemberDAO {

	List<AdminMemberDTO> list(int start);

	List<AdminMemberDTO> allList();

	List<AdminMemberDTO> listFilterState(int start, String state);

	int allStateCount();

	int filteringStateCount(String state);

	List<AdminMemberDTO> idSearchList(String memberSearchWord, int start);

	Object searchMemberIdCount(String memberSearchWord);

	AdminMemberDTO detailLoad(String memberId);

	AdminMemberDTO memberDetail(String memberId);

	void writeUpdate(String memberName, String memberPass, String memberLevel, String memberAddress,
			String memberGender, String memberPosition, String memberState, String memberId);

	List<AdminMemberDTO> pointDetail(String id);

	AdminMemberDTO memberPoint(String id);

	List<AdminMemberDTO> pointAllList();

	int pointAllCount();

	List<AdminMemberDTO> pointList(int start);

	void pointPlusUpdate(String id, String pointVal);

	void pointMinusUpdate(String id, String pointVal);

	void pointInsert(String id, String pointVal, String pointState);


}