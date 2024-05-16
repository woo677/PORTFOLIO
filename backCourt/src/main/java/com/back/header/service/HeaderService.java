package com.back.header.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.back.header.dao.HeaderDAO;
import com.back.header.dto.HeaderDTO;
import com.back.member.dto.MemberDTO;

@Service
public class HeaderService {

	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired HeaderDAO headerdao;
	
	public List<HeaderDTO> teamList(String id) {
		
		return headerdao.teamList(id);
	}

	public List<HeaderDTO> noticeList(String id) {
		
		return headerdao.noticeList(id);
	}

	public int del(String idx) {
		return headerdao.del(idx);
	}

	public HeaderDTO count(String id) {
		return headerdao.count(id);
	}

	public MemberDTO nav(String id) {
		
		return headerdao.nav(id);
	}
	
}
















