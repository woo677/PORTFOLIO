package com.back.member.service;

import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.back.member.dao.MemberDAO;
import com.back.member.dto.MemberDTO;

@Service
public class MemberService {

	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired MemberDAO memberDAO;
	
	public String login(String id, String pw) {
		logger.info("로그인 서비스 접근");
		String loginId = memberDAO.loginId(id,pw);
		logger.info("loginId : "+loginId);
		return loginId;
	}
	public int Join(Map<String, String> param) {
		int row = memberDAO.Join(param);
		return row;
	}
	
	public Object overlay(String id) {	
		return memberDAO.overlay(id);
	}
	
	// 고객, 관리자 구별
	public MemberDTO loginperm(String id, String pw) {
		
		return memberDAO.loginperm(id,pw);
	}
	
}
