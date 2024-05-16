package com.back.member.dao;

import java.util.Map;

import com.back.member.dto.MemberDTO;

public interface MemberDAO {

	String loginId(String id, String pw);

	int Join(Map<String, String> param);

	int overlay(String id);
	
	// 고객, 관리자 구별
	MemberDTO loginperm(String id, String pw);

}
